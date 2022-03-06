import 'package:t_photos/base/bloc/navigator/base_navigator_bloc.dart';
import 'package:t_photos/bloc/nav/welcome/welcome_nav_state.dart';

class WelcomeNavigatorBloc extends BaseNavigatorBloc {
  WelcomeNavigatorBloc() : super(const WelComeNavigatorStateInitial());
}
