import 'package:flutter/material.dart';

class mysquare extends StatelessWidget {
  final String child;

  const mysquare({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 400,
        color: Colors.red,
        child: Center(
          child: Text(
            child,
            style: const TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}