import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewExpenses extends StatefulWidget {
  @override
  _ViewExpensesState createState() => _ViewExpensesState();
}

class _ViewExpensesState extends State<ViewExpenses> {
  final Firestore firestore = Firestore.instance;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF20232a),
        title: Text(
          'My expenses',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        // height: 800,
        color: Color(0xFF20232a),
        child: Column(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: firestore.collection('expenses').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data.documents == null) {
                    Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    /// check if server response has not been received yet and loading is still ongoing
                    if (snapshot.data.documents != null &&
                        snapshot.data.documents is List<DocumentSnapshot>) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    // check for errors
                    if (snapshot.hasError) {
                      final Map<String, dynamic> error =
                          snapshot.error as Map<String, dynamic>;

                      /// check if the error is a timeout error and return an appropriate widget
                      if (error['error'] == 'timeout') {
                        return Text('Time out');
                      }

                      return Text('Snapshot returned error');
                    }

                    final List<DocumentSnapshot> data = snapshot.data.documents;

                    if (data != null) {
                      // final List<dynamic> inboxPayload = snapshot.data['data']
                      //         ['getUserMessages'] as List<dynamic> ??
                      //     <dynamic>[];

                      if (snapshot.data.documents.isEmpty) {
                        return Text('Empty inbox');
                      }

                      return Container(
                        height: MediaQuery.of(context).size.height - 270,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            final DocumentSnapshot document =
                                snapshot.data.documents[index];

                            return Container(
                              margin: EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        'Date Purchased' +
                                            ' ' +
                                            document['datePurchased']
                                                .toString(),
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  SizedBox(height: 10.0),
                                  Table(
                                    border: TableBorder.all(color: Colors.cyan),
                                    children: [
                                      TableRow(children: [
                                        Column(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('Expense Type',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('Quantity',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('Unit Price',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('Total Cost',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            )
                                          ],
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(document['expenseType'],
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              document['quantity'] +
                                                  ' ' +
                                                  document['item'],
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(document['unitPrice'],
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(document['totalCost'],
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ])
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('You have no expenses'),
                      ],
                    );
                  }
                  return Container();
                  // return Expanded(
                  //   child: Scrollbar(
                  //     isAlwaysShown: true,
                  //     child: ListView.builder(
                  //       itemCount: snapshot.data.documents.length,
                  //       itemBuilder: (contex, int index) {

                  // if (snapshot.data.documents.isEmpty) {
                  //   setState(() {
                  //     isLoading = true;
                  //   });
                  // }
                  // if (snapshot.data.documents == null) {
                  //   setState(() {
                  //     isLoading = true;
                  //   });
                  //   return Text('data');
                  // }
                  // final DocumentSnapshot document =
                  //     snapshot.data.documents[index];
                  // print(document['totalCost']);
                  // print(document['datePurchased']);
                  // print(document['item']);
                  // print(document['quantity']);
                  // print(document['unitPrice']);
                  // return (isLoading)
                  //     ? Center(
                  //         child: CircularProgressIndicator(),
                  //       )
                  //     : Container(
                  //         margin: EdgeInsets.all(20.0),
                  //         child: Column(
                  //           children: <Widget>[
                  //             Align(
                  //               alignment: Alignment.centerLeft,
                  //               child: Text(
                  //                   'Date Purchased' +
                  //                       ' ' +
                  //                       document['datePurchased']
                  //                           .toString(),
                  //                   style:
                  //                       TextStyle(color: Colors.white)),
                  //             ),
                  //             SizedBox(height: 10.0),
                  //             Table(
                  //               border:
                  //                   TableBorder.all(color: Colors.cyan),
                  //               children: [
                  //                 TableRow(children: [
                  //                   Column(
                  //                     children: <Widget>[
                  //                       Padding(
                  //                         padding:
                  //                             const EdgeInsets.all(8.0),
                  //                         child: Text('Expense Type',
                  //                             style: TextStyle(
                  //                                 color: Colors.white)),
                  //                       )
                  //                     ],
                  //                   ),
                  //                   Column(
                  //                     children: <Widget>[
                  //                       Padding(
                  //                         padding:
                  //                             const EdgeInsets.all(8.0),
                  //                         child: Text('Quantity',
                  //                             style: TextStyle(
                  //                                 color: Colors.white)),
                  //                       )
                  //                     ],
                  //                   ),
                  //                   Column(
                  //                     children: <Widget>[
                  //                       Padding(
                  //                         padding:
                  //                             const EdgeInsets.all(8.0),
                  //                         child: Text('Unit Price',
                  //                             style: TextStyle(
                  //                                 color: Colors.white)),
                  //                       )
                  //                     ],
                  //                   ),
                  //                   Column(
                  //                     children: <Widget>[
                  //                       Padding(
                  //                         padding:
                  //                             const EdgeInsets.all(8.0),
                  //                         child: Text('Total Cost',
                  //                             style: TextStyle(
                  //                                 color: Colors.white)),
                  //                       )
                  //                     ],
                  //                   ),
                  //                 ]),
                  //                 TableRow(children: [
                  //                   Padding(
                  //                     padding:
                  //                         const EdgeInsets.all(8.0),
                  //                     child: Text(
                  //                         document['expenseType'],
                  //                         style: TextStyle(
                  //                             color: Colors.white)),
                  //                   ),
                  //                   Padding(
                  //                     padding:
                  //                         const EdgeInsets.all(8.0),
                  //                     child: Text(
                  //                         document['quantity'] +
                  //                             ' ' +
                  //                             document['item'],
                  //                         style: TextStyle(
                  //                             color: Colors.white)),
                  //                   ),
                  //                   Padding(
                  //                     padding:
                  //                         const EdgeInsets.all(8.0),
                  //                     child: Text(document['unitPrice'],
                  //                         style: TextStyle(
                  //                             color: Colors.white)),
                  //                   ),
                  //                   Padding(
                  //                     padding:
                  //                         const EdgeInsets.all(8.0),
                  //                     child: Text(document['totalCost'],
                  //                         style: TextStyle(
                  //                             color: Colors.white)),
                  //                   ),
                  //                 ])
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //       },
                  //     ),
                  //   ),
                  // );
                }),
          ],
        ),
      ),
    );
  }
}
