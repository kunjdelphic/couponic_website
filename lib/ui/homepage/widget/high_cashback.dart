import 'package:couponic_website/ui/homepage/widget/dummy.dart';
import 'package:flutter/material.dart';

ScrollController _scrollController = ScrollController();
void scrollForward() {
  if (_scrollController.hasClients) {
    _scrollController.animateTo(
      _scrollController.offset + 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

// Function to scroll backward
void scrollBack() {
  if (_scrollController.hasClients) {
    _scrollController.animateTo(
      _scrollController.offset - 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

// Main cashback widget
Widget cashback(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          "High Cashback Stores",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        height: 200,
        child: Stack(
          children: [
            ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                final store = getTitle(index);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                           getImageUrl(getTitle(index).toLowerCase()),
                          width: 100,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 10),
                        Text(
                         store,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.local_offer,
                                  size: 14, color: Colors.green),
                              const SizedBox(width: 4),
                              Text(
                                "Flat ${getRewardText(index)}",
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.green.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            // Forward Scroll Button
             Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.white,),
       
                child: const Center(
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.black54),
                    onPressed: scrollForward,
                  ),
                ),
              ),
            ),
            // Backward Scroll Button
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color:Colors.white, ),
                child: const Center(
                  child: IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.black54),
                      onPressed: scrollBack),
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextButton(
          onPressed: () {
            // Handle "Show More" action
          },
          child: const Text(
            "Show More",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ),
    ],
  );
}
