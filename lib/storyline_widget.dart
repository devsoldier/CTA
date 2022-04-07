// import 'dart:convert';
import 'package:cta/user_detail.dart';
import './provider.dart';
import 'package:provider/provider.dart';
// import 'package:cta/dataset.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class StorylineWidget extends StatefulWidget {
  // final String user;
  // final String phone;
  // final DateTime checkin;

  // const StorylineWidget(this.user, this.phone, this.checkin);

  @override
  State<StorylineWidget> createState() => _StorylineWidgetState();
}

class _StorylineWidgetState extends State<StorylineWidget> {
  void getData() {
    Provider.of<DataProvider>(context, listen: false).readJsonData();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          child: ListView.builder(
            itemCount: data.content.length,
            itemBuilder: (context, index) {
              return Card(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(UserDetail.routeName,
                        arguments: data.content[index]);
                  },
                  child: ListTile(
                    leading: Text(
                      data.content[index].user,
                    ),
                    title: Text(
                      data.content[index].phone,
                    ),
                    subtitle: Text(
                      '${DateFormat('d MMM Y hh:mm a').format(data.content[index].checkin)}',
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
