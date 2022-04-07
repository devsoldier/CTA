import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import './dataset.dart';

class DataProvider with ChangeNotifier {
  List<DataSet> content = [];

  Future<void> readJsonData() async {
    final jsondata = await rootBundle.loadString('assets/dataset.json');
    final list = json.decode(jsondata) as List<dynamic>;
    List dateconverted = [];
    for (int i = 0; i < list.length; i++) {
      dateconverted.add(
        DateTime.fromMillisecondsSinceEpoch(list[i]['check-in']),
      );
      content.add(DataSet(
          user: list[i]['user'],
          phone: list[i]['phone'],
          checkin: dateconverted[i]));
    }
    notifyListeners();
  }

  List<DataSet> get contents {
    return [...content];
  }

  DataSet findbyId(String user) {
    return content.firstWhere((use) => use.user == user);
  }
}
