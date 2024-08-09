import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storynory/models/ads/banner_ad.dart';
import 'package:storynory/modules/layout/controller/cubit.dart';
import 'package:storynory/modules/layout/controller/states.dart';

import 'package:storynory/resources/color_manager.dart';

import '../../../../models/ads/view_ad.dart';
import '../../../../resources/components.dart';
import '../../../storie_layout/view/screens/storie_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StorieCubit()..getFavoriteStorie(),
      child: BlocConsumer<StorieCubit, StorieStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = StorieCubit.get(context);

          return Scaffold(
              backgroundColor: ColorManager.primary,
              appBar: AppBar(
                elevation: 0,
                title: const Text('Favorite'),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      itemCount: cubit.favorites.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              AdInterstitialView.loadinterstitalAd();
                              navigateTo(
                                  context,
                                  StorieScreen(
                                    title: cubit.favorites[index].title!,
                                    text: cubit.favorites[index].text!,
                                    image: cubit.favorites[index].image!,
                                    author: cubit.favorites[index].author!,
                                    dec: cubit.favorites[index].dec!,
                                    id: cubit.favorites[index].id!,
                                  ));
                            },
                            child: GridTile(
                              footer: GridTileBar(
                                backgroundColor: Colors.white60,
                                title: Text(cubit.favorites[index].title!,
                                    style: TextStyle(
                                        color: ColorManager.primary,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center),
                              ),
                              child: Hero(
                                tag: cubit.favorites[index].image!,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15)),
                                  child: FadeInImage(
                                      placeholder: const AssetImage(
                                          'assets/images/no_image.jpg'),
                                      image: NetworkImage(
                                          cubit.favorites[index].image!),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const AdBannerModels()
                ],
              ));
        },
      ),
    );
  }
}
