import 'package:flame/components.dart';

enum GameState { start, pause, stop }
GameState gameState = GameState.pause;

late SpriteComponent bg;
late SpriteAnimationComponent bird;

int score = 0; // 점수

double gravity = 5; // 플레이어 중력값
double birdJump = 0.6; // 플레이어 점프 높이
double floorSpeed = 2; // 바닥 이동속도
double timepassed = 0.0; // 증가 시간
double yPosition = 0.0; // 플레이어 Position Y

late SpriteComponent floor;
double floorMoveX = 0.0;

late SpriteComponent pipeUp;
double pipeUpMoveX = 0.0;

late SpriteComponent pipeDown;
double pipeDownMoveX = 0.0;


