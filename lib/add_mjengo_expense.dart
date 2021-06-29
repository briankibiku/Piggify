import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:piggify/routes.dart';
// import 'package:firebase_core/firebase_core.dart';


class AddMjengoExpense extends StatefulWidget {
  @override
  _AddMjengoExpenseState createState() => _AddMjengoExpenseState();
}

class _AddMjengoExpenseState extends State<AddMjengoExpense> {
  final Firestore firestore = Firestore.instance;

  final TextEditingController dateController = TextEditingController();

  final TextEditingController quantityController = TextEditingController();

  final TextEditingController expeseTypeController = TextEditingController();

  final TextEditingController unitPriceController = TextEditingController();
  bool isExpenseFilled = false;
  bool isItemFilled = false;
  bool isQuantityFilled = false;
  bool isUnitPriceFilled = false;
  List<String> items = ['Tonnes', 'Packets', 'Kgs', 'Accessories', 'Labor', 'Materials'];
  String selectedItem;
  bool isSelectedItem = false;
  bool isLoading = false;
  void showInSnackBar(String value) {
    Scaffold.of(context).showSnackBar(
        SnackBar(duration: Duration(seconds: 5), content: Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF20232a),
      appBar: AppBar(
        backgroundColor: Color(0xFF20232a),
        title: Text(
          'Add Mjengo Expense',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Builder(
        builder: (context) => Container(
          // height: MediaQuery.of(context).size.height,
          child: (isLoading)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 45,
                        child: TextFormField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          onChanged: (_) {
                            setState(() {
                              isExpenseFilled = true;
                            });
                          },
                          controller: expeseTypeController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              borderSide: BorderSide(
                                color: Colors.cyan,
                                width: 2.0,
                              ),
                            ),
                            fillColor: Colors.white,
                            focusColor: Colors.white,
                            labelText: 'Expense type',
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.cyan),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        height: 45,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                onChanged: (_) {
                                  setState(() {
                                    isQuantityFilled = true;
                                  });
                                },
                                controller: quantityController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    borderSide: BorderSide(
                                      color: Colors.cyan,
                                      width: 2.0,
                                    ),
                                  ),
                                  // suffixIcon: Icon(Icons.search),
                                  labelText: 'Quantity',
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(color: Colors.cyan),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40.0)),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: DropdownButtonFormField(
                                value: selectedItem,
                                iconEnabledColor: Colors.white,
                                onChanged: (value) {
                                  setState(() {
                                    selectedItem = value;
                                    isSelectedItem = true;
                                    isItemFilled = true;
                                  });
                                },
                                hint: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    'Item',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                      color: Colors.cyan,
                                    ),
                                  ),
                                ),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.cyan,
                                ),
                                items: items.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                          color: Colors.cyan,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        height: 45,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          onChanged: (_) {
                            setState(() {
                              isUnitPriceFilled = true;
                            });
                          },
                          controller: unitPriceController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              borderSide: BorderSide(
                                color: Colors.cyan,
                                width: 2.0,
                              ),
                            ),
                            // suffixIcon: Icon(Icons.search),
                            labelText: 'Unit Price (Kshs)',
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.cyan),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        width: double.infinity,
                        height: 56,
                        child: MaterialButton(
                          onPressed: () async {
                            if (!isExpenseFilled ||
                                !isUnitPriceFilled ||
                                !isQuantityFilled ||
                                !isItemFilled) {
                              _displaySnackBar(context,
                                  'Make sure all fields are filled before saving');
                            }
                            var now = new DateTime.now();
                            var formatter = new DateFormat('dd-MM-yyyy');
                            String dateExpenseAdded = formatter.format(now);
                            final totalCost =
                                int.parse(unitPriceController.text) *
                                    int.parse(quantityController.text);
                            if (isExpenseFilled &&
                                isQuantityFilled &&
                                isUnitPriceFilled &&
                                isItemFilled) {
                              setState(() {
                                isLoading = true;
                              });
                              await Firestore.instance
                                  .collection('mjengo_expenses')
                                  // .document(dateExpenseAdded.toString())
                                  .document()
                                  .setData({
                                'expenseType': expeseTypeController.text,
                                'item': selectedItem.toString(),
                                'quantity': quantityController.text,
                                'unitPrice': unitPriceController.text,
                                'totalCost': totalCost.toString(),
                                'datePurchased': dateExpenseAdded.toString(),
                              });
                              await Navigator.pushReplacementNamed(
                                  context, Routes.homePage);
                            }
                          },
                          child: Text(
                            'Add Expense',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.cyan,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

_displaySnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0))),
    content: Text(message),
    duration: Duration(seconds: 5),
  );
  Scaffold.of(context).showSnackBar(snackBar);
}
