import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app_dio_poc/models/movie.dart';

class MoviesDetailsScreen extends StatelessWidget {
  final Movie movie;
  MoviesDetailsScreen(this.movie);

  // String dateConvert(String date){
  //   final DateTime now = DateTime.now();
  //   final DateFormat formatter = DateFormat('yyyy-MM-dd');
  //   final String formatted = formatter.format(now);
  //   return formatted;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Center(
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.contain,
                  width: 300,
                  height: 400,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RatingBar.builder(
                minRating: 1,
                maxRating: 5,
                initialRating: double.parse(movie.voteAverage) - 5,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 30,
                itemBuilder: (_, context) {
                  return const Icon(
                    Icons.star_rate,
                    color: Colors.red,
                  );
                },
                onRatingUpdate: (rating) {}),
            SizedBox(
              height: 20,
            ),
            Text(movie.releaseDate),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: Text(
                  movie.overView,
                  style: TextStyle(fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
