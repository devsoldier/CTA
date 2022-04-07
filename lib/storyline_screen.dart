import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './storyline_widget.dart';

class Screen extends StatelessWidget {
  const Screen({Key? key}) : super(key: key);

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
