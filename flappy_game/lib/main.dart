import 'dart:developer' as dev;
import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flappy_game/components/game_score.dart';
import 'package:flappy_game/components/player_bird.dart';
import 'package:flappy_game/components/ui_manager.dart';
import 'package:flappy_game/game_state.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/floor.dart';
import 'components/pipe.dart';

void main() async {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame with TapDetector, HasCollisionDetection {
  @override
  Future<void>? onLoad() async {


    // BG
    bg = SpriteComponent(sprite: SpriteSheet(image: await images.load('sprites.png'), srcSize: Vector2(144, 257)).getSprite(0, 0)..srcPosition = Vector2(0, 0), scale: Vector2.all(4));
    add(bg);

    // Bird
    bird = Bird();
    add(bird);

    // pipe
    double random = (Random().nextInt(6) + 4) * (Random().nextInt(90) + 50);
    pipeUp = Pipe('pipe_up.png', Vector2(600, (random - 900)));
    add(pipeUp);
    pipeDown = Pipe('pipe_down.png', Vector2(600, random));
    add(pipeDown);

    // floor
    floor = Floor(Vector2(0, 900));
    add(floor);

    add(UIMnager());
    add(GameScore());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    switch (gameState) {
      case GameState.start:

        // 파이프 이동 속도
        pipeDownMoveX = pipeDown.x - floorSpeed;
        pipeUpMoveX = pipeUp.x - floorSpeed;

        if (pipeDown.x < -100) {
          // 파이브 랜덤 위치 생성
          double randomPosition = (Random().nextInt(6) + 3) * 100;
          pipeDown.y = randomPosition;
          pipeUp.y = (randomPosition - 900);
          dev.log("pipe position : ${randomPosition}");
          pipeDownMoveX = 600;
          pipeUpMoveX = 600;
        }

        pipeUp.x = pipeUpMoveX;
        pipeDown.x = pipeDownMoveX;

        if(bird.x == (pipeDown.x + 60)){
          // bird가 pipe를 넘어가면 점수를 증가 시킨다.
          score += 1;
        }

        break;
      case GameState.pause:
        break;
      case GameState.stop:
        break;
    }

    super.update(dt);
  }

  @override
  void onTap() async{
    switch (gameState) {
      case GameState.start:
        if (bird.y > 100) {
          //dev.log("player.y : ${player.y}");
          timepassed -= birdJump;
        }
        break;
      case GameState.pause:
        gameState = GameState.start;
        break;
      case GameState.stop:

        score = 0;

        pipeUp.x = 600;
        pipeUp.y = -500;

        pipeDown.x = 600;
        pipeDown.y = 500;

        gameState = GameState.pause;

        timepassed = 0;
        bird.position = Vector2(250, 400);

        // 배경 랜덤 세팅
        if((Random().nextInt(2) + 1) == 1) {
          bg.sprite = SpriteSheet(image: await images.load('sprites.png'), srcSize: Vector2(144, 257)).getSprite(0, 0)..srcPosition = Vector2(0, 0); // 낮
        }else{
          bg.sprite = SpriteSheet(image: await images.load('sprites.png'), srcSize: Vector2(144, 257)).getSprite(0, 0)..srcPosition = Vector2(146, 0); // 밤
        }

        break;
    }
    super.onTap();
  }
}