
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'scenes/game_scene.dart';
import 'consts.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.util .initialDimensions().then((Size size) => {
    scrX = size.height,
    scrY = size.width,
    borB = size.width,
    borR = size.height
  });
  GameScene game = GameScene();
  runApp(game.widget);
}
