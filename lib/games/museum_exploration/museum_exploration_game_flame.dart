import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame_test/games/museum_exploration/actors/player_character.dart';
import 'package:flame_test/games/museum_exploration/world/obstacle_component.dart';
import 'package:flame_test/games/museum_exploration/world/station_component.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:tiled/tiled.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame_audio/flame_audio.dart';

class MuseumTileGame extends FlameGame with HasDraggables, HasCollisionDetection {
  late final PlayerCharacter player;
  late final JoystickComponent joystick;
  late double mapWidth;
  late double mapHeight;
  late TiledComponent museumGameMap;
  late bool isplayingMusic;

  void _loadObstacles() {
    final List<TiledObject> obstaclesGroup =
        museumGameMap.tileMap.getLayer<ObjectGroup>('obstacles')?.objects ?? [];
    for (TiledObject obj in obstaclesGroup) {
      add(ObstacleComponent(obj));
    }
    if (kDebugMode) {
      print('obstacles loaded');
    }
  }

  void _loadStations() {
    final List<TiledObject> stationsGroup =
        museumGameMap.tileMap.getLayer<ObjectGroup>('stations')?.objects ?? [];
    for (final obj in stationsGroup) {
      add(StationComponent(obj));
    }
    if (kDebugMode) {
      print('Stationbounds loaded');
    }
  }

  void _loadJoystick() {
    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 20, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 10, bottom: 10),
    );
    player = PlayerCharacter(joystick);
    add(player);
    add(joystick);
    camera.followComponent(player, worldBounds: Rect.fromLTRB(0, 0, mapWidth, mapHeight));
  }

  Future<void> _loadMap() async {
    museumGameMap = await TiledComponent.load('droidmap.tmx', Vector2(32, 32));
    add(museumGameMap);
    mapWidth = museumGameMap.tileMap.map.width * 32;
    mapHeight = museumGameMap.tileMap.map.height * 32;
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

  void toggleMusic() {
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
    _loadObstacles();
    _loadStations();
    _loadJoystick();
    overlays.add('GameMenu');
    _loadMusic();
  }
}
