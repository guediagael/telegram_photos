import 'package:flutter/material.dart';

class DialogBinaryAction extends StatelessWidget {
  final String alertMessage;
  final String alertTitle;
  final Function onPositivePressed;
  final Function onNegativePressed;

  const DialogBinaryAction(
      {Key? key,
      required this.alertMessage,
      required this.alertTitle,
      required this.onPositivePressed,
      required this.onNegativePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        alertTitle,
      ),
      content: Text(alertMessage),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              onNegativePressed();
            },
            child: const Text("Cancel")),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onPositivePressed();
            },
            child: const Text("Ok"))
      ],
    );
    ;
  }
}
