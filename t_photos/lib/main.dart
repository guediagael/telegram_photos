import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_photos/bloc/nav/main_nav_bloc/main_nav_bloc.dart';
import 'package:t_photos/bloc/nav/settings_nav_bloc/settings_nav_bloc.dart';
import 'package:t_photos/views/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MainNavigatorBloc()),
        BlocProvider(create: (_) => SettingsNavigatorBloc())
      ], child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomeScreen(),
    ),
    );
    // return BlocProvider(
    //     create: (_) => MainNavigatorBloc(),
    //     child: );
  }
}
