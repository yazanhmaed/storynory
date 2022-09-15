import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storynory/models/ads/banner_ad.dart';


import 'package:storynory/resources/widgets/cardview_widget.dart';

import '../../resources/color_manager.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';



class StoryScreen extends  StatelessWidget{
  const StoryScreen({Key? key}) : super(key: key);



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
              Expanded(
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      int revIndex = cubit.storie.length - 1 - index;
                      return CardWidget(
                          context: context,
                          model: cubit.storie[revIndex],
                          cubit: cubit);
                    },
                    separatorBuilder: (context, index) => const SizedBox(),
                    itemCount: cubit.storie.length),
              ),
              const AdBannerModels()
            ],
          ),
            // bottomNavigationBar: const AdBannerModels(),
        );
      },
    );
  }
}
