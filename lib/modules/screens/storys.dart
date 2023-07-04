import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:storynory/resources/color_manager.dart';

import '../../models/ads/banner_ad.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/ads/view_ad.dart';
import '../../resources/components.dart';
import '../storie_layout/storie_screen.dart';

class StorysScreen extends StatelessWidget {
  const StorysScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StorieCubit, StorieStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = StorieCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.primary,
          body: ConditionalBuilder(
            condition: cubit.storie.isNotEmpty,
            builder: (context) => Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.only(top: 20),
                    physics: const BouncingScrollPhysics(),
                    itemCount: cubit.storie.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      int revIndex = cubit.storie.length - 1 - index;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            AdInterstitialView.loadinterstitalAd();
                            navigateTo(
                                context,
                                StorieScreen(
                                  title: cubit.storie[revIndex].title!,
                                  text: cubit.storie[revIndex].text!,
                                  image: cubit.storie[revIndex].image!,
                                  author: cubit.storie[revIndex].author!,
                                  dec: cubit.storie[revIndex].dec!,
                                  id: cubit.storie[revIndex].id!,
                                ));
                            cubit.updateData(
                                count: 1, uId: cubit.storie[revIndex].id!);
                          },
                          child: GridTile(
                            footer: GridTileBar(
                              backgroundColor: Colors.white60,
                              title: Text(cubit.storie[revIndex].title!,
                                  style: TextStyle(
                                      color: ColorManager.primary,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                            ),
                            child: Hero(
                              tag: cubit.storie[revIndex].image!,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15)),
                                child: FadeInImage(
                                    placeholder: const AssetImage(
                                        'assets/images/no_image.jpg'),
                                    image: NetworkImage(
                                        cubit.storie[revIndex].image!),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const AdBannerModels(),
              ],
            ),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
