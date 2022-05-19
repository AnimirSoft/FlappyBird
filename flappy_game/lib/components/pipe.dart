import 'dart:developer' as dev;
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';

class Pipe extends SpriteComponent with CollisionCallbacks, HasGameRef{

  String imagePath = "";

  Pipe(String imagePath, Vector2 position) : super (
    position: position,
    size: Vector2(26 * 4, 160 * 4)
  ){
    this.imagePath = imagePath;
  }

  @override
  Future<void>? onLoad() async{
    sprite = await Sprite.load(imagePath);
    // add(RectangleHitbox());

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
}