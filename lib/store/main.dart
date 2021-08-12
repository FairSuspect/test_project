import 'package:redux/redux.dart';
import 'package:test_project/models/employee.dart';
import 'package:test_project/store/reducers.dart';

class AppState {
  final List<Employee>? employees;
  AppState({required this.employees});
  AppState.initialState() : employees = Employee.fromLocalStorage();
}

/// Редьюсер состояния приложения, удобен для расширения функционала путём добавления новых полей
AppState appStateReducer(AppState state, action) {
  var employees = state.employees;
  if (action.toString().contains("Employee"))
    employees = employeeListReducer(employees, action);
  return AppState(employees: employees);
}

final store =
    Store<AppState>(appStateReducer, initialState: AppState.initialState());
