import 'dart:async';
import 'package:couponic_website/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentIndex = 0;
  Timer? _autoSlideTimer;

  final List<Map<String, String>> offers = [
    {
      'imageUrl': 'https://via.placeholder.com/300x150.png?text=Offer+1',
      'title': 'Up to 50-90% Off',
      'subtitle': 'On 6000+ Brands',
      'cashback': 'Up to 10.1%',
    },
    {
      'imageUrl': 'https://via.placeholder.com/300x150.png?text=Offer+2',
      'title': 'Up to 25% Off',
      'subtitle': 'On Domestic Flights',
      'cashback': 'Flat ₹160 Cashback',
    },
    {
      'imageUrl': 'https://via.placeholder.com/300x150.png?text=Offer+3',
      'title': 'Exclusive Deals',
      'subtitle': 'Limited Time Offers',
      'cashback': 'Special Cashback!',
    },
    {
      'imageUrl': 'https://via.placeholder.com/300x150.png?text=Offer+4',
      'title': 'Mega Discounts',
      'subtitle': 'Hurry Now!',
      'cashback': 'Cashback Galore!',
    },
  ];

  final List<Map<String, dynamic>> steps = [
    {
      'icon': Icons.login_outlined,
      'title': 'Log In & Shop',
      'description': 'Click your favorite coupon & Shop',
    },
    {
      'icon': Icons.wallet,
      'title': 'Cashback Earned',
      'description': 'Cashback gets added to your CouponDunia wallet',
    },
    {
      'icon': Icons.currency_rupee,
      'title': 'Withdraw Cashback',
      'description': 'To your bank account, or as a voucher, recharge',
    },
  ];

  late AnimationController _controller;
  late Animation<double> _animation;
  bool isFrontVisible = true;

  final ScrollController _scrollController =
      ScrollController(); // For scroll control

  // Tracking the flip state for each card in the grid
  List<bool> flipStates = List.generate(6, (index) => true);
  int flippedIndex = -1;
  @override
  void initState() {
    super.initState();
    _startAutoSlide();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  void flipCard(int index) {
    setState(() {
      if (flippedIndex == index) {
        // If the tapped card is already flipped, reverse it
        flippedIndex = -1;
        _controller.reverse();
      } else {
        // Flip the new card and reset the previous one
        flippedIndex = index;
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (_currentIndex < offers.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _goToNextPage() {
    if (_currentIndex < offers.length - 1) {
      _currentIndex++;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 350,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // PageView for cards
                  PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemCount: offers.length,
                    itemBuilder: (context, index) {
                      return _buildOfferCard(offers[index]);
                    },
                  ),
                  // Left and Right Arrows
                  if (_currentIndex > 0)
                    Positioned(
                      left: 16,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.black),
                        onPressed: _goToPreviousPage,
                      ),
                    ),
                  if (_currentIndex < offers.length - 1)
                    Positioned(
                      right: 16,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios,
                            color: Colors.black),
                        onPressed: _goToNextPage,
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Three Steps To Save With CouponDunia",
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
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 32,
                                backgroundColor:
                                    Colors.greenAccent.withOpacity(0.2),
                                child: Icon(
                                  step['icon'],
                                  color: Colors.redAccent,
                                  size: 28,
                                ),
                              ),
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
                              const SizedBox(height: 16),
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
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            // Grid View
            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MouseRegion(
                      onEnter: (_) => flipCard(
                          index), // Trigger flip when cursor enters the card
                      onExit: (_) => flipCard(index),
                      child: GestureDetector(
                        onTap: () => flipCard(index), // Flip card on tap
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            final angle = _animation.value * 3.14159;
                            // π radians for a flip
                            return Transform(
                              transform: Matrix4.identity()
                                ..setEntry(
                                    3, 2, 0.001) // Perspective effect
                                ..rotateY(angle),
                              alignment: Alignment.center,
                              child: _animation.value < 0.5
                                  ? buildFrontCard()
                                  : Transform(
                                      transform: Matrix4.identity()
                                        ..rotateY(3.14159),
                                      alignment: Alignment.center,
                                      child: buildBackCard(),
                                    ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferCard(Map<String, String> offer) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.network(
              offer['imageUrl']!,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  offer['title']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                // Subtitle
                Text(
                  offer['subtitle']!,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                const SizedBox(height: 8),
                // Cashback Info
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    offer['cashback']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
}
