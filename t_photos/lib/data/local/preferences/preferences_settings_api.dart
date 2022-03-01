abstract class PreferencesSettingsApi{

  void resetSettings();

  void switchDeleteAfterSave(bool on);
  void switchAutoSync(bool on);

  bool getAutoSyncStatus();
  bool getDeleteAfterSaveStatus();

}