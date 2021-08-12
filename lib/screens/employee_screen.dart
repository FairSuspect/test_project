import 'package:flutter/material.dart';
import 'package:test_project/models/child.dart';
import 'package:test_project/models/employee.dart';
import 'package:test_project/screens/add_child_screen.dart';
import 'package:test_project/store/actions.dart';
import 'package:test_project/store/main.dart';
import 'package:test_project/widgets/child_card.dart';

/// Экран с информацией о сотруднике и его детях
class EmployeeScreen extends StatefulWidget {
  final Employee employee;
  const EmployeeScreen({Key? key, required this.employee}) : super(key: key);

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  Employee employee = Employee.empty();
  @override
  void initState() {
    employee = widget.employee;
    super.initState();
  }

  void _onAddPressed() async {
    Child? newChild = await Navigator.push(context,
        MaterialPageRoute(builder: (_) => AddChildScreen(employee: employee)));
    if (newChild != null) {
      if (employee.hasChildren)
        employee.children!.add(newChild);
      else
        employee = Employee.addFirstChild(employee, newChild);
      store.dispatch(UpdateEmployee(employee));
      await Employee.saveToLocalStorage(store.state.employees ?? []);
    }
    setState(() {});
  }

  @override
  void setState(VoidCallback fn) {
    print("Children: ${employee.children}");
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              "${employee.lastName} ${employee.firstName} ${employee.surName}")),
      body: Container(
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: _onAddPressed,
              icon: Icon(Icons.person_add),
              label: Text("Добавить ребёнка"),
            ),
            Expanded(
                child: ListView(
              children: employee.children
                      ?.map((child) => ChildCard(child: child))
                      .toList() ??
                  [],
            ))
          ],
        ),
      ),
    );
  }
}
