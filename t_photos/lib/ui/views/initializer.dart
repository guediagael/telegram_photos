import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:t_photos/bloc/nav/main_nav_bloc/main_nav_bloc.dart';
import 'package:t_photos/bloc/nav/settings_nav_bloc/settings_nav_bloc.dart';
import 'package:t_photos/data/data_manager_api.dart';
import 'package:t_photos/data/data_manager_impl.dart';
import 'package:t_photos/ui/views/welcome/welcome.dart';

class InitializerScreen extends StatefulWidget {

  const InitializerScreen({Key? key}) : super(key: key);

  @override
  State<InitializerScreen> createState() => _InitializerScreenState();
}

class _InitializerScreenState extends State<InitializerScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder<DataManagerApi>(initialData: null, future: DataManagerImpl.init(),builder: (ctx,state){
        if(state.hasData){
          if(state.data!=null){
            return  MultiProvider(providers: [
              Provider<DataManagerApi>.value(value: state.requireData),
              BlocProvider(create: (_) => MainNavigatorBloc()),
              BlocProvider(create: (_) => SettingsNavigatorBloc())
            ], child: const WelcomeScreen(),);
          }
        }
        return Container();
      },)
    );
  }

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (ctx) => const WelcomeScreen()), (
        route) => false);
  }
}
