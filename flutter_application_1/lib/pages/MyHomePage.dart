import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/Components/film.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  String defaultWord = "Spider";
  bool typing = false;

  List<Film> favList = [];
  List<Film> list = [];

  late Future<Results> futureResults;

  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    futureResults = fetchResults(defaultWord);
    _controller = TextEditingController();
  }

  void _onItemTapped(int index) {
    setState(() {
      favSave();
      _selectedIndex = index;
    });
  }

  void favSave() {
    if (futureResults != null) {
      for (int i = 0; i < list.length; i++) {
        if (list[i].fav) {
          if (favList.where((it) => it.filmJSON == list[i].filmJSON).isEmpty) {
            favList.add(list[i]);
          }
        }
      }
    }
  }

  void favVerif() {
    for (int i = favList.length; i > 0; i--) {
      if (favList[i - 1].fav == false) {
        favList.removeAt(i - 1);
      }
    }

    for (int i = 0; i < favList.length; i++) {
      var e = list.where((element) => element.filmJSON == favList[i].filmJSON);
      if (e.isNotEmpty)
        list
            .firstWhere((element) => element.filmJSON == favList[i].filmJSON)
            .fav = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
              title: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Movie",
                ),
                onSubmitted: (String value) {
                  setState(() {
                    favSave();
                    futureResults = fetchResults(value);
                  });
                },
              ),
              leading: IconButton(
                alignment: Alignment.centerRight,
                icon: const Icon(Icons.search),
                onPressed: () {
                  setState(() {});
                },
              ),
            )
          : AppBar(
              title: Text("Favorite"),
            ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: _selectedIndex == 1
                ? ListView(children: favList)
                : FutureBuilder<Results>(
                    future: futureResults,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        list = snapshot.data!.results
                            .map<Film>((f) => Film(f))
                            .toList();

                        favVerif();
                        return list.length > 1
                            ? ListView(children: list)
                            : Text("No data");
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

Future<Results> fetchResults(String query) async {
  final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/search/movie?api_key=3b8fad27e84f184741ac6e70dc8de7ed&language=fr&query=' +
          query));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Results.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load films');
  }
}

class FilmJSON {
  FilmJSON(
    this.title,
    this.date,
    this.description,
    this.image,
  );
  // nullable - assuming the review field is optional
  final String? title;
  final String? date;
  final String? description;
  final String? image;

  factory FilmJSON.fromJson(Map<String, dynamic> data) {
    final titleJ = data['title'] as String?;
    final dateJ = data['release_date'] as String?;
    final descriptionJ = data['overview'] as String?;
    final imageJ = data['poster_path'] as String?;
    return FilmJSON(titleJ, dateJ, descriptionJ, imageJ);
  }
}

class Results {
  Results({
    required this.results,
  });
  final List<FilmJSON> results;

  factory Results.fromJson(Map<String, dynamic> data) {
    final resultsData = data['results'] as List<dynamic>?;
    // if the reviews are not missing
    final results = resultsData != null
        // map each review to a Review object
        ? resultsData
            .map((resultsData) => FilmJSON.fromJson(resultsData))
            // map() returns an Iterable so we convert it to a List
            .toList()
        // use an empty list as fallback value
        : <FilmJSON>[];
    // return result passing all the arguments
    return Results(
      results: results,
    );
  }
}
