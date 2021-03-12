import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_lives_counter/models/game.dart';
import 'package:game_lives_counter/models/player.dart';

class LivesState extends StateNotifier<Game> {
  LivesState() : super(Game(50));

  // A nicer name for the state
  Game get game => state;

  int getLives(Player player) {
    return state.getLives(player);
  }

  void init(int lives) {
    state = Game(lives);
  }

  void updateLives(Player player, int amount) {
    if (state.isFinished()) return;
    state = state.addLives(player, amount);
  }

  /// Update the state to hide the winner dialog after a game is finished
  void closeWinnerDialog() {
    state = state.setShowWinner(false);
  }
}
