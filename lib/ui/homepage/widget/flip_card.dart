import 'package:flutter/material.dart';

final List<Map<String, String>> productData = [
  {
    'brand': 'bigrock',
    'product': 'Retinol Body Lotion',
    'price': 'At ₹399',
    'discount': 'Flat 16.8%',
    'logo': 'https://via.placeholder.com/50', // Replace with actual logo URL
    'productImage':
        'assets/images/cream.jpg', // Replace with actual product image URL
  },
  {
    'brand': 'ajio',
    'product': 'Skincare Deal',
    'price': '₹577*',
    'discount': 'Flat 11.2%',
    'logo': 'https://via.placeholder.com/50', // Replace with actual logo URL
    'productImage':
        'assets/images/botique.jpg', // Replace with actual product image URL
  },
  {
    'brand': 'Flipkart',
    'product': 'Lip Balm Deal',
    'price': '₹237*',
    'discount': 'Upto 1.7%',
    'logo': 'https://via.placeholder.com/50', // Replace with actual logo URL
    'productImage':
        'assets/images/nevia.png', // Replace with actual product image URL
  },
  {
    'brand': 'Myntra',
    'product': 'Haircare Deal',
    'price': '₹112*',
    'discount': 'Upto 6.3%',
    'logo': 'https://via.placeholder.com/50', // Replace with actual logo URL
    'productImage':
        'assets/images/kaya.jpg', // Replace with actual product image URL
  },
  {
    'brand': 'swisse',
    'product': 'Eye Cream',
    'price': '₹221*',
    'discount': 'Flat 1.6%',
    'logo': 'https://via.placeholder.com/50', // Replace with actual logo URL
    'productImage':
        'assets/images/cafeeine.jpg', // Replace with actual product image URL
  },
];
Widget buildFrontCard(int index) {
  final product = productData[index];
  return Container(
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(15)),
    height: 380,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Center(
            child: Image.asset(
                product['productImage']
                    .toString(), // Replace with your image URL
                height: 100,
                fit: BoxFit.fill),
          ),
          // Logo and Title\
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(2),
              child: Center(
                child: Image.asset(
                    'assets/images/${product['brand']!.toLowerCase()}.png', // Replace with your image URL
                    height: 20,
                    fit: BoxFit.fill),
              ),
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 8),
              Text(
                product['product'].toString(),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
      
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.percent, color: Colors.red, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      product['discount'].toString(),
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Price Section
          Row(
            children: [
              Text(
                product['price'].toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                '₹650',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Footer Text
          Text(
            '*After Discount & Cashback',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
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
