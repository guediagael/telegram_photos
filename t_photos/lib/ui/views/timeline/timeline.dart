import 'package:flutter/material.dart';

class TimelineScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimelineScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Text("Timeline"),
        ),
      ),
    );
  }
}
