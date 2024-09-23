import 'package:flutter/material.dart';
import 'package:news_app/pages/web_view.dart';

class DetailedInstantNewsCard extends StatelessWidget {
  const DetailedInstantNewsCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.category,
    required this.source,
    required this.author,
    required this.url,
  });

  final String imageUrl;
  final String title;
  final String description;
  final String category;
  final String source;
  final String author;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$category category ".toUpperCase()),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Image.network(imageUrl),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "Author : $author",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 50),
              Center(
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: Image.asset("assets/gif/down.gif"),
              ),
              FilledButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.grey),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyWebView(
                          url: url,
                        ),
                      ));
                },
                child: const Text(
                  "Read More",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
