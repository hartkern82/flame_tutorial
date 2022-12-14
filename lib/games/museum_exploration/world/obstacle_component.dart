import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_test/common/gaming_ui_prefercenses.dart';
import 'package:flame_test/games/museum_exploration/museum_exploration_game_flame.dart';
import 'package:tiled/tiled.dart';

class ObstacleComponent extends PositionComponent with HasGameRef<MuseumTileGame>, CollisionCallbacks {
  final TiledObject obstacle;

  ObstacleComponent(this.obstacle);
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    position = Vector2(obstacle.x, obstacle.y);
    size = Vector2(obstacle.width, obstacle.height);
    add(RectangleHitbox());
    debugMode = GamingUIPrefercences.isDebugMode;
  }
}
