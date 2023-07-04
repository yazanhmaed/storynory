import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storynory/modules/favorite_screen/cubit/cubit.dart';
import 'package:storynory/modules/favorite_screen/cubit/states.dart';

import 'package:storynory/resources/color_manager.dart';

import '../../models/ads/view_ad.dart';
import '../../resources/components.dart';
import '../storie_layout/storie_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteCubit()..getFavoriteStorie(),
      child: BlocConsumer<FavoriteCubit, FavoriteStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = FavoriteCubit.get(context);
    
          return Scaffold(
              backgroundColor: ColorManager.primary,
              appBar: AppBar(
                elevation: 0,
                title: const Text('Favorite'),
              ),
              body: GridView.builder(
                itemCount: cubit.favSt.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                            title: cubit.favSt[index].title!,
                            text: cubit.favSt[index].text!,
                            image: cubit.favSt[index].image!,
                            author: cubit.favSt[index].author!,
                            dec: cubit.favSt[index].dec!,
                            id: cubit.favSt[index].id!,
                          ));
                      },
                      child: GridTile(
                        footer: GridTileBar(
                          backgroundColor: Colors.white60,
                          title: Text(cubit.favSt[index].title!,
                              style: TextStyle(
                                  color: ColorManager.primary,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ),
                        child: Hero(
                          tag: cubit.favSt[index].image!,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            child: FadeInImage(
                                placeholder: const AssetImage(
                                    'assets/images/no_image.jpg'),
                                image: NetworkImage(cubit.favSt[index].image!),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ));
        },
      ),
    );
  }
}
