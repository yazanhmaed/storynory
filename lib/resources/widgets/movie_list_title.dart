import 'package:flutter/material.dart';

import 'package:storynory/resources/color_manager.dart';

import '../../layout/cubit/cubit.dart';

class MovieListTitle extends StatelessWidget {
  final String title;
  final StorieCubit cubit;
  const MovieListTitle({
    Key? key,
    required this.title,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
                color: ColorManager.white,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => cubit.changecurrentIndex(1),
            child: Text(
              'See all',
              style: TextStyle(
                  color: ColorManager.secondary2,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
