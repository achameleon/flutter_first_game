
import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame/components/component.dart';
import 'package:flutterflamegame/consts.dart';

class Ball extends SpriteComponent {

  Ball() : super.fromSprite(ballDiameter, ballDiameter, Sprite('ball.png'));

  @override
  void resize(Size size) {
    this.x = 0;
    this.y = 0;
  }

}