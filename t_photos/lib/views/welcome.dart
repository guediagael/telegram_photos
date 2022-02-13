import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:t_photos/rich_button/rich_button_builder.dart';
import 'package:t_photos/rich_button/rich_button_state_manager.dart';
import 'package:t_photos/widgets/button_login_loading.dart';
import 'package:t_photos/widgets/button_login_registration_initial.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WelComeScreenState();
}

class _WelComeScreenState extends State<WelcomeScreen> {
  late RichButtonState _buttonState ;

  @override
  void initState() {
    _buttonState = RichButtonState.initial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
              "Welcome To T-Photo, we'll help you to back up your photos"),
          Container(

            child: RichButton(
                buttonFacesBuilder: RichButtonBuilder(
                  initialStateWidget: const ButtonLoginRegistrationInitial(),
                  loadingStateWidget: const ButtonLoginLoading(),
                  onClick: () {
                    if (kDebugMode) {
                      print("pressed $_buttonState");
                    }
                    setState(() {
                      if (_buttonState == RichButtonState.initial) {
                        _buttonState = RichButtonState.loading;
                      } else if (_buttonState == RichButtonState.loading) {
                        _buttonState = RichButtonState.initial;

                      }
                    });
                  },
                ),
                newState: _buttonState),
          )
        ],
      ),
    );
  }
}
