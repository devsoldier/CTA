import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import './dataset.dart';

class DataProvider with ChangeNotifier {
  List<DataSet> content = [];
  List<String> message = [];
  List<DataSet> filtered = [];
  List<DataSet> searchoutput = [];
  late dynamic suggestions;

  Future<void> readJsonData() async {
    // content.clear();
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
    filtered = content;
    notifyListeners();
  }

  Future<void> sortdate(String sortoption) async {
    List<DataSet> olddate = [];
    List<DataSet> newdate = [];
    olddate = content;
    olddate.sort((a, b) => a.checkin.compareTo(b.checkin));
    newdate = olddate.reversed.toList();
    if (sortoption == 'old to new') {
      filtered = olddate;
    }
    if (sortoption == 'new to old') {
      filtered = newdate;
    }
  }

  Future<void> addUser(
      String name, String phonenumber, DateTime newcheckin) async {
    message.clear();
    content.insert(
        0, DataSet(user: name, phone: phonenumber, checkin: newcheckin));
    message.insert(0, 'Successfully added');
    notifyListeners();
  }

  Future<void> searchlist(String query) async {
    suggestions = content.where((user) {
      final username = user.user.toLowerCase();
      final input = query.toLowerCase();
      return username.contains(input);
    }).toList();
    searchoutput = suggestions;
    notifyListeners();
  }
}
