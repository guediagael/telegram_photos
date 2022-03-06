import 'package:t_photos/data/local/preferences/preferences_settings_api.dart';

class Settings {
  final bool autoSync;
  final bool deleteAfterSave;
  final String termsOfService = "Terms of Services url (Link to github readme";
  final String privacyPolicies = 'Privacy Policies url (link to github readme)';
  final String legalNotice = "Legal Notice (link to github readme)";

  Settings({required this.autoSync, required this.deleteAfterSave});

  Settings copyWith({bool? autoSync, bool? deleteAfterSave}) {
    return Settings(
        autoSync: autoSync ?? this.autoSync,
        deleteAfterSave: deleteAfterSave ?? this.deleteAfterSave);
  }

  static Settings fromSharedPreferences(
      PreferencesSettingsApi preferencesSettingsApi) {
    bool autoSync = preferencesSettingsApi.getAutoSyncStatus();
    bool deleteAfterSave = preferencesSettingsApi.getDeleteAfterSaveStatus();
    return Settings(autoSync: autoSync, deleteAfterSave: deleteAfterSave);
  }
}
