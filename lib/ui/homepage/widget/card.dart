import 'package:flutter/material.dart';

class HoverCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String rewardText;

  const HoverCard({
    required this.imageUrl,
    required this.title,
    required this.rewardText,
    super.key,
  });

  @override
  _HoverCardState createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
        width: 100,
        height: 100,
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isHovered ? Colors.blue[50] : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isHovered
              ? [BoxShadow(color: Colors.blue.withOpacity(0.5), blurRadius: 10)]
              : [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              widget.imageUrl,
              height: 40,
              width: 90,
            ),
            const SizedBox(height: 5),
            Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            if (isHovered)
              Text(
                widget.rewardText,
                style: const TextStyle(color: Colors.green, fontSize: 14),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
