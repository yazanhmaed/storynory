import 'package:flutter/material.dart';

import '../../layout/cubit/cubit.dart';
import 'movie_card_item.dart';

class MovieList extends StatelessWidget {
  final int itemCount;

  final dynamic model;
  final StorieCubit cubit;

  const MovieList({
    Key? key,
    required this.itemCount,
    this.model,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: itemCount,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
         int revIndex = cubit.storie.length - 1 - index;
        return MovieCardItem(
          itemIndex: index,
          itemCount: itemCount,
          needsSpacing: true,
          model: cubit.storie[revIndex],
          cubit: cubit,);
      },
    );
  }
}
