import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_photos/base/bloc/data/base_data_bloc.dart';
import 'package:t_photos/base/bloc/data/base_state.dart';
import 'package:t_photos/data/local/preferences/preferences_id_api.dart';

import 'welcome_event.dart';
import 'welcome_state.dart';

class WelcomeBloc extends BaseBloc {

  WelcomeBloc(PreferencesIdApi preferencesIdApi)
      : super(const WelcomeStateInitial(), preferencesIdApi) {
    on<WelcomeEventCheckToken>((event, emit) {
      _checkToken(emit);
    });
  }

  void _checkToken(Emitter<BaseState> emitter) {
    if (super.preferencesIdApi!.getSessionId() != null &&
        super.preferencesIdApi!.getToken() != null) {
      emitter(const WelcomeStateTokenValid());
    } else {
      emitter(const WelcomeStateTokenInvalid());
    }
  }
}
