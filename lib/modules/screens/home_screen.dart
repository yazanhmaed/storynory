import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screentasia/screentasia.dart';
import 'package:storynory/resources/widgets/card_swiper.dart';
import 'package:storynory/resources/widgets/movie_list.dart';
import 'package:storynory/resources/widgets/movie_list_title.dart';

import '../../models/ads/banner_ad.dart';
import '../../resources/color_manager.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

class HomeStorysScreen extends StatelessWidget {
  const HomeStorysScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StorieCubit, StorieStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = StorieCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.primary,
          body: Column(
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
        );
      },
    );
  }
}
