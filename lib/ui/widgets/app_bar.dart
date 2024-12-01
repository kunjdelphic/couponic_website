import 'package:flutter/material.dart';

PreferredSizeWidget CustomAppBar(BuildContext context) {
  TextEditingController search = TextEditingController();
  return AppBar(
    backgroundColor: Colors.grey[850],
    elevation: 2,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 86),
        Container(
          width: 700, // Set fixed width for the search bar
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              // Adjust spacing as needed
              Expanded(
                child: TextField(
                  controller: search,
                  decoration: const InputDecoration(
                    hintText: 'Search "iPhone"',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.search, color: Colors.white),
                ), // Replace with logo
              ),
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              width: 100,
            ),
            _buildOption('Categories'),const Text('|',style: const TextStyle(color: Colors.white54,fontSize: 29),),
            _buildOption('Top Stores'),const Text('|',style: TextStyle(color: Colors.white54,fontSize: 29),),
            _buildOption('Best Offers'),const Text('|',style: TextStyle(color: Colors.white54,fontSize: 29),),
            _buildOption('Collections'),const Text('|',style: TextStyle(color: Colors.white54,fontSize: 29),),
            _buildOption('Share & Earn')
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
            
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 50,
          ),
          const Divider()
        ],
      ),
    ),
  );
}
