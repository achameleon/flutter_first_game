
import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame/components/component.dart';
import 'package:flutterflamegame/consts.dart';

class Plank extends SpriteComponent {

  Plank() : super.fromSprite(plankWidth, plankHeight, Sprite('plank.png'));

  @override
  void resize(Size size) {
    this.x = (size.width - this.width) / 2;
    this.y = size.height - plankDistation;
  }

}