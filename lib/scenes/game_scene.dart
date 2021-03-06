
import 'dart:ui';
import 'package:flame/game.dart';
import 'package:sensors/sensors.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutterflamegame/consts.dart';
import 'package:flutterflamegame/objects/ball.dart';
import 'package:flutterflamegame/objects/opponent_plank.dart';
import 'package:flutterflamegame/objects/plank.dart';
import 'package:flutterflamegame/services/server.dart';

class GameScene extends BaseGame {

  Size _screenSize;
  Ball _ball;
  Plank _plank;
  OppenentPlank _oppenentPlank;
  AudioCache _assetPlayer;
  Server _server;

  double _plankX, _ballX, _ballY;
  double _dx, _dy;

  double _plankOpponentX;
  String _dataOut;
  String _oldDataOut;

  GameScene() {
    _ball = Ball();
    _plank = Plank();
    _oppenentPlank = OppenentPlank();
    add(_ball);
    add(_plank);
    add(_oppenentPlank);

    _plankX = 0;
    _ballX = 0;
    _ballY = 0;
    _dx = ballSpeed;
    _dy = ballSpeed;

    _assetPlayer = AudioCache(prefix: "sounds/");
    _assetPlayer.loadAll([ bounceSound, winSound, loseSound ]);

    _server = Server(_processData);
    _plankOpponentX = 0;
    _oldDataOut = "";

    this._init();
  }

  void _init() {
    double x;
    accelerometerEvents.listen((event) {
      x = event.y + accelerometerMax / 2;
      if (x < 0) x = 0;
      if (x > accelerometerMax) x = accelerometerMax;
      _plankX = x * (scrX - _plank.width) / accelerometerMax;
      _sendData();
    });
  }

  void _drawBackground(Canvas canvas) {
    Rect gbRect = Rect.fromLTRB(0, 0, _screenSize.width, _screenSize.height);
    Paint gbPaint = Paint();
    gbPaint.color = backgroundColor;
    canvas.drawRect(gbRect, gbPaint);
  }

  void _move() {
    _ball.x++;
    _ball.y++;
    if (_ball.x > 300) {
      _ball.x = 0;
      _ball.y = 0;
    }
  }

  void _movePad(double x, double y) {
    _plank.x = x;
    _plank.y = y;
  }

  void _bounce() {
    _ball.x += _dx;
    _ball.y += _dy;
    if (_ball.x <= borL) {
      _dx = ballSpeed;
      _playAsset(bounceSound, volumeBounce);
    } else if (_ball.x > borR - ballDiameter) {
      _dx = -ballSpeed;
      _playAsset(bounceSound, volumeBounce);
    } else if (_ball.x + ballDiameter / 2 >= _oppenentPlank.x &&
        _ball.x + ballDiameter / 2 <= _oppenentPlank.x + plankWidth &&
        _ball.y <= borT + opponentPlankDistation + _oppenentPlank.height &&
        _ball.y >= borT + opponentPlankDistation + _oppenentPlank.height - opponentPlankHeight &&
        _dy < 0) {
      _dy = ballSpeed;
      _playAsset(bounceSound, volumeBounce);
    } else if (_ball.y + ballDiameter <= borT) {
      _ball.y = borB;
      _playAsset(winSound, volumeWin);
    } else if (_ball.x + ballDiameter / 2 >= _plank.x &&
        _ball.x + ballDiameter / 2 <= _plank.x + plankWidth &&
        _ball.y >= borB - plankDistation - ballDiameter &&
        _ball.y <= borB - plankDistation - ballDiameter + plankHeight &&
        _dy > 0) {
      _dy = -ballSpeed;
      _playAsset(bounceSound, volumeBounce);
    } else if (_ball.y >= borB) {
      _ball.y = -ballDiameter;
      _playAsset(loseSound, volumeLose);
    }
  }

  void _playAsset(String path, double volume) {
    _assetPlayer.play(path, volume: volume);
  }

  void _processData(String dataInput) {
    List<String> list = dataInput.split(" ");
    if (isClient && list.length < 5) return;
    if (!isClient && list.length < 3) return;
    scrXOther = double.parse(list[0]);
    scrYOther = double.parse(list[1]);
    _plankOpponentX = double.parse(list[2]);
    if (!isClient) return;
    _ballX = double.parse(list[3]);
    _ballY = double.parse(list[4]);
  }

  void _sendData() {
    _dataOut = '';
    _dataOut += '${scrX.toStringAsFixed(0)}';
    _dataOut += ' ${scrY.toStringAsFixed(0)}';
    _dataOut += ' ${_plankX.toStringAsFixed(0)}';
    if (!isClient) {
      _dataOut += ' ${_ball.x.toStringAsFixed(0)}';
      _dataOut += ' ${_ball.y.toStringAsFixed(0)}';
    }
    if (_dataOut.compareTo(_oldDataOut) != 0) {
      Server.sendData(_dataOut, ipOther, portSend);
      _oldDataOut = _dataOut;
    }
  }

  void _setPositionData() {
    if (scrXOther == 0 || scrYOther == 0) return;
    _oppenentPlank.x = scrX - (_oppenentPlank.width + _plankOpponentX) * scrX / scrXOther;
    _oppenentPlank.y = opponentPlankDistation;
    if (isClient) {
      _ball.x = scrX - (ballDiameter + _ballX) * scrX / scrXOther;
      _ball.y = scrY - (ballDiameter + _ballY) * scrY / scrYOther;
    }
  }

  @override
  void resize(Size size) {
    _screenSize = size;
    super.resize(size);
  }

  @override
  void render(Canvas canvas) {
    _drawBackground(canvas);
    super.render(canvas);
  }

  @override
  void update(double t) {
    _movePad(_plankX, borB - plankDistation);
    if (!isClient) {
      _bounce();
    }
    _setPositionData();
  }

}