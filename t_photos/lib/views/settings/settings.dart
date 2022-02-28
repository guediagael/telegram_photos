import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_photos/base/bloc/navigator/base_nav_bloc_builder.dart';
import 'package:t_photos/base/bloc/navigator/base_nav_bloc_listener.dart';
import 'package:t_photos/bloc/nav/settings_nav_bloc/settings_nav_bloc.dart';
import 'package:t_photos/bloc/nav/settings_nav_bloc/settings_nav_event.dart';
import 'package:t_photos/bloc/nav/settings_nav_bloc/settings_nav_state.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final SettingsNavigatorBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<SettingsNavigatorBloc>(context);
    return BaseNavigatorBlocListener<SettingsNavigatorBloc,
        SettingsNavigatorState>(
      bloc: _bloc,
      navListener: (navContext, state) {},
      child: BaseNavigatorBlocBuilder(
        bloc: _bloc,
        buildWhenCondition: (prevState, currentState) {
          return (currentState != prevState) ||
              (currentState is SettingsNavigatorInitialState);
        },
        navigatorBlocWidgetBuilder: (navContext, state) {
          return SafeArea(
              child: Scaffold(
            body: CustomScrollView(
              slivers: [
                const SliverAppBar(
                  pinned: true,
                  floating: true,
                  snap: true,
                  expandedHeight: 160.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text("Telegram username"),
                    background: FlutterLogo(), // User's profile picture
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Text("Rounded bottom corners container"),
                ),
                SliverList(
                    delegate: SliverChildListDelegate.fixed([
                  ListTile(
                    title: const Text("Delete After Save "),
                    trailing: Switch(value: false, onChanged: (newValue) {}),
                  ),
                  ListTile(
                    title: const Text("Auto Sync"),
                    trailing: Switch(value: true, onChanged: (newValue) {}),
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
                            _bloc.add(SettingsNavigatorCloseEvent());
                          },
                          child: const Text("Logout")),
                      TextButton(
                          onPressed: () {}, child: const Text("Delete Account"))
                    ],
                  )
                ]))
              ],
            ),
          ));
        },
      ),
    );
  }
}
