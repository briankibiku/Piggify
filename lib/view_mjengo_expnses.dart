import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class ViewMjengoExpenses extends StatefulWidget {
  @override
  _ViewMjengoExpensesState createState() => _ViewMjengoExpensesState();
}

class _ViewMjengoExpensesState extends State<ViewMjengoExpenses> {
  final Firestore firestore = Firestore.instance;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF20232a),
        title: Text(
          'View Mjengo expenses',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        // height: 800,
        color: Color(0xFF20232a),
        child: Column(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: firestore.collection('mjengo_expenses').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  return Expanded(
                    child: Scrollbar(
                      isAlwaysShown: false,
                      child: ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (contex, int index) {
                          if (snapshot.data.documents.isEmpty) {
                            setState(() {
                              isLoading = true;
                            });
                          }
                          if (snapshot.data.documents == null) {
                            setState(() {
                              isLoading = true;
                            });
                            return Text('data');
                          }
                          final DocumentSnapshot document =
                              snapshot.data.documents[index];
                          print(document['totalCost']);
                          print(document['datePurchased']);
                          print(document['item']);
                          print(document['quantity']);
                          print(document['unitPrice']);
                          return (isLoading)
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Container(
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
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                      SizedBox(height: 10.0),
                                      Table(
                                        border:
                                            TableBorder.all(color: Colors.cyan),
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  document['expenseType'],
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  document['quantity'] +
                                                      ' ' +
                                                      document['item'],
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(document['unitPrice'],
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                          // return ListTile(
                          //   title: Column(
                          //     children: <Widget>[
                          //       Text(document['totalCost']),
                          //       Text(document['datePurchased'].toString()),
                          //       Text(document['item']),
                          //       Text(document['quantity']),
                          //       Text(document['unitPrice']),
                          //     ],
                          //   ),
                          //   // subtitle: Text(document['author']),
                          // );
                        },
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

// return ListView(
//                       children: snapshot.data.documents
//                           .map((DocumentSnapshot document) {
//                     print(document['title']);
//                     return ListTile(
//                       title: Text(document['title']),
//                     );
//                   }).toList());
