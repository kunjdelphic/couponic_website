
  import 'package:flutter/material.dart';

Widget buildFrontCard() {
    return Container(
      width: 200,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Center(
        child: Text(
          'Front Side',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }

  Widget buildBackCard() {
    return Container(
      width: 200,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Center(
        child: Text(
          'Back Side',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }