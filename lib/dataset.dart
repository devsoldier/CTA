import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

class DataSet with ChangeNotifier {
  final String user;
  final String phone;
  final DateTime checkin;

  DataSet({required this.user, required this.phone, required this.checkin});

  // DataSet.fromJson(Map<String, dynamic> json) {
  //   user = json['user'];
  //   phone = json['phone'];
  //   checkin = json['check-in'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['user'] = this.user;
  //   data['phone'] = this.phone;
  //   data['check-in'] = this.checkin;
  //   return data;
  // }
}
