import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_photos/ui_models/dialog_item_choice.dart';
import 'package:t_photos/views/search/search.dart';
import 'package:t_photos/views/settings/settings.dart';
import 'package:t_photos/views/timeline/timeline.dart';
import 'package:t_photos/widgets/dialogs/dialog_choice.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // late int _currentTab;

  @override
  void initState() {
    // _currentTab = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                if (kDebugMode) {
                  print("Showing settings");
                }
                showModalBottomSheet(
                    context: context,
                    builder: (ctx) {
                      return const SettingsScreen();
                    });
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: IndexedStack(
        index: _currentTab,
        children: [TimelineScreen(), SearchScreen()],
      ),
      // body: Route(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: "Timeline"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        ],
        currentIndex: _currentTab,
        onTap: (index) {
          setState(() {
            _currentTab = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          if (kDebugMode) {
            print("show dialog to add picture from camera or gallery");
          }
          showDialog(
              context: context,
              builder: (ctx) =>
                  DialogChoice(choices: [
                    DialogItemChoice("Gallery", () {
                      if (kDebugMode) {
                        print("Show gallery");
                      }
                    }),
                    DialogItemChoice("Camera", () {
                      if (kDebugMode) {
                        print("Show camera");
                      }
                    }),

                  ], title: "Upload picture from"));
        },
      ),
    ));
  }
}
