import 'package:card_swiper/card_swiper.dart';
import 'package:screentasia/screentasia.dart';
import 'package:storynory/modules/layout/controller/cubit.dart';
import 'package:storynory/resources/components.dart';

import '../../../../models/ads/view_ad.dart';
import '../../../storie_layout/view/screens/storie_screen.dart';

class CardsSwiper extends StatelessWidget {
  final StorieCubit cubit;

  const CardsSwiper({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (cubit.stories.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.54,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    cubit.stories.shuffle();
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.4,
      child: Swiper(
        itemCount: 4,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.78,
        itemHeight: size.height * 0.4.h,
        itemBuilder: (_, index) {
          final movie = cubit.stories[index];

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
