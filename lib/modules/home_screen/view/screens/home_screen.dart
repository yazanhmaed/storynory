import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocBuilder<StorieCubit, StorieStates>(
      builder: (context, state) {
        var cubit = StorieCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.primary,
          body: SafeArea(
            child: Column(
              children: [
                Text(
                  'Storynory',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.sp),
                ),
                SizedBox(
                  height: 10.h,
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
