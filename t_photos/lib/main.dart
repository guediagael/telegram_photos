import 'package:flutter/material.dart';
import 'package:t_photos/ui/views/initializer.dart';
import 'package:t_photos/ui/views/welcome/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TPhotos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomeScreen(),
    );
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider(create: (_) => MainNavigatorBloc()),
    //     BlocProvider(create: (_) => SettingsNavigatorBloc())
    //   ], child: MaterialApp(
    //   title: 'TPhotos',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: const WelcomeScreen(),
    // ),
    // );
  }
}
