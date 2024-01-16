import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  final String title;
  final String desc;
  final String ammount;
  final String inputType;
  final String time;

  const ListWidget(
      {super.key,
      required this.title,
      required this.desc,
      required this.ammount,
      required this.inputType,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(height: 70, width: 70, child: imageSelector(title)),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(inputType == "Expense" ? "-$ammount" : "+$ammount",
                  style: TextStyle(
                      color: inputType == "Expense" ? Colors.red : Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
              Text(
                time,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget imageSelector(String title) {
    log(title);
    if (title == "Subscriptions") {
      return Image.asset("assets/1.png");
    } else if (title == "Food") {
      return Image.asset("assets/2.png");
    } else {
      return Image.asset("assets/3.png");
    }
  }
}
