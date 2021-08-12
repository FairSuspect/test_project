import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:test_project/helpers/router.dart';
import 'package:test_project/models/employee.dart';
import 'package:test_project/services/localstorage.dart';
import 'package:test_project/store/actions.dart';
import 'package:test_project/store/main.dart';
import 'package:test_project/widgets/employee_card.dart';

import 'screens/add_employee_screen.dart';

void main() async {
  var ready = await localstorage.ready;
  print("localstorage ready: $ready");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Корень приложения
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Test',
        theme: ThemeData.dark(),
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: Routes.main,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Employee> employees = List.empty();
  @override
  void initState() {
    super.initState();
  }

  void _onAddPressed() async {
    Employee? newEmployee = await Navigator.push(
        context, MaterialPageRoute(builder: (_) => AddEmployeeScreen()));
    if (newEmployee != null) {
      store.dispatch(AddEmployee(newEmployee));
      await Employee.saveToLocalStorage(store.state.employees ?? []);
      employees.add(newEmployee);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton.icon(
                onPressed: _onAddPressed,
                icon: Icon(Icons.person_add),
                label: Text("Добавить сотрудника")),
          ),
          Expanded(
            child: ListView(
              children: store.state.employees
                      ?.map((e) => EmployeeCard(employee: e))
                      .toList() ??
                  [],
            ),
          )
        ],
      ),
    );
  }
}
