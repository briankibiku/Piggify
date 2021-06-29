import 'package:flutter/material.dart';
import 'package:piggify/home_page.dart';
import 'package:piggify/router_generator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(      
      onGenerateRoute: Router.generateRoute,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomePage( )
      ),
    );
    
  }
}
