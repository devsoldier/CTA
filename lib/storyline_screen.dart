import 'package:cta/dataset.dart';
import 'package:cta/provider.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import './storyline_widget.dart';
// import './provider.dart';
import 'package:provider/provider.dart';

class StoryLineScreen extends StatefulWidget {
  static const routeName = '/storyline';

  @override
  State<StoryLineScreen> createState() => _StoryLineScreenState();
}

class _StoryLineScreenState extends State<StoryLineScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  late DateTime selectedDate;
  late String name;
  late String phone;

  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();

  FocusNode _namefield = FocusNode();
  FocusNode _phonefield = FocusNode();
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  Future<void> addNewUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    await Provider.of<DataProvider>(context, listen: false)
        .addUser(name, phone, selectedDate);
  }

  showsnackbar() {
    final snackBar = SnackBar(
      content: Consumer<DataProvider>(
          builder: (_, data, __) => (data.message[0].isEmpty)
              ? Text('')
              : (data.message[0].isNotEmpty)
                  ? Text(data.message[0])
                  : Text('')),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Technical Assessment'),
        ),
        body: Stack(
          children: [
            Positioned(
                top: MediaQuery.of(context).size.width * 0.1,
                left: MediaQuery.of(context).size.width * 0.1,
                child: StorylineWidget())
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (bCtx) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                              decoration: InputDecoration(labelText: 'Name'),
                              controller: _namecontroller,
                              focusNode: _namefield,
                              validator: (value) {
                                if (value!.isEmpty) return 'enter name';
                              },
                              onFieldSubmitted: (value) {
                                name = value;
                              }),
                          TextFormField(
                              keyboardType: TextInputType.number,
                              decoration:
                                  InputDecoration(labelText: 'phone number'),
                              controller: _phonecontroller,
                              focusNode: _phonefield,
                              validator: (value) {
                                if (value!.isEmpty) return 'enter phone number';
                              },
                              onFieldSubmitted: (value) {
                                phone = value.toString();
                              }),
                          TextButton(
                            onPressed: _presentDatePicker,
                            child: Text('Pick date'),
                          ),
                          TextButton(
                            onPressed: () async {
                              await addNewUser();
                              Navigator.of(bCtx).pop();
                              showsnackbar();
                            },
                            child: Text('submit'),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
        ));
  }
}
