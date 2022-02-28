import 'package:t_photos/base/bloc/navigator/base_nav_event.dart';

class SettingsNavigatorEvent extends BaseNavigatorEvent{
  const SettingsNavigatorEvent(List<Object?> props) : super(props);
}

class SettingsNavigatorCloseEvent extends SettingsNavigatorEvent{
  SettingsNavigatorCloseEvent() : super([]);
}