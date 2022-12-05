import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_test/common/gaming_ui_prefercenses.dart';
import 'package:flame_test/games/museum_exploration/museum_exploration_game_flame.dart';
import 'package:flame_test/games/museum_exploration/world/obstacle_component.dart';
import 'package:flame_test/games/museum_exploration/world/station_component.dart';
import 'package:flutter/foundation.dart';

class PlayerCharacter extends SpriteAnimationComponent with HasGameRef<MuseumTileGame>, CollisionCallbacks {
  final JoystickComponent joystick;
  late SpriteAnimation downAnimation;
  late SpriteAnimation leftAnimation;
  late SpriteAnimation rightAnimation;
  late SpriteAnimation upAnimation;
  late SpriteAnimation idleAnimation;
  late SpriteAnimation downLeftAnimation;
  late SpriteAnimation downRightAnimation;
  late SpriteAnimation upLeftAnimation;
  late SpriteAnimation upRightAnimation;
  late double playerVectorX;
  late double playerVectorY;
  JoystickDirection collidedDirection = JoystickDirection.idle;
  bool collided = false;

  PlayerCharacter(this.joystick) : super(size: Vector2.all(100.0), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(
      RectangleHitbox(
        position: Vector2.all(GamingUIPrefercences.characterSize / 2),
        size: Vector2(GamingUIPrefercences.characterSize / 2, GamingUIPrefercences.characterSize / 2),
      ),
    );
    debugMode = GamingUIPrefercences.isDebugMode;
    position = Vector2(500, 350);
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
  }

  @override
  void update(double dt) {
    super.update(dt);
    _joystickMovement(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is ObstacleComponent) {
      if (!collided) {
        if (kDebugMode) {
          print('hit obstacle');
        }
        collided = true;
        collidedDirection = joystick.direction;
      }
    } else if (other is StationComponent) {
      if (!collided) {
        if (kDebugMode) {
          print('hit station');
        }
        collided = true;
        collidedDirection = joystick.direction;
      }
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    collidedDirection = JoystickDirection.idle;
    collided = false;
  }

  _joystickMovement(double dt) {
    final bool moveLeft = joystick.direction == JoystickDirection.left;
    final bool moveRight = joystick.direction == JoystickDirection.right;
    final bool moveUp = joystick.direction == JoystickDirection.up;
    final bool moveDown = joystick.direction == JoystickDirection.down;
    playerVectorX = (joystick.relativeDelta * GamingUIPrefercences.characterSpeed * dt)[0];
    playerVectorY = (joystick.relativeDelta * GamingUIPrefercences.characterSpeed * dt)[1];

    // player is moving left
    if (moveLeft && x > 0) {
      if (!collided || collidedDirection == JoystickDirection.right) {
        x += playerVectorX;
        animation = leftAnimation;
      }
    }
    // player is moving right
    if (moveRight && x < gameRef.mapWidth) {
      if (!collided || collidedDirection == JoystickDirection.left) {
        x += playerVectorX;
        animation = rightAnimation;
      }
    }

    // player s moving up
    if (moveUp && y > 0) {
      if (!collided || collidedDirection == JoystickDirection.down) {
        y += playerVectorY;
        animation = upAnimation;
      }
    }

    // player s moving down
    if (moveDown && y < gameRef.mapHeight - height) {
      if (!collided || collidedDirection == JoystickDirection.up) {
        y += playerVectorY;
        animation = downAnimation;
      }
    }

    if (joystick.direction == JoystickDirection.idle) {
      animation = idleAnimation;
    }
  }
}
