import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:screentasia/screentasia.dart';
import 'package:storynory/modules/home_screen/view/widgets/card_swiper.dart';
import 'package:storynory/modules/home_screen/view/widgets/movie_list.dart';
import 'package:storynory/modules/home_screen/view/widgets/movie_list_title.dart';
import 'package:storynory/modules/layout/controller/cubit.dart';
import 'package:storynory/modules/layout/controller/states.dart';

import '../../../../models/ads/banner_ad.dart';
import '../../../../resources/color_manager.dart';

class HomeStorysScreen extends StatelessWidget {
  const HomeStorysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StorieCubit, StorieStates>(
      listener: (BuildContext context, state) async {
        if (state is StorieGetSuccessState) {
          final InAppReview inAppReview = InAppReview.instance;
          if (await inAppReview.isAvailable()) {
            inAppReview.requestReview();
          }
          if (StorieCubit.get(context).favorites.isEmpty) {
            StorieCubit.get(context).getFavoriteStorie();
          }
        }
      },
      builder: (context, state) {
        var cubit = StorieCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.primary,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Storynory',
                    style: GoogleFonts.getFont(
                      'Merriweather Sans',
                      color: Colors.white,
                      fontSize: 50.sp,
                    ),
                  ),
                ),
                CardsSwiper(cubit: cubit),
                MovieListTitle(title: 'New Stories', cubit: cubit),
                Expanded(
                  child: MovieList(
                    itemCount: 5,
                    cubit: cubit,
                  ),
                ),
                const AdBannerModels()
              ],
            ),
          ),
        );
      },
    );
  }
}
