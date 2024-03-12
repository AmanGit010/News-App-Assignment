import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Observer(
              builder: (_) {
                return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Text("data");
                  },
                );
              },
            ),
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Text("desktop");
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
