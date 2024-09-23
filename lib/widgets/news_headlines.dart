import 'package:flutter/material.dart';

class NewsHeadlines extends StatelessWidget {
  NewsHeadlines({super.key, required this.title, required this.onClick});

  final String title;
  VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 108,
      width: double.infinity,
      child: GestureDetector(
        onTap: onClick,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(title),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
