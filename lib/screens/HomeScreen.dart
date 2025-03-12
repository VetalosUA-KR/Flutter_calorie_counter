import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
          'Home',
          style: TextStyle(
            fontSize: 22,
            color: AppColors.getText(context),
          ),
        ),
    );
  }
}