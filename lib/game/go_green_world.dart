import 'dart:async';
import 'package:flame/components.dart';
import 'package:go_green/constants.dart';
import 'package:go_green/game/go_green_game.dart';
import 'package:go_green/sprites/obstacle.dart';
import '../sprites/bin.dart';
import '../sprites/player.dart';
import 'level_data.dart';

class GoGreenWorld extends World with HasGameRef<GoGreenGame> {
  late final Player player;

  void loadLevel(List<ObstacleData> levelData) {
    // remove any existing Obstacles
    removeAll(children.whereType<Obstacle>().toList());

    // load new obstacles from level data
    for (var data in levelData) {
      Obstacle obstacle;
      if (data.type == ObstacleType.trash) {
        obstacle = ObstacleTrash()..position = data.position;
      } else if (data.type == ObstacleType.water) {
        obstacle = ObstacleWater()..position = data.position;
      } else if (data.type == ObstacleType.fire) {
        obstacle = ObstacleFire()..position = data.position;
        // } else if (data.type == ObstacleType.binTrash) {
        //   obstacle = BinTrash()..position = data.position;
        // } else if (data.type == ObstacleType.binRecycle) {
        //   obstacle = BinRecycle()..position = data.position;
      } else {
        continue;
      }
      add(obstacle);
    }
  }

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    player = Player();
    add(player);
    add(Bin());

    // add(ObstacleTrash()..position = Vector2(0, 0));
    // add(ObstacleWater()..position = Vector2(-obstacleSize * 2, 0));
    // add(ObstacleFire()..position = Vector2(obstacleSize * 2, 0));

    loadLevel(LevelData().level1());
  }

  @override
  void update(double dt) {
    super.update(dt);
    children.whereType<Obstacle>().forEach((obstacle){
      obstacle.position.y -= (dt * 400);

      if(obstacle.position.y < -(gameRef.size.y / 2)){
        obstacle.position.y = extendedHeight;
      }
    });
  }
}
