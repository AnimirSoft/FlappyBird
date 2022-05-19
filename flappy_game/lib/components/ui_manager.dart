import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flappy_game/game_state.dart';

class UIMnager extends SpriteComponent {
  UIMnager():super(position: Vector2(100, 200), size: Vector2(92 * 4, 25 * 4));

  var imgGetReady;
  var imgGameOver;

  @override
  Future<void>? onLoad() async{

    imgGetReady = SpriteSheet(
        image: await Flame.images.load('sprites.png'), srcSize: Vector2(92, 25))
        .getSprite(0, 0)
    ..srcPosition = Vector2(295, 59) ;

    imgGameOver = SpriteSheet(
        image: await Flame.images.load('sprites.png'), srcSize: Vector2(96, 25))
        .getSprite(0, 0)
      ..srcPosition = Vector2(395, 59);

    sprite = imgGameOver;

    return super.onLoad();
  }

  @override
  void update(double dt) async{
    super.update(dt);
    switch(gameState){
      case GameState.start:
        sprite = null;
        break;
      case GameState.pause:
        sprite = imgGetReady;
        break;
      case GameState.stop:
        sprite = imgGameOver;
        break;
    }
  }
}