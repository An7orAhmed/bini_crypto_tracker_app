import 'package:flutter/material.dart';

Widget header(int updateMin, upAction, downAction) {
  return SizedBox(
    height: 80,
    width: double.maxFinite,
    child: Card(
      margin: EdgeInsets.zero,
      color: Colors.grey.shade300,
      elevation: 0,
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Text(
                "Welcome to,",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(bottom: 15, left: 20),
              child: Text(
                "Crypto Coins",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 40,
              width: 160,
              child: Card(
                margin: const EdgeInsets.only(right: 20),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: downAction, icon: const Icon(Icons.do_disturb_on)),
                    Text("$updateMin min"),
                    IconButton(onPressed: upAction, icon: const Icon(Icons.add_circle)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
