import 'package:couponic_website/ui/homepage/widget/dummy.dart';
import 'package:flutter/material.dart';

Widget categoryCard(int index,offer) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(height: 190,width: 200,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white, // Background color of the card
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 8.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo Section
            Image.asset(
              'assets/images/${getTitle(index).toLowerCase()}.png', // Replace with your logo URL
              height: 40.0,
            ),
            SizedBox(height: 10.0),
    
            // Title
            Text(
              offer['title'],
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
    
            // Cashback Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.currency_rupee, color: Colors.red, size: 20.0),
                Text(
                 offer['cashback'],
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.green[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
    
            // Button Section
            Container(width: 150,height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Add your button action here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                ),
                child: Text(
                  'Get Deal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
  );
}
