import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:shiritori/backend/backend.dart';

@immutable
abstract class GameSettings {
  const GameSettings({
    @required this.dictionary,
    @required this.answeringDuration,
    @required this.enemyType,
  })  : assert(dictionary != null),
        assert(answeringDuration != null),
        assert(enemyType != null);

  final Dictionary dictionary;
  final Duration answeringDuration;
  final GameEnemyType enemyType;
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
  final Dictionary dictionary;

  @override
  final Duration answeringDuration;

  @override
  final GameEnemyType enemyType = GameEnemyType.singleplayer;

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
  final Dictionary dictionary;

  @override
  final Duration answeringDuration;

  @override
  final GameEnemyType enemyType = GameEnemyType.multiplayer;
}

enum GameEnemyType {
  singleplayer,
  multiplayer,
}

extension GameEnemyTypeX on GameEnemyType {
  bool get isSingleplayer => this == GameEnemyType.singleplayer;
  bool get isMultiplayer => this == GameEnemyType.multiplayer;
}
