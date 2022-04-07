import 'dart:convert';
import './provider.dart';
import 'package:provider/provider.dart';
// import 'package:cta/dataset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StorylineWidget extends StatefulWidget {
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
                child: ListTile(
                  leading: Text(
                    data.content[index]['user'],
                  ),
                  title: Text(
                    data.content[index]['phone'],
                  ),
                  subtitle: Text(
                    '${data.datecontent[index]}',
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
