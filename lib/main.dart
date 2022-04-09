import 'package:cta/provider.dart';
import 'package:cta/sprite.dart';
import 'package:cta/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'storyline_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: DataProvider(),
        )
      ],
      child: MaterialApp(
        title: 'CTA',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StoryLineScreen(),
        // home: FlimSprite(),
        routes: {
          StoryLineScreen.routeName: (ctx) => StoryLineScreen(),
          UserDetail.routeName: (ctx) => UserDetail(),
        },
      ),
    );
  }
}
