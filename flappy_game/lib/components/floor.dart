import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flappy_game/game_state.dart';
import 'package:flutter/painting.dart';

class Floor extends SpriteComponent {
  Floor(Vector2 position)
      : super(
          position: position,
          size: Vector2(168 * 4, 56 * 4),
        );

  @override
  Future<void>? onLoad() async{
    sprite = await Sprite.load('floor.png');

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

      // 왼쪽방향으로 계속 흐른다.
        floorMoveX = floor.x - floorSpeed;

        if (floorMoveX < -95) {
          // 바닥 위치 리셋
          floorMoveX = 0;
        }

        floor.x = floorMoveX;
        break;
      case GameState.pause:

        break;
      case GameState.stop:

        break;
    }
  }
}