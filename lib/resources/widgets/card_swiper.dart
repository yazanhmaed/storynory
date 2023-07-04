
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:storynory/resources/components.dart';

import '../../layout/cubit/cubit.dart';
import '../../models/ads/view_ad.dart';
import '../../modules/storie_layout/storie_screen.dart';

class CardsSwiper extends StatelessWidget {
  final StorieCubit cubit;

  const CardsSwiper({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (cubit.storie.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.54,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

          cubit.stories.shuffle();
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: 4,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.78,
        itemHeight: size.height * 0.5,
        itemBuilder: (_, index) {
         
          final movie = cubit.stories[index];

          //  movie.heroId = 'swiper-${movie.id}';

          return GestureDetector(
            onTap: () {
              AdInterstitialView.loadinterstitalAd();
              navigateTo(
                context,
                StorieScreen(
                  title: movie.title!,
                  text: movie.text!,
                  image: movie.image!,
                  author: movie.author!,
                  dec: movie.dec!,
                  id: movie.id!,
                ));
                cubit.updateData(count: 1, uId: movie.id!);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  placeholder: const AssetImage('assets/images/no_image.jpg'),
                  image: NetworkImage(movie.image!),
                  fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
