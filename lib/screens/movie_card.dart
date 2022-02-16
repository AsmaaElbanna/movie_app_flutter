import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {

  final String imageURL;
  final String title;

  MovieCard(this.imageURL,this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(
          height: 400,width: 250,
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(fit: BoxFit.fill,
                image: NetworkImage(imageURL)),
            boxShadow: [
              BoxShadow(
                color: Colors.yellow.shade900,
                offset: Offset(
                  2.0,
                  2.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 1.0,
              ), //BoxShadow
            ],
          ),
        ),
          SizedBox(height: 20,),
          Text(title,style: TextStyle(fontFamily: 'Courgette',fontSize: 18),)
      ],),

    );
  }
}
