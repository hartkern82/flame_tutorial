import 'package:flame_test/games/museum_exploration/museum_exploration_game.dart';
import 'package:flutter/material.dart';

var appRoutes = <String, WidgetBuilder>{
  '/joysticktest': (context) => const MuseumExplorationGame(),
};
