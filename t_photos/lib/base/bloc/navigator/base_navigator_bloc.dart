import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_photos/base/bloc/navigator/base_nav_event.dart';
import 'package:t_photos/base/bloc/navigator/base_nav_state.dart';

abstract class BaseNavigatorBloc<E extends BaseNavigatorEvent,
    S extends BaseNavigatorState> extends Bloc<E, S> {
  BaseNavigatorBloc(S initialState) : super(initialState);
}
