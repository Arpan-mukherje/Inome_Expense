import 'dart:developer';

import 'package:assignment/Services/Firebase_services.dart/firestore_services.dart';
import 'package:assignment/screens/first_page.dart';
import 'package:flutter/material.dart';

class ExpanceScreen extends StatefulWidget {
  final String month;
  const ExpanceScreen({super.key, required this.month});

  @override
  _ExpanceScreen createState() => _ExpanceScreen();
}

class _ExpanceScreen extends State<ExpanceScreen> {
  String selectedOption1 = 'Expense';
  String selectedOption2 = 'Food';
  TextEditingController inputAmount = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        title: Text(
          "hello",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 68, 40, 255),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              color: const Color.fromARGB(255, 68, 40, 255),
              child: Padding(
                padding: const EdgeInsets.only(top: 400),
                child: Container(
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Updated DropdownButton with increased width and transparent background
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                                disabledBorder: InputBorder.none),
                            borderRadius: BorderRadius.circular(20),
                            value: selectedOption1,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedOption1 = newValue!;
                              });
                            },
                            items: <String>['Income', 'Expense']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Updated DropdownButton with increased width and transparent background
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                                disabledBorder: InputBorder.none),
                            value: selectedOption2,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedOption2 = newValue!;
                              });
                            },
                            items: <String>['Food', 'Subscriptions', 'Shopping']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),

                        const SizedBox(height: 16),
                        TextField(
                          controller: description,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 40),
                            backgroundColor:
                                const Color.fromARGB(255, 68, 40, 255),
                          ),
                          onPressed: () async {
                            log(widget.month);
                            await StorageServices.addData(
                                inputAmount: inputAmount.text,
                                inputType: selectedOption1,
                                category: selectedOption2,
                                description: description.text,
                                month: widget.month);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          },
                          child: const Text(
                            "Continue",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 208.0, left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How much ?",
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                  TextField(
                    controller: inputAmount,
                    style: const TextStyle(color: Colors.white, fontSize: 50),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.currency_rupee_sharp,
                          size: 44,
                          color: Colors.white,
                        ),
                        hintText: "0",
                        hintStyle: TextStyle(color: Colors.white, fontSize: 50),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
