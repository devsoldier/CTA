import 'package:cta/storyline_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:lottie/lottie.dart';

class IntroductionPage extends StatefulWidget {
  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  final pages = [
    PageModel.withChild(
        child: Center(
          child: Column(
            children: [
              Container(
                  child: Lottie.asset('assets/lottie/100925-contact.json')),
              Text(
                'Welcome!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Color.fromARGB(255, 32, 119, 211)),
              ),
            ],
          ),
        ),
        color: Color.fromARGB(255, 180, 224, 228),
        doAnimateChild: true),
    PageModel.withChild(
        child: Center(
          child: Column(
            children: [
              Container(
                  width: 500,
                  height: 500,
                  child:
                      Image.asset('assets/images/Screenshot_1649498099.png')),
              const Text(
                'View contacts',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Color.fromARGB(255, 32, 119, 211)),
              ),
            ],
          ),
        ),
        color: const Color.fromARGB(255, 100, 166, 237),
        doAnimateChild: true),
    PageModel.withChild(
        child: Center(
          child: Column(
            children: [
              Container(
                child: Lottie.asset('assets/lottie/11859-add.json'),
              ),
              const Text(
                'Add Contacts!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Colors.white),
              ),
              const Text(
                'press the ' + ' symbol on the left corner to add contacts',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        color: const Color.fromARGB(255, 139, 201, 223),
        doAnimateChild: true),
    PageModel.withChild(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Lottie.asset('assets/lottie/search_lottie.json'),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Search Contacts!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Colors.white),
              ),
              const Text(
                'enter contact\'s name or phone number',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        color: const Color.fromARGB(255, 139, 201, 223),
        doAnimateChild: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: OverBoard(
        allowScroll: true,
        pages: pages,
        showBullets: true,
        inactiveBulletColor: Colors.blue,
        skipCallback: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Skip clicked"),
          ));
        },
        finishCallback: () {
          Navigator.of(context).pushReplacementNamed(StoryLineScreen.routeName);
        },
      ),
    );
  }
}
