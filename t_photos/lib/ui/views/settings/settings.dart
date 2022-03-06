import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_photos/base/bloc/data/base_bloc_builder.dart';
import 'package:t_photos/base/bloc/data/base_bloc_listener.dart';
import 'package:t_photos/base/bloc/data/base_state.dart';
import 'package:t_photos/base/bloc/navigator/base_nav_bloc_builder.dart';
import 'package:t_photos/base/bloc/navigator/base_nav_bloc_listener.dart';
import 'package:t_photos/bloc/data/settings/settings.dart';
import 'package:t_photos/bloc/data/settings/settings_bloc.dart';
import 'package:t_photos/bloc/data/settings/settings_event.dart';
import 'package:t_photos/bloc/data/settings/settings_state.dart';
import 'package:t_photos/bloc/nav/settings_nav_bloc/settings_nav_bloc.dart';
import 'package:t_photos/bloc/nav/settings_nav_bloc/settings_nav_event.dart';
import 'package:t_photos/bloc/nav/settings_nav_bloc/settings_nav_state.dart';
import 'package:t_photos/data/data_manager_impl.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static Widget buildSettingScreen(BuildContext context) {
    final dataManager = DataManagerImpl.getInstance();
    final screenSettings = MultiBlocProvider(providers: [
      BlocProvider(create: (_) => SettingsNavigatorBloc()),
      BlocProvider(
          create: (_) => SettingsBloc(
              preferencesSettingsApi: dataManager.preferencesSettingsApi,
              preferencesIdApi: dataManager.preferencesIdApi))
    ], child: const SettingsScreen());
    return screenSettings;
  }

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final SettingsNavigatorBloc _navBloc;
  late final SettingsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _navBloc = BlocProvider.of<SettingsNavigatorBloc>(context);
    _bloc = BlocProvider.of<SettingsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BaseNavigatorBlocListener<SettingsNavigatorBloc,
        SettingsNavigatorState>(
      bloc: _navBloc,
      navListener: (navContext, navState) {},
      child: BaseNavigatorBlocBuilder(
        bloc: _navBloc,
        buildWhenCondition: (prevState, currentState) {
          return (currentState != prevState) ||
              (currentState is SettingsNavigatorInitialState);
        },
        navigatorBlocWidgetBuilder: (navContext, navState) {
          return SafeArea(
              child: Scaffold(
            body: BaseBlocListener(
                bloc: _bloc,
                navigatorBloc: _navBloc,
                listener: (ctx, state) {
                  //TODO
                },
                child: BaseBlocBuilder(
                    buildWhenCondition: (prevState, currentState) {
                      return (prevState != currentState) ||
                          (currentState is SettingStateInitial);
                    },
                    bloc: _bloc,
                    builder: (context, state) {
                      return CustomScrollView(
                        slivers: [
                          const SliverAppBar(
                            pinned: true,
                            floating: true,
                            snap: true,
                            expandedHeight: 160.0,
                            flexibleSpace: FlexibleSpaceBar(
                              title: Text("Telegram username"),
                              background:
                                  FlutterLogo(), // User's profile picture
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: Text("Rounded bottom corners container"),
                          ),
                          SliverList(
                              delegate: SliverChildListDelegate.fixed([
                            ListTile(
                              title: const Text("Delete After Save "),
                              trailing: Switch(
                                  value: (state is SettingStateInitial)
                                      ? state.settings.deleteAfterSave
                                      : _getSettingsValue(
                                              (state as SettingsState))
                                          .deleteAfterSave,
                                  onChanged: (newValue) {
                                    _bloc.add(
                                        SettingsEventUpdateDeleteAfterSave(
                                            newValue));
                                  }),
                            ),
                            ListTile(
                              title: const Text("Auto Sync"),
                              trailing: Switch(
                                  value: (state is SettingStateInitial)
                                      ? state.settings.autoSync
                                      : _getSettingsValue(
                                              (state as SettingsState))
                                          .autoSync,
                                  onChanged: (newValue) {
                                    _bloc.add(
                                        SettingsEventUpdateAutoSync(newValue));
                                  }),
                            ),
                            const ListTile(
                              title: Text("Sync now"),
                            ),
                            const ListTile(
                              title: Text("Free up space on device"),
                            ),
                            const Spacer(),
                            const ListTile(
                              title: Text("Terms of use"),
                            ),
                            const ListTile(
                              title: Text("Legal Notice"),
                            ),
                            const Spacer(
                              flex: 2,
                            ),
                            Row(
                              children: [
                                OutlinedButton(
                                    onPressed: () {
                                      _navBloc
                                          .add(SettingsNavigatorCloseEvent());
                                    },
                                    child: const Text("Logout")),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text("Delete Account"))
                              ],
                            )
                          ]))
                        ],
                      );
                    })),
          ));
        },
      ),
    );
  }

  Settings _getSettingsValue(SettingsState state) {
    if (state is SettingsStateDeleteAfterSaveUpdated)
      return state.settings;
    else
      return (state as SettingsStateAutoSyncUpdated).settings;
  }
}
