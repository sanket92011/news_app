import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../key.dart';
import '../../widgets/detailed_instant_news_card.dart';
import '../../widgets/news_headlines.dart';

class UsNews extends StatefulWidget {
  const UsNews({
    super.key,
  });

  @override
  State<UsNews> createState() => _IndiaNewsState();
}

class _IndiaNewsState extends State<UsNews> {
  dynamic data;

  Future<void> fetchData() async {
    try {
      final result = await http.get(
        Uri.parse(
            "https://api.mediastack.com/v1/news?access_key=$ACCESS_KEY&countries=us"),
      );
      if (result.statusCode == 200) {
        data = jsonDecode(result.body);
        print("Biw");
        return data;
      } else {
        throw "Error";
      }
    } catch (e) {
      e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          const Text("Error occured");
        } else if (!snapshot.hasData) {
          return const Text("Data not found");
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            final author = data['data'][index]['author'] ?? "No name";
            final source = data['data'][index]['source'] ?? "No source";
            final category = data['data'][index]['category'] ?? "No category";
            final imageUrl = data['data'][index]['image'] ??
                "https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png";
            final imageTitle = data['data'][index]['title'] ?? "No Title";
            final description = data['data'][index]['description'];
            final url = data['data'][index]['url'];

            return NewsHeadlines(
              title: imageTitle,
              onClick: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailedInstantNewsCard(
                      title: imageTitle,
                      description: description,
                      imageUrl: imageUrl,
                      category: category,
                      source: source,
                      author: author,
                      url: url,
                    ),
                  ),
                );
              },
            );
          },
          itemCount: data['data'].length,
        );
      },
      future: fetchData(),
    );
  }
}
