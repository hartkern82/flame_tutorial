
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_test/common/gaming_ui_prefercenses.dart';
import 'package:flame_test/games/museum_exploration/museum_exploration_game_flame.dart';
import 'package:tiled/tiled.dart';

class StationComponent extends PositionComponent with HasGameRef<MuseumTileGame> {
  final TiledObject station;

  StationComponent(this.station);
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    position = Vector2(station.x, station.y);
    size = Vector2(station.width, station.height);
    add(RectangleHitbox());
    debugMode = GamingUIPrefercences.isDebugMode;
  }
}
