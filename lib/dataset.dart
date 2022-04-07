class DataSet {
  String? user;
  String? phone;
  int? checkin;

  DataSet(this.user, this.phone, this.checkin);

  DataSet.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    phone = json['phone'];
    checkin = json['check-in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['phone'] = this.phone;
    data['check-in'] = this.checkin;
    return data;
  }
}
