import 'package:shared_preferences/shared_preferences.dart';
import 'package:t_photos/data/local/preferences/preferences_settings_api.dart';

class PreferencesSettingsImpl implements PreferencesSettingsApi {
  final SharedPreferences sharedPreferences;
  static const String _deleteAfterSaveKey = "deleteAfterSave";
  static const String _autoSyncKey = "autoSync";

  const PreferencesSettingsImpl(this.sharedPreferences);

  @override
  void resetSettings() {
    sharedPreferences.setBool(_autoSyncKey, false);
    sharedPreferences.setBool(_deleteAfterSaveKey, false);
  }

  @override
  void switchAutoSync(bool on) {
    sharedPreferences.setBool(_autoSyncKey, on);
  }

  @override
  void switchDeleteAfterSave(bool on) {
    sharedPreferences.setBool(_deleteAfterSaveKey, on);
  }

  @override
  bool getAutoSyncStatus() {
    return sharedPreferences.getBool(_autoSyncKey) ?? false;
  }

  @override
  bool getDeleteAfterSaveStatus() {
    return sharedPreferences.getBool(_deleteAfterSaveKey) ?? false;
  }
}
