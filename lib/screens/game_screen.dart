import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_lives_counter/models/player.dart';
import 'package:game_lives_counter/providers/providers.dart';
import 'package:game_lives_counter/widgets/gradient_icon.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:game_lives_counter/widgets/new_game_dialog.dart';

class GameScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final game = watch(livesProvider.state);

    return Scaffold(
      body: Stack(
        children: [
          gameContent(context),
          resetButton(context),
          if (game.showWinner()) gameWinner(context, game.getWinner()),
        ],
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
    );
  }

  Center resetButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => initGameState(context),
        style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            primary: Colors.white,
            padding: EdgeInsets.all(4.0)),
        child: GradientIcon(
          Icons.replay,
          60,
          LinearGradient(
              colors: [
                Colors.red,
                Colors.blue,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.5, 1.0]),
        ),
      ),
    );
  }

  void initGameState(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return NewGameDialog();
        });
  }

  Widget gameContent(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: playerBoxContent(context, Player.red),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.blue,
            child: playerBoxContent(context, Player.blue),
          ),
        )
      ],
    );
  }

  Widget playerBoxContent(BuildContext context, Player player) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Column(
            children: [
              gameLifeButton(context, player, 1, false),
              gameLifeButton(context, player, 5, false),
              gameLifeButton(context, player, 10, false),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: playerLives(player)),
          )),
          Column(
            children: [
              gameLifeButton(context, player, 1, true),
              gameLifeButton(context, player, 5, true),
              gameLifeButton(context, player, 10, true),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  Widget gameLifeButton(
      BuildContext context, Player player, int amount, bool increment) {
    final content = "${increment ? "+" : "-"} $amount";
    return SizedBox(
      width: 110,
      height: 70,
      child: ElevatedButton(
        onPressed: () => context
            .read(livesProvider)
            .updateLives(player, increment ? amount : amount * -1),
        child: Text(
          content,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.black.withOpacity(0.3),
        ),
      ),
    );
  }

  Widget playerLives(player) {
    return Consumer(builder: (context, watch, child) {
      final state = watch(livesProvider.state);

      return Column(children: [
        Spacer(),
        RotatedBox(
          quarterTurns: 2,
          child: AutoSizeText(
            "${state.getLives(player)}",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 65),
            maxLines: 1,
          ),
        ),
        Spacer(),
        AutoSizeText(
          "${state.getLives(player)}",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 65),
          maxLines: 1,
        ),
        Spacer()
      ], mainAxisAlignment: MainAxisAlignment.spaceAround);
    });
  }

  Widget gameWinner(BuildContext context, String winner) {
    return Positioned.fill(
      child: Container(
        child: Center(
          child: Container(
            child: Column(
              children: [
                Text(
                  "$winner won the game\nCongratulations!",
                  style: TextStyle(fontSize: 23),
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  onPressed: () =>
                      context.read(livesProvider).closeWinnerDialog(),
                  child: Text('close'),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.all(Radius.circular(15)),
            ),
          ),
        ),
        color: Colors.black.withOpacity(0.3),
      ),
    );
  }
}
