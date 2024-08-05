import 'package:flutter/material.dart';
import 'package:storynory/modules/layout/controller/cubit.dart';

import 'movie_card_item.dart';

class MovieList extends StatelessWidget {
  final int itemCount;

  final dynamic model;
  final StorieCubit cubit;

  const MovieList({
    super.key,
    required this.itemCount,
    this.model,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: itemCount,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        int revIndex = cubit.stories.length - 1 - index;
        return MovieCardItem(
          itemIndex: index,
          itemCount: itemCount,
          needsSpacing: true,
          model: cubit.stories[revIndex],
          cubit: cubit,
        );
      },
    );
  }
}
