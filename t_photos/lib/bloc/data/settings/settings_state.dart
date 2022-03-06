import 'package:t_photos/base/bloc/data/base_state.dart';
import 'package:t_photos/bloc/data/settings/settings.dart';

abstract class SettingsState extends BaseState {
  const SettingsState(List<Object?> properties) : super(properties);
}

class SettingStateInitial extends SettingsState {
  final Settings settings;
  final String username;
  final String? profilePicture;

  SettingStateInitial(
      {required this.settings, required this.username, this.profilePicture})
      : super([settings, username, profilePicture]);
}

class SettingsStateDeleteAfterSaveUpdated extends SettingsState {
  final Settings settings;

  SettingsStateDeleteAfterSaveUpdated(this.settings) : super([settings]);
}

class SettingsStateAutoSyncUpdated extends SettingsState {
  final Settings settings;

  SettingsStateAutoSyncUpdated(this.settings) : super([settings]);
}

class SettingsStateSpaceCleared extends SettingsState {
  const SettingsStateSpaceCleared() : super(const []);
}

class SettingsStateShowPrivacyPolicies extends SettingsState {
  const SettingsStateShowPrivacyPolicies() : super(const []);
}

class SettingsStateShowTermsOfUse extends SettingsState {
  const SettingsStateShowTermsOfUse() : super(const []);
}

class SettingsStateShowLegalNotice extends SettingsState {
  const SettingsStateShowLegalNotice() : super(const []);
}

class SettingsStateLoggedOut extends SettingsState {
  const SettingsStateLoggedOut() : super(const []);
}

class SettingsStateAccountDeleted extends SettingsState {
  const SettingsStateAccountDeleted() : super(const []);
}
