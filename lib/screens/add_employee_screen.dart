import 'package:flutter/material.dart';
import 'package:test_project/helpers/validators.dart';
import 'package:test_project/models/employee.dart';

/// Экран с формой добавления сотрудника
class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({Key? key}) : super(key: key);

  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
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
  String? position;

  void _onDonePressed() {
    if (_formKey.currentState!.validate() && date != null) {
      _formKey.currentState!.save();
      Employee employee = Employee(
          lastName: lastName!,
          firstName: firstName!,
          surName: surName!,
          dateOfBirth: date!,
          position: position!);
      Navigator.pop(context, employee);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Добавление сотрудника"),
      ),
      body: SingleChildScrollView(
        child: Form(
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
                            date == null
                                ? ''
                                : "${date!.day}.${date!.month}.${date!.year}",
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
                TextFormField(
                  validator: Validators.notEmpty,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Должность",
                      hintText: "Руководитель"),
                  onSaved: (newValue) {
                    position = newValue;
                  },
                ),
                Center(
                    child: ElevatedButton(
                        onPressed: _onDonePressed, child: Text("Добавить")))
              ]
                  .map((e) => Padding(padding: EdgeInsets.all(8), child: e))
                  .toList(),
            )),
      ),
    );
  }
}
