import 'dart:math';
import 'package:bini_crypto_app/screen/logs.dart';
import 'package:flutter/material.dart';
import '../model/rate.dart';

Widget coinCard(context, String name, String symbol, Rate rate) {
  Color color1 = Color.fromRGBO(
    Random().nextInt(255),
    Random().nextInt(255),
    Random().nextInt(255),
    0.7,
  );
  Color color2 = Color.fromRGBO(
    Random().nextInt(255),
    Random().nextInt(255),
    Random().nextInt(255),
    0.6,
  );
  return SizedBox(
    height: 185,
    width: double.maxFinite,
    child: Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        children: [
          Container(
            height: 90,
            width: double.maxFinite,
            decoration: BoxDecoration(gradient: LinearGradient(colors: [color1, color2])),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(child: Image.asset("assets/$name.png", width: 60, height: 60)),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 75, top: 17),
                    child: Text(
                      name,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 75, bottom: 17),
                    child: Text(
                      symbol,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.grey.shade700),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LogPage(id: name)));
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey.shade700,
                      size: 30,
                    ),
                  ),
                ),
              ]),
            ),
          ),
          SizedBox(
            height: 75,
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      "USD ${rate.usd_24h_change.toStringAsFixed(3)}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Text(
                      "24H Diff.",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      "USD ${rate.usd.toStringAsFixed(3)}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Text(
                      "Current Rate",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    ),
  );
}
