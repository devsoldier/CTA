// import 'dart:convert';
import 'package:cta/user_detail.dart';
import './provider.dart';
import 'package:provider/provider.dart';
// import 'package:cta/dataset.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class StorylineWidget extends StatefulWidget {
  @override
  State<StorylineWidget> createState() => _StorylineWidgetState();
}

class _StorylineWidgetState extends State<StorylineWidget> {
  final TextEditingController controller = TextEditingController();
  FocusNode searchfield = FocusNode();

  String _selectedsort = 'new to old';
  List sortfilters = [
    'new to old',
    'old to new',
  ];

  void getData() {
    Provider.of<DataProvider>(context, listen: false).readJsonData();
  }

  sortdates(_selectedsort) {
    Provider.of<DataProvider>(context, listen: false).sortdate(_selectedsort);
  }

  void searchList(String query) {
    Provider.of<DataProvider>(context, listen: false).searchlist(query);
  }

  @override
  void initState() {
    getData();
    sortdates(_selectedsort);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 180,
              height: 60,
              child: TextField(
                  focusNode: searchfield,
                  controller: controller,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'search user',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchList(value.toString());
                    });
                  }),
            ),
            // SizedBox(width: 20),
            Container(
              width: 130,
              height: 60,
              child: InputDecorator(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(20.0),
                    ),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    value: _selectedsort,
                    onChanged: (newval) {
                      setState(() {
                        _selectedsort = newval as String;
                        // getData();
                        sortdates(_selectedsort);
                      });
                    },
                    elevation: 16,
                    items: sortfilters.map((newval) {
                      return DropdownMenuItem(
                        value: newval,
                        child: Text(newval),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
        (searchfield.hasPrimaryFocus && controller.text.isNotEmpty)
            ? Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                  itemCount: data.searchoutput.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(UserDetail.routeName,
                              arguments: data.searchoutput[index]);
                        },
                        child: ListTile(
                          leading: Text(
                            data.searchoutput[index].user,
                          ),
                          title: Text(
                            data.searchoutput[index].phone,
                          ),
                          subtitle: Text(
                            '${DateFormat('d MMM y hh:mm a').format(data.searchoutput[index].checkin)}',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                  itemCount: data.content.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(UserDetail.routeName,
                              arguments: data.filtered[index]);
                        },
                        child: ListTile(
                          leading: Text(
                            data.filtered[index].user,
                          ),
                          title: Text(
                            data.filtered[index].phone,
                          ),
                          subtitle: Text(
                            '${DateFormat('d MMM y hh:mm a').format(data.filtered[index].checkin)}',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
