import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:shiritori/backend/backend.dart' show Dictionary;

@immutable
abstract class GameSettings {
  const GameSettings({
    @required this.enemyType,
    @required this.dictionary,
    @required this.answeringDuration,
  })  : assert(dictionary != null),
        assert(answeringDuration != null),
        assert(enemyType != null);

  factory GameSettings.defaultFor({
    @required GameEnemyType enemyType,
    @required Dictionary dictionary,
  }) {
    return enemyType.isSingleplayer
        ? SingleplayerGameSettings(
            dictionary: dictionary,
            answeringDuration: defaultAnsweringDuration,
          )
        : MultiplayerGameSettings(
            dictionary: dictionary,
            answeringDuration: defaultAnsweringDuration,
          );
  }

  final GameEnemyType enemyType;
  final Dictionary dictionary;
  final Duration answeringDuration;

  static const Duration defaultAnsweringDuration = Duration(seconds: 10);
}

@immutable
class SingleplayerGameSettings implements GameSettings {
  const SingleplayerGameSettings({
    @required this.dictionary,
    @required this.answeringDuration,
    this.startWithCpuMove = true,
  })  : assert(dictionary != null),
        assert(answeringDuration != null),
        assert(startWithCpuMove != null);

  @override
  final GameEnemyType enemyType = GameEnemyType.singleplayer;

  @override
  final Dictionary dictionary;

  @override
  final Duration answeringDuration;

  final bool startWithCpuMove;
}

@immutable
class MultiplayerGameSettings implements GameSettings {
  const MultiplayerGameSettings({
    @required this.dictionary,
    @required this.answeringDuration,
  })  : assert(dictionary != null),
        assert(answeringDuration != null);

  @override
  final GameEnemyType enemyType = GameEnemyType.multiplayer;

  @override
  final Dictionary dictionary;

  @override
  final Duration answeringDuration;
}

enum GameEnemyType {
  singleplayer,
  multiplayer,
}

extension GameEnemyTypeX on GameEnemyType {
  bool get isSingleplayer => this == GameEnemyType.singleplayer;
  bool get isMultiplayer => this == GameEnemyType.multiplayer;
}
