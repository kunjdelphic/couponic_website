import 'package:flutter/material.dart';

PreferredSizeWidget CustomAppBar(BuildContext context) {
  TextEditingController search = TextEditingController();
  return AppBar(
    backgroundColor: Colors.grey[850],
    elevation: 0,
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.add, color: Colors.white), // Replace with logo
      ),
    ),
    title: Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [ const SizedBox(width: 86), 
        Container(
          width: 800, // Set fixed width for the search bar
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [ // Adjust spacing as needed
              Expanded(
                child: TextField(
                  controller: search,
                  decoration: InputDecoration(
                    hintText: 'Search "iPhone"',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Icon(Icons.search, color: Colors.red),
            ],
          ),
        ),
        const SizedBox(width: 86), // Adjust spacing as needed
        GestureDetector(
          onTap: () {
            // Add your wallet action here
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.account_balance_wallet, color: Colors.white),
                SizedBox(width: 4),
                Text(
                  '₹0',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(50), // Height of the options bar
      child: Container(
        color: Colors.grey[700],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildOption('Categories'),
            _buildOption('Top Stores'),
            _buildOption('Best Offers'),
            _buildOption('Collections'),
            _buildOption('Share & Earn'),
          ],
        ),
      ),
    ),
  );
}

Widget _buildOption(String title) {
  return GestureDetector(
    onTap: () {
      // Handle navigation or actions here
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}
