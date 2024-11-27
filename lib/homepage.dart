import 'package:couponic_website/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),
      body: const Center(
        child: Text(
          'Content goes here!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
