import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  final double rating;
  const Stars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
        rating: rating,
        direction: Axis.horizontal,
        itemSize: 25,
        itemCount: 5,
        unratedColor: Colors.black12,
        itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Color.fromARGB(255, 255, 196, 4),
            ));
  }
}
