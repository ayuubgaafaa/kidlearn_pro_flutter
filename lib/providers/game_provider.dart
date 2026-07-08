import 'package:flutter/material.dart';
import '../models/game_model.dart';

class GameProvider extends ChangeNotifier {
  List<Game> _games = [];
  Map<String, int> _gameProgress = {};
  Map<String, bool> _completedGames = {};

  List<Game> get games => _games;
  Map<String, int> get gameProgress => _gameProgress;
  Map<String, bool> get completedGames => _completedGames;

  GameProvider() {
    _games = Game.getAllGames();
  }

  void updateGameProgress(String gameId, int stars) {
    _gameProgress[gameId] = stars;
    _completedGames[gameId] = true;
    notifyListeners();
  }

  int getTotalStars() {
    return _gameProgress.values.fold(0, (sum, stars) => sum + stars);
  }

  int getCompletedCount() {
    return _completedGames.values.where((v) => v).length;
  }
}
