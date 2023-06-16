import 'dart:async';
import 'dart:convert';
import 'package:bini_crypto_app/model/log.dart';
import 'package:bini_crypto_app/variables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/rate.dart';

class Controller extends ChangeNotifier {
  int _updateMin = 1;
  List<Rate> rates = [];
  List<Log> fullLog = [];
  List<String> coins = ["bitcoin", "ethereum", "tether", "dogecoin", "solana"];
  List<String> symbols = ["BTC", "ETH", "USDT", "DOGE", "SOL"];
  bool isFirstRun = false;

  int get updateMin => _updateMin;

  void updateMinAdd() {
    _updateMin++;
    if (_updateMin > 15) _updateMin = 15;
    notifyListeners();
  }

  void updateMinMinus() {
    _updateMin--;
    if (_updateMin < 1) _updateMin = 1;
    notifyListeners();
  }

  Future<void> initRates() async {
    if (isFirstRun) return;
    rates.clear();
    for (var coin in coins) {
      rates.add(Rate(id: coin, usd: 0.0, usd_24h_change: 0.0));
    }
    await fetchRate();
    // scheduling for fetch rate
    Timer.periodic(Duration(minutes: updateMin), (timer) => fetchRate());
    isFirstRun = true;
  }

  Future<void> fetchRate() async {
    String coinStr = "";
    for (var coin in coins) {
      coinStr += '$coin,';
    }
    var resp = await http.get(Uri.parse(
        "https://api.coingecko.com/api/v3/simple/price?ids=$coinStr&vs_currencies=usd&include_24hr_change=true"));
    if (resp.body.contains("error_code")) {
      print("API limit trigger.");
      return;
    }
    Map<String, dynamic> json = jsonDecode(resp.body);
    json.forEach((key, value) {
      Map<String, dynamic> rate = value;
      rates.firstWhere((element) => element.id == key).usd = double.parse(rate["usd"].toString());
      rates.firstWhere((element) => element.id == key).usd_24h_change = double.parse(rate["usd_24h_change"].toString());
    });

    for (var rate in rates) {
      var db = await database;
      String time = DateTime.now().toString();
      await db.insert("logs", {'time': time, 'name': rate.id, 'rate': rate.usd});
    }
    notifyListeners();
  }

  Future<void> loadData(String id) async {
    fullLog.clear();
    var db = await database;
    var data = await db.query("logs", where: "name = ?", whereArgs: [id]);
    fullLog.addAll(data.map((e) => Log.fromMap(e)).toList());
  }

  Future<void> deleteData(String id) async {
    fullLog.clear();
    var db = await database;
    await db.delete("logs", where: "name = ?", whereArgs: [id]);
    notifyListeners();
  }
}
