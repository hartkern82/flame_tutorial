import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_test/common/gaming_ui_prefercenses.dart';
import 'package:flame_test/games/museum_exploration/actors/player_character.dart';
import 'package:flame_test/games/museum_exploration/museum_exploration_game_flame.dart';
import 'package:flutter/foundation.dart';

class NPCCharacter extends SpriteAnimationComponent with HasGameRef<MuseumTileGame>, CollisionCallbacks {
  late SpriteAnimation downAnimation;
  late SpriteAnimation leftAnimation;
  late SpriteAnimation rightAnimation;
  late SpriteAnimation upAnimation;
  late SpriteAnimation idleAnimation;
  late SpriteAnimation downLeftAnimation;
  late SpriteAnimation downRightAnimation;
  late SpriteAnimation upLeftAnimation;
  late SpriteAnimation upRightAnimation;
  bool collided = false;
  Vector2 startPosition = Vector2(250, 350);
  late SpriteAnimationComponent animationComponent;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(
      RectangleHitbox(
        // position: Vector2.all(GamingUIPrefercences.characterSize / 2),
        size: Vector2(GamingUIPrefercences.characterSize / 2, GamingUIPrefercences.characterSize / 2),
      ),
    );
    debugMode = GamingUIPrefercences.isDebugMode;
    position = startPosition;

    //load all animations
    final spriteSheet =
        SpriteSheet(image: await gameRef.images.load('george2.png'), srcSize: Vector2(48, 48));
    downAnimation = spriteSheet.createAnimation(row: 0, stepTime: GamingUIPrefercences.animationSpeed, to: 4);
    leftAnimation = spriteSheet.createAnimation(row: 1, stepTime: GamingUIPrefercences.animationSpeed, to: 4);
    upAnimation = spriteSheet.createAnimation(row: 2, stepTime: GamingUIPrefercences.animationSpeed, to: 4);
    rightAnimation =
        spriteSheet.createAnimation(row: 3, stepTime: GamingUIPrefercences.animationSpeed, to: 4);
    idleAnimation = spriteSheet.createAnimation(row: 0, stepTime: GamingUIPrefercences.animationSpeed, to: 1);
    downLeftAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: GamingUIPrefercences.animationSpeed, to: 4);
    downRightAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: GamingUIPrefercences.animationSpeed, to: 4);
    upLeftAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: GamingUIPrefercences.animationSpeed, to: 4);
    upRightAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: GamingUIPrefercences.animationSpeed, to: 4);
    animation = idleAnimation;
    final spriteSize = Vector2.all(100.0);

    //add the animationcomponent
    animationComponent = SpriteAnimationComponent(animation: animation, size: spriteSize);
    add(animationComponent);
  }

  @override
  void update(double dt) {
    super.update(dt);
    randomMovement(dt);
  }

  void randomMovement(double dt) {
    if (!collided) {
      double movementX = position.x + GamingUIPrefercences.npcSpeed * dt;
      position = Vector2(movementX, position.y);
      if (movementX > 500) {
        animationComponent.animation = rightAnimation; // change animation on the fly
      }
    } else {
      animationComponent.animation = idleAnimation;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is PlayerCharacter) {
      if (!collided) {
        if (kDebugMode) {
          print('hit by player');
        }
        collided = true;
      }
    }
  }
}
