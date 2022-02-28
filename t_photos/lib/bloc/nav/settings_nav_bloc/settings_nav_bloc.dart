import 'package:t_photos/base/bloc/navigator/base_nav_event.dart';
import 'package:t_photos/base/bloc/navigator/base_navigator_bloc.dart';
import 'package:t_photos/bloc/nav/settings_nav_bloc/settings_nav_event.dart';
import 'package:t_photos/bloc/nav/settings_nav_bloc/settings_nav_state.dart';

class SettingsNavigatorBloc extends BaseNavigatorBloc {
  SettingsNavigatorBloc() : super(SettingsNavigatorInitialState()) {
    on<SettingsNavigatorCloseEvent>((event, emit) {
      add(BaseNavigatorEventPop(state));
    });
  }
}
