import 'package:t_photos/base/bloc/data/base_event.dart';

abstract class WelcomeEvent extends BaseEvent{
  const WelcomeEvent(List<Object?> properties) : super(properties);
}



class WelcomeEventCheckToken extends WelcomeEvent{
  const WelcomeEventCheckToken() : super(const []);
}

