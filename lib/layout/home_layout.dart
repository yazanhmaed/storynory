import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storynory/modules/favorite_screen/favorite_screen.dart';

import 'package:storynory/modules/setting_screen/setting_screen.dart';
import 'package:storynory/resources/components.dart';
import 'package:storynory/resources/string_manager.dart';

import '../modules/search/searchdata.dart';
import '../resources/color_manager.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StorieCubit, StorieStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = StorieCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.primary,
          appBar: AppBar(
            title: const Text(AppString.storynory),
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: SearchDataScreen());
                  },
                  icon: const Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    navigateTo(context, const FavoriteScreen());
                  },
                  icon: const Icon(Icons.favorite)),
              IconButton(
                  onPressed: () {
                    navigateTo(context, const SettingScreen());
                  },
                  icon: const Icon(Icons.settings)),
            ],
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.book), label: AppString.storie),
              BottomNavigationBarItem(
                  icon: Icon(Icons.book), label: AppString.advanceStorie),
            ],
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changecurrentIndex(index);
            },
          ),
        );
      },
    );
  }
}
