import 'package:flutter/material.dart';

class mysquareRow extends StatelessWidget {
  final String child;

  const mysquareRow({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 400,
        color: Colors.blue,
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