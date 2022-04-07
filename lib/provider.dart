import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class DataProvider with ChangeNotifier {
  List content = [];
  List datecontent = [];

  Future<void> readJsonData() async {
    final jsondata = await rootBundle.loadString('assets/dataset.json');
    final list = json.decode(jsondata) as List<dynamic>;
    content = list;
    for (int i = 0; i < list.length; i++) {
      datecontent.add(
        DateTime.fromMillisecondsSinceEpoch(list[i]['check-in']),
      );
    }
  }
}
