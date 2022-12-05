import 'package:flutter/material.dart';
import 'package:zitro_connect_v1/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Siguiente"),
        actions: [
          InkWell(
              onTap: () => Navigator.pushNamed(context, ROUTE_HOME),
              child: const Padding(
                  padding: EdgeInsets.all(10.0), child: Icon(Icons.add)))
        ],
      ),
      body: const Center(
        child: Text("Home Page"),
      ),
    );
  }
}
