import 'dart:collection';
import 'dart:developer' as dev;
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flappy_game/game_state.dart';
import 'package:flutter/painting.dart';

class GameScore extends PositionComponent {
  late Map<String, Sprite> digits;
  late SpriteComponent digit0;
  late SpriteComponent digit1;
  late SpriteComponent digit2;

  GameScore() : super(priority: 3);

  @override
  Future<void>? onLoad() async{

    digits = HashMap.from({
    "0" : SpriteSheet(
    image: await Flame.images.load('sprites.png'), srcSize: Vector2(12, 18))
        .getSprite(0, 0)
    ..srcPosition = Vector2(496, 60),
    "1" : SpriteSheet(
    image: await Flame.images.load('sprites.png'), srcSize: Vector2(12, 18))
        .getSprite(0, 0)
    ..srcPosition = Vector2(136, 455),
    "2" : SpriteSheet(
    image: await Flame.images.load('sprites.png'), srcSize: Vector2(12, 18))
        .getSprite(0, 0)
    ..srcPosition = Vector2(292, 160),
    "3" : SpriteSheet(
    image: await Flame.images.load('sprites.png'), srcSize: Vector2(12, 18))
        .getSprite(0, 0)
    ..srcPosition = Vector2(306, 160),
    "4" : SpriteSheet(
    image: await Flame.images.load('sprites.png'), srcSize: Vector2(12, 18))
        .getSprite(0, 0)
    ..srcPosition = Vector2(320, 160),
    "5" : SpriteSheet(
    image: await Flame.images.load('sprites.png'), srcSize: Vector2(12, 18))
        .getSprite(0, 0)
    ..srcPosition = Vector2(334, 160),
    "6" : SpriteSheet(
    image: await Flame.images.load('sprites.png'), srcSize: Vector2(12, 18))
        .getSprite(0, 0)
    ..srcPosition = Vector2(292, 184),
    "7" : SpriteSheet(
      image: await Flame.images.load('sprites.png'), srcSize: Vector2(12, 18))
          .getSprite(0, 0)
      ..srcPosition = Vector2(306, 184),
    "8" : SpriteSheet(
    image: await Flame.images.load('sprites.png'), srcSize: Vector2(12, 18))
        .getSprite(0, 0)
    ..srcPosition = Vector2(320, 184),
    "9" : SpriteSheet(
    image: await Flame.images.load('sprites.png'), srcSize: Vector2(12, 18))
        .getSprite(0, 0)
    ..srcPosition = Vector2(334, 184)
    });


    digit0 = SpriteComponent(sprite: digits["0"], position: Vector2(200, 100), size: Vector2(12, 18), scale: Vector2(4,4));
    digit1 = SpriteComponent(sprite: digits["0"], position: Vector2(260, 100), size: Vector2(12, 18), scale: Vector2(4,4));
    digit2 = SpriteComponent(sprite: digits["0"], position: Vector2(320, 100), size: Vector2(12, 18), scale: Vector2(4,4));

    add(digit0);
    add(digit1);
    add(digit2);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    switch(gameState){
      case GameState.start:

        String scoresInStr = score.toString().padLeft(3, "0");
        //dev.log("scoresInStr : ${scoresInStr.toString()}");

        digit0.sprite = digits[scoresInStr[0]];
        digit1.sprite = digits[scoresInStr[1]];
        digit2.sprite = digits[scoresInStr[2]];

        break;
      case GameState.pause:
        break;
      case GameState.stop:
        break;
    }
  }
}