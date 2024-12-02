import 'package:flutter/material.dart';

final List<String> images = [
  'assets/images/banner_1.jpeg',
  'assets/images/banner2.jpeg',
  'assets/images/banner3.jpeg',
  'assets/images/banner4.jpeg',
  'assets/images/banner5.jpeg',
  'assets/images/banner6.jpeg',
];

Widget buildOfferCard(int index) {
  return Container(
    width: 300,
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    child: Row(
      children: [
        // First image
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)
          
            ),
            child: Image.asset(
              images[index],
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        // Second image
        Expanded(
          child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)
          
            ),
            child: Image.asset(
              images[index + 2],
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ),
  );
}
