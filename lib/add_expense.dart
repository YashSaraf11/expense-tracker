import 'package:flutter/material.dart';
import 'package:expense_recreate/model.dart';

class AddExpense extends StatefulWidget {
  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  String _chosenValue = "Coffee";
  TextEditingController amountController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                      tooltip: "Go Back",
                      splashColor: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Add Amount',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                child: Text(
                  'Amount',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    prefix: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 10, 0),
                      child: Text(
                        "\$",
                        style: TextStyle(
                          letterSpacing: 2.0,
                          color: Colors.black87,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    suffix: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                      child: Text(
                        "USD",
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                child: Text(
                  'Expenses Made For',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(40.0, 10, 40, 5),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Select the Type of Expense",
                  ),
                  value: _chosenValue,
                  onChanged: (String value) {
                    setState(() {
                      _chosenValue = value;
                    });
                  },
                  items: <String>[
                    'Coffee',
                    'Snacks',
                    'Bank',
                    'Friend',
                    'Travel'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                child: Text(
                  'Description',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 20, 0),
                child: TextField(
                  controller: descriptionController,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(40, 2, 40, 2),
                    color: Colors.black,
                    elevation: 1.0,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          'SAVE EXPENSE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                          context,
                          new Expense(
                              amount: double.parse(amountController?.text),
                              type: _chosenValue,
                              description: descriptionController.text,
                              dateTime: DateTime.now()));
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
