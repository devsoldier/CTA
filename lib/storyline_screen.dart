import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import './storyline_widget.dart';

class StoryLineScreen extends StatelessWidget {
  static const routeName = '/storyline';
  // final String user;
  // final String phone;
  // final DateTime checkin;

  // const StoryLineScreen(this.user, this.phone, this.checkin);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Technical Assessment'),
      ),
      body: StorylineWidget(),
    );
  }
}
