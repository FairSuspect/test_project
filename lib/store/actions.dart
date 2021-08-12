import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:test_project/models/employee.dart';

import 'main.dart';

class SetEmployees {
  final List<Employee>? employees;
  SetEmployees(this.employees);
}

class AddEmployee {
  Employee employee;
  AddEmployee(this.employee);
}

class UpdateEmployee {
  Employee employee;
  UpdateEmployee(this.employee);
}

ThunkAction<AppState> saveEmployeesToLocalStorage(List<Employee> employees) {
  return (Store<AppState> store) async {
    await Employee.saveToLocalStorage(employees);
    store.dispatch(SetEmployees(employees));
  };
}

ThunkAction<AppState> clear() {
  return (Store<AppState> store) async {
    var employees = List<Employee>.empty();
    await Employee.saveToLocalStorage(employees);
    store.dispatch(SetEmployees(employees));
  };
}
