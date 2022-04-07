import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import './dataset.dart';

class DataProvider with ChangeNotifier {
  List<DataSet> content = [];
  List<String> message = [];

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

  Future<void> addUser(
      String name, String phonenumber, DateTime newcheckin) async {
    message.clear();
    content.insert(
        0, DataSet(user: name, phone: phonenumber, checkin: newcheckin));
    message.insert(0, 'Successfully added');
    notifyListeners();
  }
}
