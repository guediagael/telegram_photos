import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_photos/base/bloc/data/base_data_bloc.dart';
import 'package:t_photos/base/bloc/data/base_event.dart';
import 'package:t_photos/base/bloc/data/base_state.dart';
import 'package:t_photos/bloc/data/settings/settings.dart';
import 'package:t_photos/bloc/data/settings/settings_event.dart';
import 'package:t_photos/bloc/data/settings/settings_state.dart';
import 'package:t_photos/data/local/preferences/preferences_id_api.dart';
import 'package:t_photos/data/local/preferences/preferences_settings_api.dart';

class SettingsBloc extends BaseBloc {
  final PreferencesSettingsApi preferencesSettingsApi;

  SettingsBloc(
      {required this.preferencesSettingsApi,
      required PreferencesIdApi preferencesIdApi})
      : super(SettingStateInitial(
            settings: Settings.fromSharedPreferences(preferencesSettingsApi),
            username: preferencesIdApi.getUsername() ?? 'Username',
            profilePicture: preferencesIdApi.getAvatarUrl())) {
    on<SettingsEventUpdateDeleteAfterSave>(_updateDeleteAfterSaveTrigger);
    on<SettingsEventUpdateAutoSync>(_updateAutoSyncTrigger);
    on<SettingsEventShowPrivacyPolicies>(_showPrivacyPolicies);
    on<SettingsEventShowTermOfUse>(_showTermsOfUse);
    on<SettingsEventShowLegalNotice>(_showLegalNotice);
    on<SettingsEventLogout>(_logout);
    on<SettingsEventDeleteAccount>(_deleteAccount);
  }

  void _updateDeleteAfterSaveTrigger(
      SettingsEventUpdateDeleteAfterSave eventUpdateDeleteAfterSave,
      Emitter<BaseState> emitter) {
    final newValue = eventUpdateDeleteAfterSave.newSetting;
    final settings = Settings.fromSharedPreferences(preferencesSettingsApi)
        .copyWith(deleteAfterSave: newValue);
    preferencesSettingsApi.switchDeleteAfterSave(newValue);
    emitter(SettingsStateDeleteAfterSaveUpdated(settings));
  }

  void _updateAutoSyncTrigger(SettingsEventUpdateAutoSync eventUpdateAutoSync,
      Emitter<BaseState> emitter) {
    final newValue = eventUpdateAutoSync.newSetting;
    final settings = Settings.fromSharedPreferences(preferencesSettingsApi)
        .copyWith(autoSync: newValue);
    preferencesSettingsApi.switchAutoSync(newValue);
    emitter(SettingsStateAutoSyncUpdated(settings));
  }

  void _showPrivacyPolicies(
      SettingsEventShowPrivacyPolicies eventShowPrivacyPolicies,
      Emitter<BaseState> emitter) {
    //TODO
  }

  void _showTermsOfUse(SettingsEventShowTermOfUse eventShowTermOfUse,
      Emitter<BaseState> emitter) {
    //TODO
  }

  void _showLegalNotice(SettingsEventShowLegalNotice eventShowLegalNotice,
      Emitter<BaseState> emitter) {
    //TODO
  }

  void _logout(SettingsEventLogout eventLogout, Emitter<BaseState> emitter) {
    //TODO
  }

  void _deleteAccount(SettingsEventDeleteAccount eventDeleteAccount,
      Emitter<BaseState> emitter) {
    //TODO
  }
}
