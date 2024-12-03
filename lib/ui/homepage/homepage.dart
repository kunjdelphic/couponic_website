import 'dart:async';
import 'package:couponic_website/ui/homepage/widget/card.dart';
import 'package:couponic_website/ui/homepage/widget/corousel_slider.dart';
import 'package:couponic_website/ui/homepage/widget/dummy.dart';
import 'package:couponic_website/ui/homepage/widget/flip_card.dart';
import 'package:couponic_website/ui/homepage/widget/high_cashback.dart';
import 'package:couponic_website/ui/homepage/widget/offer_login_step.dart';
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

  late AnimationController _controller;
  bool isFrontVisible = true;
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  late List<bool> _flippedStates;
  late ScrollController _scrollController; // For scroll control
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

  bool isHovered = false;

  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50),
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
                        return buildOfferCard(index);
                      },
                    ),
                    // Left and Right Arrows
                    if (_currentIndex > 0)
                      Positioned(
                        left: 38,
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
                height: 20,
              ),
              loginOffer(),
              const SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 178, 206, 230),
                    borderRadius: BorderRadius.circular(20)),
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Get Winter Ready',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
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
                                                _animations[index].value *
                                                    3.14159;
                                            return Transform(
                                              transform: Matrix4.identity()
                                                ..setEntry(3, 2, 0.001)
                                                ..rotateY(angle),
                                              alignment: Alignment.center,
                                              child: _animations[index].value <
                                                      0.5
                                                  ? buildFrontCard()
                                                  : Transform(
                                                      transform:
                                                          Matrix4.identity()
                                                            ..rotateY(3.14159),
                                                      alignment:
                                                          Alignment.center,
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
                    ],
                  ),
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
              Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.blue.withOpacity(0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            isHovered = true;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            isHovered = false;
                          });
                        },
                        child: AnimatedContainer(
                          width: 240,
                          height: 350,
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isHovered ? Colors.blue[50] : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: isHovered
                                ? [
                                    BoxShadow(
                                        color: Colors.blue.withOpacity(0.5),
                                        blurRadius: 10)
                                  ]
                                : [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 5)
                                  ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                getImageUrl(getTitle(0).toLowerCase()),
                                height: 100,
                                width: 120,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                getTitle(0),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              if (isHovered)
                                Text(
                                  getRewardText(0),
                                  style: const TextStyle(
                                      color: Colors.green, fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 900,
                        height: 610,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5, // Number of cards in a row
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: 8, // Total cards
                            itemBuilder: (context, index) {
                              return HoverCard(
                                imageUrl:
                                    getImageUrl(getTitle(index).toLowerCase()),
                                title: getTitle(index),
                                rewardText: getRewardText(index),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
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
                height: 20,
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
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
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

}
