import 'package:flutter/material.dart';
import 'package:t_photos/ui_models/dialog_item_choice.dart';

class DialogChoice extends StatelessWidget {
  final DialogItemChoiceList choices;
  final String title;
  final String? body;

  const DialogChoice(
      {Key? key, required this.choices, required this.title, this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(title),
      children: List.generate(
          choices.length,
              (index) =>
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  choices[index].onSelected();
                },
                child: Text(choices[index].text),
              )),
    );
  }
}
