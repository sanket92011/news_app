import 'package:flutter/material.dart';

class InstantNewsCard extends StatelessWidget {
  const InstantNewsCard({
    super.key,
    this.imageUrl,
    this.imageTitle,
  });

  final imageUrl;
  final imageTitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      child: Stack(
        children: [
          Center(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Container(
              color: Colors.grey,
              child: Center(
                  child: Text(
                imageTitle,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )),
            ),
          )
        ],
      ),
    );
  }
}
