import 'package:flutter/material.dart';
import 'package:test_project/helpers/date_helper.dart';
import 'package:test_project/helpers/router.dart';
import 'package:test_project/models/employee.dart';

/// Карточка с информацией о сотруднике `Employee`
class EmployeeCard extends StatelessWidget {
  final Employee employee;
  const EmployeeCard({Key? key, required this.employee}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: InkWell(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(employee.fullName),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(employee.position,
                        style: Theme.of(context).textTheme.caption),
                    Text(DateFormater.ddmmyyyy(employee.dateOfBirth),
                        style: Theme.of(context).textTheme.caption)
                  ],
                ),
                employee.hasChildren
                    ? Text("Количество детей: ${employee.children!.length}")
                    : Container()
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed(Routes.employee, arguments: employee);
        },
      ),
    );
  }
}
