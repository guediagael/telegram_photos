import 'package:t_photos/base/bloc/data/base_event.dart';

abstract class SettingsEvent extends BaseEvent {
  const SettingsEvent(List<Object?> properties) : super(properties);
}

class SettingsEventUpdateDeleteAfterSave extends SettingsEvent {
  final bool newSetting;

  SettingsEventUpdateDeleteAfterSave(this.newSetting) : super([newSetting]);
}

class SettingsEventUpdateAutoSync extends SettingsEvent {
  final bool newSetting;

  SettingsEventUpdateAutoSync(this.newSetting) : super([newSetting]);
}

class SettingsEventShowPrivacyPolicies extends SettingsEvent {
  const SettingsEventShowPrivacyPolicies() : super(const []);
}

class SettingsEventShowTermOfUse extends SettingsEvent {
  const SettingsEventShowTermOfUse() : super(const []);
}

class SettingsEventShowLegalNotice extends SettingsEvent {
  const SettingsEventShowLegalNotice() : super(const []);
}

class SettingsEventLogout extends SettingsEvent {
  const SettingsEventLogout() : super(const []);
}

class SettingsEventDeleteAccount extends SettingsEvent {
  const SettingsEventDeleteAccount() : super(const []);
}
