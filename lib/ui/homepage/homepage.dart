import 'dart:async';
import 'package:couponic_website/ui/homepage/widget/card.dart';
import 'package:couponic_website/ui/homepage/widget/dummy.dart';
import 'package:couponic_website/ui/homepage/widget/flip_card.dart';
import 'package:couponic_website/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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
  bool isFrontVisible = true;
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  late List<bool> _flippedStates;
  late  ScrollController _scrollController; // For scroll control
  int cardCount = 10;
  // Tracking the flip state for each card in the grid
  List<bool> flipStates = List.generate(6, (index) => true);
  int flippedIndex = -1;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _startAutoSlide();
    _flippedStates = List.generate(cardCount, (_) => false);
    _controllers = List.generate(
      cardCount,
      (_) => AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      ),
    );
    _animations = _controllers
        .map((controller) =>
            Tween<double>(begin: 0.0, end: 1.0).animate(controller))
        .toList();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _animations = _controllers
        .map((controller) => Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: controller,
                curve: Curves.easeInOut,
              ),
            ))
        .toList();
  }

  void flipCard(int index, bool isEntering) {
    setState(() {
      if (isEntering && !_flippedStates[index]) {
        _flippedStates[index] = true;
        _controllers[index].forward();
      } else if (!isEntering && _flippedStates[index]) {
        _flippedStates[index] = false;
        _controllers[index].reverse();
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

  void scrollBack() {
    _scrollController.animateTo(
      _scrollController.offset - 200, // Scroll back by 200 pixels
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void scrollForward() {
    _scrollController.animateTo(
      _scrollController.offset + 200, // Scroll forward by 200 pixels
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                        left: 18,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back_ios,
                                  color: Colors.black),
                              onPressed: _goToPreviousPage,
                            ),
                          ),
                        ),
                      ),
                    if (_currentIndex < offers.length - 1)
                      Positioned(
                        right: 16,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: IconButton(
                              icon: const Icon(Icons.arrow_forward_ios,
                                  color: Colors.black),
                              onPressed: _goToNextPage,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
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
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.grey)),
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                ),
              ),
              SizedBox(
                height: 300,
                child: Row(
                  children: [
                    // Backward Scroll Icon
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => scrollBack(),
                    ),
                    // Card List
                    Expanded(
                      child: GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          _scrollController.jumpTo(
                            _scrollController.offset - details.delta.dx,
                          );
                        },
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          controller: _scrollController,
                          itemCount: cardCount,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MouseRegion(
                                onEnter: (_) => flipCard(index, true),
                                onExit: (_) => flipCard(index, false),
                                child: AnimatedBuilder(
                                  animation: _animations[index],
                                  builder: (context, child) {
                                    final angle =
                                        _animations[index].value * 3.14159;
                                    return Transform(
                                      transform: Matrix4.identity()
                                        ..setEntry(3, 2, 0.001)
                                        ..rotateY(angle),
                                      alignment: Alignment.center,
                                      child: _animations[index].value < 0.5
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
                            );
                          },
                        ),
                      ),
                    ),
                    // Forward Scroll Icon
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: () => scrollForward(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 100.0),
                child: Row(
                  children: [
                    Text(
                      "Top Store",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 1000,
                height: 550,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // Number of cards in a row
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: 8, // Total cards
                    itemBuilder: (context, index) {
                      return HoverCard(
                        imageUrl: getImageUrl(index),
                        title: getTitle(index),
                        rewardText: getRewardText(index),
                      );
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 100.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Trending Categories",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                height: 400,
                child: Row(
                  children: [
                    // Categories Sidebar
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.red)),
                        child: ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                setState(() {
                                  selected = index;
                                });
                              },
                              // Replace with icons
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(categories[index]),
                              ),
                              selected: selected ==
                                  index, // Mark the first category as selected
                              selectedTileColor: Colors.red[50],
                              textColor: index == selected ? Colors.red : null,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    // Offers Section
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.red)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [const SizedBox(width: 20,),
                            // Offers Header
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Offers",
                                      style: TextStyle(fontSize: 18)),
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text("Show More"))
                                ],
                              ),
                            ),
                            // Offers Carousel
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: offers_card.length,
                                itemBuilder: (context, index) {
                                  final offer = offers_card[index];
                                  return Card(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: SizedBox(
                                      width: 200,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.network(offer['logo']!,
                                              height: 40),
                                          const SizedBox(height: 8),
                                          Text(
                                            offer['title']!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 8),
                                          if (offer['cashback']!.isNotEmpty)
                                            Text(
                                              offer['cashback']!,
                                              style: const TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 12),
                                            ),
                                          const SizedBox(height: 8),
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: const Text("Get Deal"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Stores Section
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Stores",
                                  style: TextStyle(fontSize: 18)),
                            ),
                            SizedBox(
                              height: 100,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: stores.length,
                                itemBuilder: (context, index) {
                                  final store = stores[index];
                                  return Card(
                                  
                                    child: SizedBox(
                                      width: 150,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.network(store['logo']!,
                                              height: 30),
                                          const SizedBox(height: 8),
                                          Text(
                                            store['offers']!,
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            store['cashback']!,
                                            style: const TextStyle(
                                                color: Colors.green,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              cashback(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOfferCard(Map<String, String> offer) {
    return Container(
      width: 300,
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

  Widget cashback(BuildContext context) {
    final stores = [
      {"name": "Shyaway", "cashback": "35%", "image": "assets/shyaway.png"},
      {
        "name": "Hostinger",
        "cashback": "41.3%",
        "image": "assets/hostinger.png"
      },
      {"name": "Swisse", "cashback": "21%", "image": "assets/swisse.png"},
      {
        "name": "Clove Oral Care",
        "cashback": "67.5%",
        "image": "assets/clove.png"
      },
      {"name": "Shyaway", "cashback": "35%", "image": "assets/shyaway.png"},
      {
        "name": "Hostinger",
        "cashback": "41.3%",
        "image": "assets/hostinger.png"
      },
      {"name": "Swisse", "cashback": "21%", "image": "assets/swisse.png"},
      {
        "name": "Clove Oral Care",
        "cashback": "67.5%",
        "image": "assets/clove.png"
      },
    ];

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
                itemCount: stores.length,
                itemBuilder: (context, index) {
                  final store = stores[index];
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
                            store["image"]!,
                            width: 100,
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            store["name"]!,
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
                                  "Flat ${store['cashback']} Cashback",
                                  style: TextStyle(
                                    fontSize: 12,
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
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward, color: Colors.black54),
                  onPressed: scrollForward,
                ),
              ),
              // Backward Scroll Button
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black54),
                    onPressed: scrollBack),
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
}
