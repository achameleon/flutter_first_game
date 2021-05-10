
import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'scenes/game_scene.dart';
import 'consts.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'services/server.dart';
import 'package:wifi/wifi.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  Util frameUtils = Util();
  frameUtils.setLandscape();
  SystemChrome.setEnabledSystemUIOverlays([]);
  Wifi.ip.then( (String ipString) {
      ip = InternetAddress(ipString);
      ipOther = InternetAddress(ipString);
      print('ip = $ip');
    }
  );
  GameScene game = GameScene();
  Widget widget = OrientationBuilder(
      builder: (context, orientation) {
        Flame.util.initialDimensions().then((Size size) {
          if (Orientation.portrait != null) {
            scrX = size.height;
            scrY = size.width;
            borB = size.height;
            borR = size.width;
          } else {
            scrX = size.width;
            scrY = size.height;
            borB = size.width;
            borR = size.height;
          }
        });
        return game.widget;
      }
  );
  runApp(widget);
}
