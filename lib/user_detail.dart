import 'package:cta/dataset.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserDetail extends StatelessWidget {
  static const routeName = '/userdetail';

  const UserDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DataSet;
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(args.user),
          Text(args.phone),
          Text(DateFormat('d MMM Y hh:mm a').format(args.checkin)),
        ],
      )),
    );
  }
}
