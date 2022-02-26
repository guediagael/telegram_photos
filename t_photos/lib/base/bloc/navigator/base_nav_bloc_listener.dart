import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_photos/base/bloc/base_event.dart';
import 'package:t_photos/base/bloc/navigator/base_nav_state.dart';
import 'package:t_photos/base/bloc/navigator/base_navigator_bloc.dart';
import 'package:t_photos/copyable_mixin.dart';
import 'package:t_photos/views/loading.dart';
import 'package:t_photos/views/welcome.dart';
import 'package:t_photos/widgets/dialogs/dialog_alert.dart';
import 'package:t_photos/widgets/dialogs/dialog_binary_action.dart';

class BaseNavigatorBlocListener<E extends BaseEvent,
    S extends BaseNavigatorState> extends BlocListener with CopyableWidget {
  final BaseNavigatorBloc bloc;
  final Widget? child;

  BaseNavigatorBlocListener(
      {Key? key,
      required this.bloc,
      this.child,
      required BlocWidgetListener<S> navListener})
      : super(
            key: key,
            bloc: bloc,
            child: child,
            listener: (context, state) {
              debugPrint("new State ($state) detected in $context");
              if (state is BaseNavigatorStatePop) {
                Navigator.pop(context);
              } else if (state is BaseNavigatorStateShowSnackBar) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                ));
              } else if (state is BaseNavigatorStateShowActionableDialog) {
                showDialog(
                    context: context,
                    builder: (ctx) => DialogBinaryAction(
                        alertMessage: state.errorMessage,
                        alertTitle: state.title,
                        onPositivePressed: () => state.onPositiveTap(),
                        onNegativePressed: () => state.onNegativeTap()));
              } else if (state is BaseNavigatorStateShowActionableErrorDialog) {
                showDialog(
                    context: context,
                    builder: (ctx) => DialogBinaryAction(
                        alertMessage: state.errorMessage,
                        alertTitle: state.title,
                        titleColor: Colors.red,
                        onPositivePressed: () => state.onPositiveTap(),
                        onNegativePressed: () => state.onNegativeTap()));
              } else if (state is BaseNavigatorStateShowInfoDialog) {
                showDialog(
                    context: context,
                    builder: (ctx) => DialogAlert(
                        alertMessage: state.errorMessage,
                        onOkayPressed: () => state.onPositiveTap(),
                        alertTitle: state.title));
              } else if (state is BaseNavigatorStateShowErrorInfoDialog) {
                showDialog(
                    context: context,
                    builder: (ctx) => DialogAlert(
                          alertMessage: state.errorMessage,
                          onOkayPressed: () => state.onPositiveTap(),
                          alertTitle: state.title,
                          titleColor: Colors.red,
                        ));
              } else if (state is BaseNavigatorStateShowLoading) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => const LoadingScreen()));
              } else if (state is BaseNavigatorStateLogout) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx) => const WelcomeScreen()),
                    (route) => false);
              } else {
                navListener(context, state);
              }
            });

  @override
  Widget copyWith(Widget child) {
    return BlocListener(listener: listener, key: key, bloc: bloc, child: child);
  }
}
