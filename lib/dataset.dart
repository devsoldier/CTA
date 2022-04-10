import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

class DataSet with ChangeNotifier {
  final String user;
  final String phone;
  final DateTime checkin;

  DataSet({required this.user, required this.phone, required this.checkin});
}
