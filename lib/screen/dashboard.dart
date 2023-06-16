import 'package:bini_crypto_app/controller.dart';
import 'package:bini_crypto_app/widgets/coin_card.dart';
import '../widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    var appData = Provider.of<Controller>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            header(appData.updateMin, () => appData.updateMinAdd(), () => appData.updateMinMinus()),
            FutureBuilder(
              future: appData.initRates(),
              builder: (context, data) {
                if (data.connectionState != ConnectionState.done) {
                  return const Expanded(child: Center(child: CircularProgressIndicator()));
                }
                if (appData.coins.isEmpty) {
                  return const Expanded(
                    child: Center(
                      child: Text(
                        "No data!\nAPI limit reached!",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100),
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      children: [
                        for (int i = 0; i < appData.coins.length; i++)
                          coinCard(
                            context,
                            appData.coins[i],
                            appData.symbols[i],
                            appData.rates.firstWhere((element) => element.id == appData.coins[i]),
                          )
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
