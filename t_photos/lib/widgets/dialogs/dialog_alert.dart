import 'package:flutter/material.dart';

class DialogAlert extends StatelessWidget {
  final String alertMessage;
  final String alertTitle;
  final Function onOkayPressed;

  const DialogAlert(
      {Key? key,
      required this.alertMessage,
      required this.onOkayPressed,
      required this.alertTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        alertTitle,
      ),
      content: Text(alertMessage),
      actions: [
        TextButton(onPressed: () => onOkayPressed(), child: const Text("Ok"))
      ],
    );
  }
}
