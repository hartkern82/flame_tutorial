import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame_test/games/joystick/joystick_player.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class JoyStickGame extends FlameGame with HasDraggables {
  late final JoystickPlayer player;
  late final JoystickComponent joystick;

  Future<void> _loadJoystick() async {
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

  @override
  Future<void> onLoad() async {
    Future.delayed(
      Duration(milliseconds: 20),()=> overlays.add('GameMenu')
    );
   
    await _loadJoystick();
  }
}
