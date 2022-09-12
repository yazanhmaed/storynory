import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storynory/modules/favorite_screen/cardview_widget.dart';
import 'package:storynory/modules/favorite_screen/cubit/cubit.dart';
import 'package:storynory/modules/favorite_screen/cubit/states.dart';

import 'package:storynory/resources/color_manager.dart';


import '../../resources/string_manager.dart';


class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteCubit, FavoriteStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = FavoriteCubit.get(context);
        print(cubit.favSt);
        return Scaffold(
          backgroundColor: ColorManager.darksecondary,
          appBar: AppBar(
            title: const Text(AppString.storynory),
          ),
          body: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => CardWidget2(
                  context: context, model: cubit.favSt[index], cubit: cubit),
              separatorBuilder: (context, index) => const SizedBox(),
              itemCount: cubit.favSt.length),
        );
      },
    );
  }
}
