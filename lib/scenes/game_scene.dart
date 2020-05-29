
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

  @override
  void update(double t) {
    move();
  }

  void move() {
    _ball.x++;
    _ball.y++;
    if (_ball.x > 300) {
      _ball.x = 0;
      _ball.y = 0;
    }
  }

}