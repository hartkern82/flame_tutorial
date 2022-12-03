import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame_test/games/joystick/joystick_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:tiled/tiled.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class JoyStickGame extends FlameGame with HasDraggables {
  late final JoystickPlayer player;
  late final JoystickComponent joystick;
  late double mapWidth;
  late double mapHeight;
  late TiledComponent homeMap;

  void _loadJoystick() {
    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: knobPaint),
      background: CircleComponent(radius: 100, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );
    player = JoystickPlayer(joystick);
    add(player);
    add(joystick);
  }

  Future<void> _loadMap() async {
    homeMap = await TiledComponent.load('droidmap.tmx', Vector2(32, 32));
    add(homeMap);
    mapWidth = homeMap.tileMap.map.width * 32;
    mapHeight = homeMap.tileMap.map.height * 32;
    if (kDebugMode) {
      print('Map loaded');
    }
  }

  @override
  Future<void> onLoad() async {
    await _loadMap();
    overlays.add('GameMenu');
    _loadJoystick();
  }
}
