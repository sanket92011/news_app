import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/key.dart';
import 'package:news_app/pages/tabs/india_news.dart';
import 'package:news_app/pages/tabs/us_news.dart';
import 'package:news_app/widgets/detailed_instant_news_card.dart';
import 'package:news_app/widgets/instant_news_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic data;
  PageController pageController = PageController();
  int currentPage = 0;
  late Timer timer;
  late var selectedCountry = 'in';
  final list = [
    'All',
    'health',
    'virus',
  ];
  late var selectedFilter = '';

  Future<void> fetchData() async {
    try {
      final result = await http.get(
        Uri.parse(
            "https://api.mediastack.com/v1/news?access_key=$ACCESS_KEY&countries=$selectedCountry"),
      );
      if (result.statusCode == 200) {
        data = jsonDecode(result.body);

        return data;
      } else {
        throw "error";
      }
    } catch (e) {
      e.toString();
    }
  }

  Future<void> categories() async {
    try {
      final result = await http.get(
        Uri.parse(
            "https://api.mediastack.com/v1/news?access_key=$ACCESS_KEY&countries=$selectedCountry&categories = $selectedFilter"),
      );
      if (result.statusCode == 200) {
        data = jsonDecode(result.body);
        return data;
      } else {
        throw "error";
      }
    } catch (e) {
      e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    selectedFilter = list[0];

    fetchData();

    timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (currentPage < (data['articles'].length - 1)) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Instant News"),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        body: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Error occurred!"),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text("No data Available"),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: PageView.builder(
                      controller: pageController,
                      itemBuilder: (context, index) {
                        final author =
                            data['data'][index]['author'] ?? "No name";
                        final source =
                            data['data'][index]['source'] ?? "No source";
                        final category =
                            data['data'][index]['category'] ?? "No category";
                        final imageUrl = data['data'][index]['image'] ??
                            "https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png";
                        final imageTitle =
                            data['data'][index]['title'] ?? "No Title";
                        final description = data['data'][index]['description'];
                        final url = data['data'][index]['url'];
                        return GestureDetector(
                          onTap: () {
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
                          child: InstantNewsCard(
                            imageUrl: imageUrl,
                            imageTitle: imageTitle,
                          ),
                        );
                      },
                      itemCount: 5,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "News ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const TabBar(
                    padding: EdgeInsets.only(top: 10),
                    tabs: [
                      Tab(text: "India"),
                      Tab(text: "US"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      IndiaNews(),
                      const UsNews(),
                    ]),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
