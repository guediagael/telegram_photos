import 'package:flutter/material.dart';

class ButtonLoginRegistrationInitial extends StatelessWidget {
  const ButtonLoginRegistrationInitial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [Icon(Icons.send), Text("Login/Register")]
    );
  }
}
