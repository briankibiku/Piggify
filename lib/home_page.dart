import 'package:flutter/material.dart';
import 'package:piggify/routes.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
            padding: const EdgeInsets.only(top: 40.0 ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 60,
                    width: 60,
                    child: Image(
                      image: AssetImage(
                        'assets/images/logo.png',
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Welcome to Piggify',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xFF20232a),
                  // border: Border.all(width: 0, color: Color(0xFF5fd6f6)),
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(40))),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 40.0, bottom: 20.0, right: 20.0, left: 20.0),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.expensePage);
                      },
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                            color: Colors.cyan,
                            // border: Border.all(width: 0.2, color: Color(0xFF5fd6f6)),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Add pig expense',
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(Icons.chevron_right, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.viewExpenses);
                      },
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                            color: Colors.cyan,
                            // border: Border.all(width: 0.2, color: Color(0xFF5fd6f6)),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'View pig expense',
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(Icons.chevron_right, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.addMjengoExpenses);
                      },
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                            color: Colors.cyan,
                            // border: Border.all(width: 0.2, color: Color(0xFF5fd6f6)),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Add mjengo expense',
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(Icons.chevron_right, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.viewMjengoExpenses);
                      },
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                            color: Colors.cyan,
                            // border: Border.all(width: 0.2, color: Color(0xFF5fd6f6)),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'View mjengo expense',
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(Icons.chevron_right, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
