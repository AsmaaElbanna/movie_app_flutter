import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_dio_poc/models/movie.dart';
import 'package:movie_app_dio_poc/screens/movie_card.dart';
import 'package:movie_app_dio_poc/screens/search_widget.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> movies = [];
  String query = '';
  Timer? debouncer;

  // Future<List<Movie>> loadData(String query) async {
  //   try {
  //     Response response = await Dio().get("https://api.jsonserve.com/4Qtg7q");
  //     final movies = response.data;
  //     return movies.map((json) => Movie.fromJson(json)).where((book) {
  //       final titleLower = book.originalTitle.toLowerCase();
  //       final searchLower = query.toLowerCase();
  //       return titleLower.contains(searchLower);
  //     }).toList();
  //   } catch (e) {
  //     throw Exception('Failed to load todos $e');
  //   }
  // }

  Future<List<Movie>> loadData(String query) async {
    final url = Uri.parse(
        'https://api.jsonserve.com/4Qtg7q');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List books = json.decode(response.body);

      return books.map((json) => Movie.fromJson(json)).where((book) {
        final titleLower = book.originalTitle.toLowerCase();
        final searchLower = query.toLowerCase();
        return titleLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

 // late Future<List<Movie>> futureMovies;
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final movies = await loadData(query);

    setState(() => this.movies = movies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Movies'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        buildSearch(),
          Expanded(
            child:  ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];

                return MovieCard(movie);
              },
            )
          )
        ],
      ),
    );
  }
  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'Title of movie',
    onChanged: searchBook,
  );

  Future searchBook(String query) async => debounce(() async {
    final movies = await loadData(query);

    if (!mounted) return;

    setState(() {
      this.query = query;
      this.movies = movies;
    });
  });
}

/*
FutureBuilder<List<Movie>>(
                future: movies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (_, index) {
                          final Movie movie = snapshot.data![index];
                          return MovieCard(snapshot.data![index]);
                        });
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepOrange,
                      strokeWidth: 5,
                    ),
                  );
                }),
 */
