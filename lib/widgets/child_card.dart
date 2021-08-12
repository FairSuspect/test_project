import 'package:flutter/material.dart';
import 'package:test_project/helpers/date_helper.dart';
import 'package:test_project/models/child.dart';

/// Карточка с информацией о ребёнке `Child`

class ChildCard extends StatelessWidget {
  final Child child;
  const ChildCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        height: 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(child.fullName),
            Text(DateFormater.ddmmyyyy(child.dateOfBirth),
                style: Theme.of(context).textTheme.caption)
          ],
        ),
      ),
    );
  }
}
