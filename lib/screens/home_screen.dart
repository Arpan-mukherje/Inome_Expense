import 'dart:developer';
import 'package:assignment/Services/Firebase_services.dart/firestore_services.dart';
import 'package:assignment/screens/income_expense_input_screen.dart';
import 'package:assignment/widgets/list_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction {
  final String type; // "Income" or "Expense"
  final double amount;
  final DateTime date;
  final String title;

  Transaction({
    required this.type,
    required this.amount,
    required this.date,
    required this.title,
  });
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  List<Transaction> transactions = [];
  String selectedMonth = DateFormat('MMMM').format(DateTime.now());

  List<Transaction> allTransactions = []; // Store the original list

  @override
  void initState() {
    super.initState();
    _filterByMonth();
  }

  final Map<String, int> monthMap = {
    'January': 1,
    'February': 2,
    'March': 3,
    'April': 4,
    'May': 5,
    'June': 6,
    'July': 7,
    'August': 8,
    'September': 9,
    'October': 10,
    'November': 11,
    'December': 12,
  };

  void _filterByMonth() {
    final selectedYear = DateTime.now().year;

    final monthMap = {
      'January': 1,
      'February': 2,
      'March': 3,
      'April': 4,
      'May': 5,
      'June': 6,
      'July': 7,
      'August': 8,
      'September': 9,
      'October': 10,
      'November': 11,
      'December': 12,
    };

    final selectedMonthIndex = monthMap[selectedMonth];

    setState(() {
      transactions = allTransactions
          .where((transaction) =>
              transaction.date.year == selectedYear &&
              transaction.date.month == selectedMonthIndex)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: CircleAvatar(
                    child: Image.asset("assets/Avatar.png"),
                  ),
                ),
                DropdownButton<String>(
                  value: selectedMonth,
                  items: _buildMonthDropdownItems(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedMonth = newValue;
                        _filterByMonth();
                      });
                    }
                  },
                  icon: const Visibility(
                      visible: false, child: Icon(Icons.arrow_downward)),
                  underline: Container(),
                  selectedItemBuilder: (BuildContext context) {
                    return _buildMonthDropdownItems()
                        .map<Widget>((DropdownMenuItem<String> item) {
                      return Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.keyboard_arrow_down,
                                color: Colors.deepPurple, size: 32),
                            Text(selectedMonth,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16)),
                            const SizedBox(width: 12),
                          ],
                        ),
                      );
                    }).toList();
                  },
                ),
                const Icon(
                  Icons.notifications,
                  color: Colors.deepPurple,
                  size: 30,
                )
              ],
            ),
          ),
          Column(
            children: [
              const Text("Account Balance",
                  style: TextStyle(color: Colors.grey, fontSize: 16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.currency_rupee,
                    color: Colors.black,
                    size: 24,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: StorageServices.getData(selectedMonth),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child:
                                  CircularProgressIndicator()); // or any other loading indicator
                        }
                        if (snapshot.hasError) {
                          log('Error: ${snapshot.error}');
                        }
                        if (!snapshot.hasData) {
                          return Container();
                        }

                        final List<DocumentSnapshot> documents =
                            snapshot.data!.docs;
                        var income = 0;
                        var expense = 0;

                        for (var i = 0; i < documents.length; i++) {
                          Map<String, dynamic> data =
                              documents[i].data() as Map<String, dynamic>;
                          if (documents.isEmpty) {
                            income = 0;
                          }
                          if (data['inputtype'] == "Income") {
                            income = income +
                                (data['inputamount'] != null
                                    ? int.parse(data['inputamount'].toString())
                                    : 0);
                          } else if (data['inputtype'] == "Expense") {
                            expense = expense +
                                (data['inputamount'] != null
                                    ? int.parse(data['inputamount'].toString())
                                    : 0);
                          }
                        }
                        return Text(
                          '${income - expense}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        );
                      }),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: StorageServices.getData(selectedMonth),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child:
                                CircularProgressIndicator()); // or any other loading indicator
                      }
                      if (snapshot.hasError) {
                        log('Error: ${snapshot.error}');
                      }
                      if (!snapshot.hasData) {
                        return Container();
                      }

                      final List<DocumentSnapshot> documents =
                          snapshot.data!.docs;

                      int income = 0;

                      for (var i = 0; i < documents.length; i++) {
                        Map<String, dynamic> data =
                            documents[i].data() as Map<String, dynamic>;
                        if (documents.isEmpty) {
                          income = 0;
                        }
                        if (data['inputtype'] == "Income") {
                          income = income +
                              (data['inputamount'] != null
                                  ? int.parse(data['inputamount'].toString())
                                  : 0);
                        }
                      }

                      return Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00A86B),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Center(
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    child: Image.asset("assets/Frame 27.png"),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const Text(
                                    'Income',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(
                                        Icons.currency_rupee,
                                        color: Colors.white,
                                      ),
                                      Flexible(
                                          child: Text(
                                        income.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: StorageServices.getData(selectedMonth),
                      builder: (context, snapshot) {
                        int expense = 0;
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          log('Error: ${snapshot.error}');
                        }
                        if (!snapshot.hasData) {
                          return Container();
                        }

                        final List<DocumentSnapshot> documents =
                            snapshot.data!.docs;

                        for (var i = 0; i < documents.length; i++) {
                          Map<String, dynamic> data =
                              documents[i].data() as Map<String, dynamic>;
                          if (data['inputamount'] == null || data.isEmpty) {
                            log("gghhghff");
                            expense = 0;
                            break;
                          }
                          if (data['inputtype'] == "Expense") {
                            expense = expense +
                                (data['inputamount'] != null
                                    ? int.parse(data['inputamount'].toString())
                                    : 0);
                          }
                        }

                        return Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFD3C4A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Center(
                                    child: Container(
                                      height: 45,
                                      width: 45,
                                      child: Image.asset("assets/expense.png"),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text(
                                      'Expense',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(
                                          Icons.currency_rupee,
                                          color: Colors.white,
                                        ),
                                        Flexible(
                                            child: Text(
                                          expense.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 19,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }))
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: StorageServices.getData(selectedMonth),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Container(
                      child: const Center(
                          child: Text(
                        "No Trasaction done in this month",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )),
                    );
                  } else {
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;
                    return ListView.builder(
                      //   reverse: true,
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        log(documents.length.toString());
                        Map<String, dynamic> data =
                            documents[index].data() as Map<String, dynamic>;
                        return ListWidget(
                          title: data['category'],
                          desc: data['description'],
                          ammount: data['inputamount'],
                          inputType: data['inputtype'],
                          time: "",
                        );
                      },
                    );
                  }
                }),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        //  isExtended: true,

        backgroundColor: const Color.fromARGB(255, 68, 40, 255),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => IncomeExpenseInputScreen(
                        month: selectedMonth,
                      )));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildMonthDropdownItems() {
    List<DropdownMenuItem<String>> items = [];

    for (int i = 1; i <= 12; i++) {
      DateTime monthDate = DateTime(DateTime.now().year, i, 1);
      String monthString = DateFormat('MMMM').format(monthDate);
      items.add(DropdownMenuItem<String>(
        value: monthString,
        child: Text(monthString),
      ));
    }

    return items;
  }
}
