import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    super.key,
    required this.ratingCount,
  });
  final int ratingCount;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 20,
        width: 100,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (_, index) {
              return const Icon(
                Icons.star,
                color: Colors.yellow,
              );
            }),
      ),
    );
  }
}
