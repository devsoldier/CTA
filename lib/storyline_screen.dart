import 'package:cta/provider.dart';
import 'package:cta/sprite.dart';
import 'package:flutter/material.dart';
import './storyline_widget.dart';
import 'package:provider/provider.dart';

class StoryLineScreen extends StatefulWidget {
  static const routeName = '/storyline';

  @override
  State<StoryLineScreen> createState() => _StoryLineScreenState();
}

class _StoryLineScreenState extends State<StoryLineScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  List<DateTime> selectedDateTime = [];
  late String name;
  late String phone;

  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();

  FocusNode _namefield = FocusNode();
  FocusNode _phonefield = FocusNode();

  Future<void> _presentDatePicker() async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      selectedDateTime.insert(0, pickedDate);
    });
  }

  Future<void> _presentTimePicker() async {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime == null) {
        return;
      }

      selectedDateTime.insert(0, DateTime.parse(pickedTime.toString()));
    });
  }

  Future<void> addNewUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    await Provider.of<DataProvider>(context, listen: false)
        .addUser(name, phone, selectedDateTime[0]);
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(null);
        },
        child: Stack(
          children: [
            Positioned(
              left: MediaQuery.of(context).size.width * 0.1,
              child: StorylineWidget(),
            ),
            FlimSprite(),
          ],
        ),
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
                              if (value.length < 7) return 'add more';
                            },
                            onFieldSubmitted: (value) {
                              phone = value.toString();
                            }),
                        TextButton(
                          onPressed: () async {
                            await _presentDatePicker()
                                .then((_) => _presentTimePicker());
                          },
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
