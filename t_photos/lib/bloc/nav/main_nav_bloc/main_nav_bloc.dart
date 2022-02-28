import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_photos/base/bloc/navigator/base_nav_state.dart';
import 'package:t_photos/base/bloc/navigator/base_navigator_bloc.dart';
import 'package:t_photos/bloc/nav/main_nav_bloc/main_nav_event.dart';
import 'package:t_photos/bloc/nav/main_nav_bloc/main_nav_state.dart';

class MainNavigatorBloc extends BaseNavigatorBloc {
  MainNavigatorBloc() : super(MainNavigatorStateShowTimeLine()) {
    on<MainNavigatorEventShowSearch>(_onShowSearch);
    on<MainNavigatorEventShowTimeLine>(_onShowTimeline);
    on<MainNavigatorEventShowSettings>(_onShowSettings);
    on<MainNavigatorEventAddNew>(_onAddNew);
    on<MainNavigatorEventOpenGallery>(_onOpenGallery);
    on<MainNavigatorEventOpenCamera>(_onOpenCamera);
  }

  void _onShowSearch(MainNavigatorEventShowSearch mainNavigatorEventShowSearch,
      Emitter<BaseNavigatorState> emitter) {
    emitter(MainNavigatorStateShowSearch());
  }

  void _onShowTimeline(
      MainNavigatorEventShowTimeLine mainNavigatorEventShowTimeLine,
      Emitter<BaseNavigatorState> emitter) {
    emitter(MainNavigatorStateShowTimeLine());
  }

  void _onShowSettings(
      MainNavigatorEventShowSettings mainNavigatorEventShowSettings,
      Emitter<BaseNavigatorState> emitter) {
    emitter(MainNavigatorStateShowSettings());
  }

  void _onAddNew(MainNavigatorEventAddNew mainNavigatorEventAddNew,
      Emitter<BaseNavigatorState> emitter) {
    emitter( MainNavigatorStateShowAddDialog());
  }

  void _onOpenGallery(
      MainNavigatorEventOpenGallery mainNavigatorEventOpenGallery,
      Emitter<BaseNavigatorState> emitter) {
    emitter(const MainNavigatorStateOpenGallery([]));
  }

  void _onOpenCamera(MainNavigatorEventOpenCamera mainNavigatorEventOpenCamera,
      Emitter<BaseNavigatorState> emitter) {
    emitter(MainNavigatorStateOpenCamera());
  }
}
