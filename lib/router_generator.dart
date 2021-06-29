import 'package:flutter/material.dart';
import 'package:piggify/add_mjengo_expense.dart';
import 'package:piggify/add_pig_expense.dart';
import 'package:piggify/main.dart';
import 'package:piggify/view_mjengo_expnses.dart';
import 'package:piggify/view_pig_expenses.dart';
import 'routes.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homePage:
        return MaterialPageRoute(builder: (_) => MyApp());
        break;
      case Routes.expensePage:
        return MaterialPageRoute(builder: (_) => AddExpense());
        break;
      case Routes.viewExpenses:
        return MaterialPageRoute(builder: (_) => ViewExpenses());
        break;
      case Routes.addMjengoExpenses:
        return MaterialPageRoute(builder: (_) => AddMjengoExpense());
        break;
      case Routes.viewMjengoExpenses:
        return MaterialPageRoute(builder: (_) => ViewMjengoExpenses());
        break;
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No such route named ${settings.name} found'),
            ),
          ),
        );
    }
  }
}
