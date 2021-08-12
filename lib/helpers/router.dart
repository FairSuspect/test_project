import 'package:flutter/material.dart';
import 'package:test_project/main.dart';
import 'package:test_project/models/employee.dart';
import 'package:test_project/screens/add_employee_screen.dart';
import 'package:test_project/screens/employee_screen.dart';

/// Методы генерации именованых путей
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print(settings.name);
    // if (settings.name == Routes.themeSettings) {
    //   final args = settings.arguments as ThemeSettings;
    //   return PageRouteBuilder(
    //     pageBuilder: (context, animation, secondaryAnimation) {
    //       return ThemeSettingsScreen(settings: args);
    //     },
    //   );
    // }
    RouteBuilder? route = routes.firstWhere((x) => x.routeName == settings.name,
        orElse: () => RouteBuilder('none', (args) => Container()));
    if (route.routeName == 'none')
      return MaterialPageRoute(
        builder: (context) => MyHomePage(title: "ТЕстовый проект"),
      );

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return route.widget(settings.arguments);
      },
      settings: settings,
      transitionDuration: Duration(seconds: 1),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          child: child,
          position: offsetAnimation,
        );
      },
    );
  }
}

class RouteBuilder {
  final String routeName;
  final Widget Function(Object? args) widget;

  RouteBuilder(this.routeName, this.widget);
}

/// Массив именованных путей
class Routes {
  static const main = '/';
  static const addEmployee = '/add_employee';
  static const employee = '/employee';
  static const addChild = '/employee/add_achild';
  static const child = '/employee/child';
}

final routes = [
  RouteBuilder(Routes.main, (args) => MyHomePage(title: "Тестовый проект")),
  RouteBuilder(Routes.addEmployee, (args) => AddEmployeeScreen()),
  RouteBuilder(
      Routes.employee, (args) => EmployeeScreen(employee: args as Employee))
];
