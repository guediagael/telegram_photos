import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:t_photos/base/bloc/data/base_bloc_builder.dart';
import 'package:t_photos/base/bloc/data/base_bloc_listener.dart';
import 'package:t_photos/base/bloc/navigator/base_nav_bloc_builder.dart';
import 'package:t_photos/base/bloc/navigator/base_nav_bloc_listener.dart';
import 'package:t_photos/bloc/data/welcome_bloc/welcome_bloc.dart';
import 'package:t_photos/bloc/data/welcome_bloc/welcome_event.dart';
import 'package:t_photos/bloc/data/welcome_bloc/welcome_state.dart';
import 'package:t_photos/bloc/nav/main_nav_bloc/main_nav_bloc.dart';
import 'package:t_photos/bloc/nav/welcome/welcome_nav_bloc.dart';
import 'package:t_photos/bloc/nav/welcome/welcome_nav_state.dart';
import 'package:t_photos/data/data_manager_api.dart';
import 'package:t_photos/data/data_manager_impl.dart';
import 'package:t_photos/rich_button/rich_button_builder.dart';
import 'package:t_photos/rich_button/rich_button_state_manager.dart';
import 'package:t_photos/ui/views/main/main.dart';
import 'package:t_photos/ui/widgets/buttons/button_login_loading.dart';
import 'package:t_photos/ui/widgets/buttons/button_login_registration_initial.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WelComeScreenState();
}

class _WelComeScreenState extends State<WelcomeScreen> {
  late RichButtonState _buttonState;
  late final WelcomeNavigatorBloc _welcomeNavigatorBloc;
  late final WelcomeBloc _welcomeBloc;

  @override
  void initState() {
    _buttonState = RichButtonState.initial;
    _welcomeNavigatorBloc = WelcomeNavigatorBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseNavigatorBlocListener(
      bloc: _welcomeNavigatorBloc,
      navListener: (navCtx, navState) {},
      child: BaseNavigatorBlocBuilder(
        buildWhenCondition: (prevState, currentState) {
          return (prevState != currentState) &&
              (currentState is WelComeNavigatorStateInitial);
        },
        bloc: _welcomeNavigatorBloc,
        navigatorBlocWidgetBuilder: (ctx, state) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                    "Welcome To T-Photo, we'll help you to back up your photos"),
                FutureBuilder<DataManagerApi>(
                  builder: (ctx, AsyncSnapshot<DataManagerApi> futureState) {
                    if (futureState.hasData) {
                      if (futureState.data != null) {
                        _welcomeBloc = WelcomeBloc(
                            futureState.requireData.preferencesIdApi);
                        return BaseBlocListener(
                          listener: (ctx, blocState) {
                            debugPrint(
                                "new state welcomeScreen::databloc:: $blocState");
                            if (blocState is WelcomeStateTokenValid) {
                              _goToMainScreen(futureState.requireData);
                            } else if (blocState is WelcomeStateInitial) {
                              _welcomeBloc.add(const WelcomeEventCheckToken());
                            }
                          },
                          navigatorBloc: _welcomeNavigatorBloc,
                          bloc: _welcomeBloc,
                          child: BaseBlocBuilder(
                            buildWhenCondition: (prevState, currState) {
                              return (prevState != currState) ||
                                  (currState is WelcomeStateInitial);
                            },
                            bloc: _welcomeBloc
                              ..add(const WelcomeEventCheckToken()),
                            builder: (_, state) {
                              return RichButton(
                                  buttonFacesBuilder: RichButtonBuilder(
                                    initialStateWidget:
                                        const ButtonLoginRegistrationInitial(),
                                    loadingStateWidget:
                                        const ButtonLoginLoading(),
                                    onClick: () {
                                      debugPrint("pressed $_buttonState");
                                      if (state is WelcomeStateTokenInvalid) {
                                        _goToMainScreen(
                                            futureState.requireData);
                                      }
                                    },
                                  ),
                                  newState: ((state is WelcomeStateInitial) ||
                                          (state is WelcomeStateTokenValid))
                                      ? RichButtonState.loading
                                      : RichButtonState.activated);
                            },
                          ),
                        );
                      }
                    }
                    return Container();
                  },
                  future: DataManagerImpl.init(),
                  initialData: null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _goToMainScreen(DataManagerApi dataManagerApi) {
    final mainScreen = Provider.value(
        value: Provider<DataManagerApi>.value(value: dataManagerApi),
        child: MultiBlocProvider(providers: [
          BlocProvider(create: (_) => MainNavigatorBloc())
        ], child: const MainScreen()));
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => mainScreen));
  }
}
