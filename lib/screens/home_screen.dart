import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_dio_poc/models/movie.dart';
import 'package:movie_app_dio_poc/screens/movie_card.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<Movie> moviesList = [];
  // List<Movie> moviesDisplayList=[];

  Future<List<Movie>> loadData() async {
    try {
      Response response = await Dio().get("https://api.jsonserve.com/4Qtg7q");
      final movies = response.data;
      return movies.map<Movie>((json) => Movie.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load todos $e');
    }
  }

  late Future<List<Movie>> futureMovies;
  @override
  void initState() {
    super.initState();
    futureMovies = loadData();
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
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(hintText: 'search...'),
              onChanged: (text) {
                text=text.toLowerCase();
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Movie>>(
                future: futureMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(itemCount: snapshot.data!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (_, index) {
                          final Movie movie = snapshot.data![index];
                          return MovieCard(
                              movie.posterPath, movie.originalTitle);
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
          )
        ],
      ),
    );
  }
}

/*
FutureBuilder<List<Movie>>(
          future: futureMovies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (_, index) {
                    final Movie movie = snapshot.data![index];
                    return MovieCard(movie.posterPath, movie.originalTitle);
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
          })
 */
