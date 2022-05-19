import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flappy_game/components/pipe.dart';
import 'package:flutter/painting.dart';
import 'package:flappy_game/game_state.dart';
import 'floor.dart';

class Bird extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef {
  Bird()
      : super(
          position: Vector2(250, 400),
          size: Vector2.all(50),
          angle: 0,
          anchor: Anchor.center,
        );

  @override
  Future<void>? onLoad() async {
    final sprites = [0, 1, 2].map((i) => Sprite.load('bird_$i.png'));
    animation = SpriteAnimation.spriteList(await Future.wait(sprites), stepTime: 0.1);
    add(RectangleHitbox());

    final hitboxPaint = BasicPalette.white.paint()
      ..style = PaintingStyle.stroke;
    add(
      PolygonHitbox.relative(
        [
          Vector2(1.0, 1.0), // Middle of right wall
          Vector2(1.0, -1.0), // Middle of bottom wall
          Vector2(-1.0, -1.0), // Middle of top wall
          Vector2(-1.0, 1.0), // Middle of left wall
        ],
        parentSize: size,
      )
        ..paint = hitboxPaint
        ..renderShape = false,
    );
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    switch(gameState){
      case GameState.start:
        // 시간이 증가함에 따라 점점더 아래로 하강함
        timepassed += dt;
        yPosition = (gravity * timepassed) / 2;
        bird.y += yPosition;
        break;
      case GameState.pause:

        break;
      case GameState.stop:

        break;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    // 충돌 판정
    if(other is Pipe || other is Floor){
      gameState = GameState.stop;
    }
  }
}