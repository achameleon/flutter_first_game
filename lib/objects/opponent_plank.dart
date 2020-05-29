import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame/components/component.dart';
import 'package:flutterflamegame/consts.dart';

class OppenentPlank extends SpriteComponent {

  OppenentPlank() : super.fromSprite(opponentPlankWidth, opponentPlankHeight, Sprite('plank.png'));

  @override
  void resize(Size size) {
    this.x = (size.width - this.width) / 2;
    this.y = opponentPlankDistation;
  }

}