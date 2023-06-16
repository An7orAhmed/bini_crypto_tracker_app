import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller.dart';

// ignore: must_be_immutable
class LogPage extends StatelessWidget {
  String id;
  LogPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    var appData = Provider.of<Controller>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("$id record"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => appData.deleteData(id),
          ),
        ],
      ),
      body: FutureBuilder(
        future: appData.loadData(id),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (appData.fullLog.isEmpty) {
            return const Center(
              child: Text(
                "No data recorded!",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100),
              ),
            );
          }

          return ListView.builder(
            itemCount: appData.fullLog.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(appData.fullLog[index].time.split(".")[0]),
                trailing: Text("USD ${appData.fullLog[index].rate}"),
              );
            },
          );
        },
      ),
    );
  }
}
