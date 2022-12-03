import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame_test/games/joystick/joystick_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:tiled/tiled.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame_audio/flame_audio.dart';

class JoyStickGame extends FlameGame with HasDraggables {
  late final JoystickPlayer player;
  late final JoystickComponent joystick;
  late double mapWidth;
  late double mapHeight;
  late TiledComponent homeMap;
  late bool isplayingMusic;

  void _loadJoystick() {
    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 20, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 10, bottom: 10),
    );
    player = JoystickPlayer(joystick);
    add(player);
    add(joystick);
    _loadMusic();
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

  void _loadMusic() {
    FlameAudio.bgm.initialize();
    FlameAudio.audioCache.loadAll(['music.mp3']);
    FlameAudio.bgm.play('music.mp3');
    isplayingMusic = true;
    if (kDebugMode) {
      print('Music loaded');
    }
  }

  void pauseMusic() {
    if (FlameAudio.bgm.isPlaying) {
      FlameAudio.bgm.pause();
      isplayingMusic = false;
      if (kDebugMode) {
        print('Music paused');
      }
    } else {
      FlameAudio.bgm.resume();
      isplayingMusic = true;
      if (kDebugMode) {
        print('Music playing');
      }
    }
  }

  void stopMusic() {
    FlameAudio.bgm.stop();
    if (kDebugMode) {
      print('Music stopped');
    }
  }

  @override
  Future<void> onLoad() async {
    await _loadMap();

    _loadJoystick();
    overlays.add('GameMenu');
    _loadMusic();
  }
}
