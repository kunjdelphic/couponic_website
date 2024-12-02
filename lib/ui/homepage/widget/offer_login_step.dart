import 'package:flutter/material.dart';

final List<Map<String, dynamic>> steps = [
  {
    'icon': Icons.login_outlined,
    'title': 'Log In & Shop',
    'description': 'Click your favorite coupon & Shop',
  },
  {
    'icon': Icons.wallet,
    'title': 'Cashback Earned',
    'description': 'Cashback gets added to your\nCouponDunia wallet',
  },
  {
    'icon': Icons.currency_rupee,
    'title': 'Withdraw Cashback',
    'description': 'To your bank account, or as\na voucher, recharge',
  },
];

Widget loginOffer() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Three Steps To Save With Coupon",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: steps.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> step = entry.value;
          return Center(
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 100,
                  width: 350,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: const Color.fromARGB(255, 221, 219, 219))),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.greenAccent.withOpacity(0.2),
                          child: Icon(
                            step['icon'],
                            color: Colors.redAccent,
                            size: 25,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              step['title']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              step['description']!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.purple[100],
                radius: 12,
                child: Text(
                  "${index + 1}",
                  style: const TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
          );
        }).toList(),
      ),
    ],
  );
}
