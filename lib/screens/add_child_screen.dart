import 'package:flutter/material.dart';
import 'package:test_project/helpers/date_helper.dart';
import 'package:test_project/helpers/validators.dart';
import 'package:test_project/models/child.dart';
import 'package:test_project/models/employee.dart';

/// Экран с формой добавления ребёнка
class AddChildScreen extends StatefulWidget {
  final Employee employee;
  const AddChildScreen({Key? key, required this.employee}) : super(key: key);

  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddChildScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();

  Future<DateTime?> _showDialog() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    return date;
  }

  String? lastName;
  String? firstName;
  String? surName;
  DateTime? date;

  void _onDonePressed() {
    if (_formKey.currentState!.validate() && date != null) {
      _formKey.currentState!.save();
      Child child = Child(
        lastName: lastName!,
        firstName: firstName!,
        surName: surName!,
        dateOfBirth: date!,
      );
      Navigator.pop(context, child);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Добавление сотрудника"),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                validator: Validators.notEmpty,
                decoration: InputDecoration(
                    labelText: "Фамилия",
                    border: OutlineInputBorder(),
                    hintText: "Иванов"),
                onSaved: (newValue) {
                  lastName = newValue;
                },
              ),
              TextFormField(
                validator: Validators.notEmpty,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Имя",
                    hintText: "Иван"),
                onSaved: (newValue) {
                  firstName = newValue;
                },
              ),
              TextFormField(
                validator: Validators.notEmpty,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Отчество",
                    hintText: "Иванович"),
                onSaved: (newValue) {
                  surName = newValue;
                },
              ),
              Text("Дата рождения"),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1!
                              .color!),
                      borderRadius: BorderRadius.circular(10)),
                  height: 50,
                  width: 150,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          date == null ? '' : DateFormater.ddmmyyyy(date!),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Icon(Icons.calendar_today)
                      ]),
                ),
                onTap: () async {
                  date = await _showDialog();
                  setState(() {});
                },
              ),
              Center(
                  child: ElevatedButton(
                      onPressed: _onDonePressed, child: Text("Добавить")))
            ]
                .map((e) => Padding(
                      padding: EdgeInsets.all(8),
                      child: e,
                    ))
                .toList(),
          )),
    );
  }
}
