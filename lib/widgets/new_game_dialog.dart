import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:game_lives_counter/providers/providers.dart';

class NewGameDialog extends StatefulWidget {
  @override
  _NewGameDialogState createState() => _NewGameDialogState();
}

class _NewGameDialogState extends State<NewGameDialog> {
  final livesTextController = TextEditingController(text: "50");

  @override
  Widget build(BuildContext context) {
    livesTextController.text = 
        context.read(livesProvider).game.initalLives.toString();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: 270,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "How many lives?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              inputBox(),
              inputButton(context)
            ],
          ),
        ),
      ),
    );
  }

  SizedBox inputButton(BuildContext context) {
    return SizedBox(
      width: 180.0,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          context.read(livesProvider).init(int.parse(livesTextController.text));
          Navigator.pop(context, true);
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
        ),
        child: Text(
          "Start",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget inputBox() {
    return SizedBox(
      width: 180,
      child: TextField(
        keyboardType: TextInputType.number,
        autofocus: true,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3),
        ],
        style: TextStyle(
          fontSize: 32,
        ),
        decoration: new InputDecoration(
          border: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green, width: 2.0),
          ),
        ),
        textAlign: TextAlign.center,
        controller: livesTextController,
      ),
    );
  }
}
