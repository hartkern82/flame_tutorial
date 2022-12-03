import 'package:flame_test/games/joystick/joystick_game.dart';
import 'package:flutter/material.dart';

var appRoutes = <String, WidgetBuilder>{
  '/joysticktest': (context) => const JoystickTestGame(),
};
