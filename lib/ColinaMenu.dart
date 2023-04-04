import 'package:flutter/material.dart';

class ColinaMenu extends StatelessWidget {
  const ColinaMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meniu Colina'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
    //return const ColinaMenu();
  }
}