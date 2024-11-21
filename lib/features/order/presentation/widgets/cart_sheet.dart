import 'package:flutter/material.dart';

class CartSheet extends StatefulWidget {
  const CartSheet({super.key});

  @override
  State<CartSheet> createState() => _CartSheetState();
}

class _CartSheetState extends State<CartSheet> {
  final DraggableScrollableController _controller =
      DraggableScrollableController();

  // Snapping positions: 5%, 40%, and 100% height
  final double snapPositionBottom = 0.15; // Minimized
  final double snapPositionHalf = 0.4; // Half-expanded
  final double snapPositionFull = 1.0; // Fully expanded

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _controller,
      initialChildSize: snapPositionBottom,
      minChildSize: snapPositionBottom,
      maxChildSize: snapPositionFull,
      snap: true, // Enable snapping
      snapSizes: [
        snapPositionBottom,
        snapPositionHalf,
        snapPositionFull
      ], // Define snap positions
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ListView(
            controller: scrollController,
            children: [
              SizedBox(
                height: 20,
                child: Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              // Your additional content here
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Drag me up or down!',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const ListTile(title: Text('Item 1')),
              const ListTile(title: Text('Item 2')),
              const ListTile(title: Text('Item 3')),
              const ListTile(title: Text('Item 4')),
            ],
          ),
        );
      },
    );
  }
}
