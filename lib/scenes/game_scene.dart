
import 'dart:ui';
import 'package:flame/game.dart';
import 'package:sensors/sensors.dart';
import 'package:flutterflamegame/consts.dart';
import 'package:flutterflamegame/objects/ball.dart';
import 'package:flutterflamegame/objects/opponent_plank.dart';
import 'package:flutterflamegame/objects/plank.dart';

class GameScene extends BaseGame {

  Size _screenSize;
  Ball _ball;
  Plank _plank;
  OppenentPlank _oppenentPlank;

  double _plankX, _ballX, _ballY;
  double _dx, _dy;

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

    _init();
  }

  void _init() {
    double x;
    accelerometerEvents.listen((event) {
      x = event.y + accelerometerMax / 2;
      if (x < 0) x = 0;
      if (x > accelerometerMax) x = accelerometerMax;
      _plankX = x * (scrX - _plank.width) / accelerometerMax;
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
    } else if (_ball.x > borR - ballDiameter) {
      _dx = -ballSpeed;
    } else if (_ball.y + ballDiameter <= borT) {
      _ball.y = borB;
    } else if (_ball.x + ballDiameter / 2 >= _plank.x &&
        _ball.x + ballDiameter / 2 <= _plank.x + plankWidth &&
        _ball.y >= borB - plankDistation - ballDiameter &&
        _ball.y <= borB - plankDistation - ballDiameter + plankHeight &&
        _dy > 0) {
      _dy = -ballSpeed;
    } else if (_ball.y >= borB) {
      _ball.y = -ballDiameter;
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
    _bounce();
  }

}