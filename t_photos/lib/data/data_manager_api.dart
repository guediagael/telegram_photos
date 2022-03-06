import 'package:t_photos/data/local/preferences/preferences_id_api.dart';
import 'package:t_photos/data/local/preferences/preferences_settings_api.dart';

abstract class DataManagerApi {

  PreferencesIdApi get preferencesIdApi ;

  PreferencesSettingsApi get preferencesSettingsApi ;

}
