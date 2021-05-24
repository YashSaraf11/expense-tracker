import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expense_recreate/add_expense.dart';
import 'package:hover_effect/hover_effect.dart';
import 'model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double totalAmount = 0;
  Expense newExpense;
  String _chosenValue;
  List<Expense> expenses = [];

  Map<String, IconData> icons = <String, IconData>{
    'Coffee': FontAwesomeIcons.coffee,
    'Snacks': FontAwesomeIcons.cookieBite,
    'Bank': FontAwesomeIcons.piggyBank,
    'Travel': FontAwesomeIcons.car,
    'Friend': FontAwesomeIcons.userFriends,
  };

  // Making the application fullscreen
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  //Function to update the expenses list and the total sum of expenses
  void addExpense(Expense currExpense) {
    setState(() {
      expenses.add(currExpense);
      totalAmount = 0;
      for (int i = 0; i < expenses.length; i++) {
        totalAmount += expenses[i].amount;
      }
    });
  }

  void deleteExpense(Expense currExpense) {
    setState(() {
      expenses.remove(currExpense);
      totalAmount = 0;
      for (int i = 0; i < expenses.length; i++) {
        totalAmount += expenses[i].amount;
      }
    });
  }

  void updateExpense() {
    setState(() {
      totalAmount = 0;
      for (int i = 0; i < expenses.length; i++) {
        totalAmount += expenses[i].amount;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(25, 50, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.dashboard_rounded,
                          color: Colors.black,
                          size: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                          child: Text(
                            'Dashboard',
                            style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image.network(
                        'https://googleflutter.com/sample_image.jpg',
                        height: 60,
                        width: 60,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 150,
                width: 350,
                child: HoverCard(
                  depthColor: Colors.black,
                  depth: 15,
                  builder: (context, hovering) {
                    return Container(
                      padding: EdgeInsets.fromLTRB(40, 50, 40, 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "\$",
                                style: TextStyle(
                                  letterSpacing: 2.0,
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                                child: Text(
                                  totalAmount.toString(),
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text(
                            "USD",
                            style: TextStyle(
                              letterSpacing: 2.0,
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(40),
                      //   color: Colors.black,
                      //   boxShadow: [
                      //     BoxShadow(
                      //       blurRadius: 1.0, // soften the shadow
                      //       spreadRadius: 1.5, //extend the shadow
                      //     )
                      //   ],
                      // ),
                    );
                  },
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'All Expenses',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //ListView Generation
              ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: expenses?.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: GestureDetector(
                      onDoubleTap: () {
                        TextEditingController amountController =
                            new TextEditingController(
                                text: expenses[index].amount.toString());
                        TextEditingController descriptionController =
                            new TextEditingController(
                                text: expenses[index].description);
                        _chosenValue = expenses[index].type;
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return SingleChildScrollView(
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 70,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(30, 0, 0, 0),
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
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                                            padding: const EdgeInsets.fromLTRB(
                                                30, 0, 10, 0),
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
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 10, 10, 20),
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
                                      padding:
                                          EdgeInsets.fromLTRB(40, 0, 20, 0),
                                      child: DropdownButtonFormField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(30.0),
                                            ),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                              color: Colors.grey[800]),
                                          hintText:
                                              "Select the Type of Expense",
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
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  color: Colors.black),
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
                                      padding:
                                          EdgeInsets.fromLTRB(40, 0, 20, 0),
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
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            // ignore: deprecated_member_use
                                            RaisedButton(
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 2, 20, 2),
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
                                                expenses[index].amount =
                                                    double.parse(
                                                        amountController?.text);
                                                expenses[index].description =
                                                    descriptionController.text;
                                                expenses[index].type =
                                                    _chosenValue;

                                                Navigator.pop(
                                                  context,
                                                );
                                                updateExpense();
                                              },
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                            // ignore: deprecated_member_use
                                            RaisedButton(
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 2, 20, 2),
                                              color: Colors.black,
                                              elevation: 1.0,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: Text(
                                                    'DELETE EXPENSE',
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
                                                );
                                                deleteExpense(expenses[index]);
                                              },
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.black12,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.purple,
                                      ),
                                      child: Center(
                                        child: FaIcon(
                                            icons[expenses[index].type],
                                            size: 20,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 0, 0),
                                          child: Text(
                                            expenses[index].type,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Text(
                                            expenses[index].description,
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '\$',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      expenses[index].amount.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          newExpense = await Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) => new AddExpense()));

          addExpense(newExpense);
        },
        tooltip: 'Add Expense',
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
