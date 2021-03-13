/*
  A simple game with 2 players and a configurable amount of lives
*/
import 'package:game_lives_counter/models/player.dart';

class Game {
  late Map<Player, int> _lives;
  bool _showWinner = true;
  late final int initalLives;

  int get livesRed => getLives(Player.red);
  int get livesBlue => getLives(Player.blue);

  Game(int lives) {
    this._lives = {
      Player.blue: lives,
      Player.red: lives,
    };
    this.initalLives = lives;
  }

  Game.copied(Game game) {
    this._lives = game._lives;
    this._showWinner = game._showWinner;
    this.initalLives = game.initalLives;
  }

  int getLives(Player player) {
    return this._lives[player] ?? 0;
  }

  Game addLives(Player player, int amount) {
    if (this._lives[player] != null) {
      this._lives.update(player, (value) => value + amount);
    }
    return Game.copied(this);
  }

  bool isFinished() {
    return this._lives.values.any((lives) => lives <= 0);
  }

  bool showWinner() {
    return this._showWinner && this.isFinished();
  }

  Game restart() {
    return Game(this.initalLives);
  }

  String getWinner() {
    if (livesRed <= 0) {
      return "Blue player";
    } else if (livesBlue <= 0) {
      return "Red player";
    } else {
      return "No one";
    }
  }
}
