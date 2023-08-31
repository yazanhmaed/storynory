import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storynory/modules/layout/controller/cubit.dart';
import 'package:storynory/modules/layout/controller/states.dart';
import 'package:storynory/modules/search/view/screens/searchdata.dart';
import 'package:storynory/resources/color_manager.dart';

import 'package:storynory/resources/string_manager.dart';


import 'package:storynory/resources/components.dart';


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
          body: cubit.screen[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: ColorManager.primary),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.menu_book_outlined),
                  label: AppString.storie,
                  backgroundColor: ColorManager.primary),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.favorite),
                  label: AppString.list1,
                  backgroundColor: ColorManager.primary),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.search),
                  label: 'Search',
                  backgroundColor: ColorManager.primary),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.person),
                  label: 'Profile',
                  backgroundColor: ColorManager.primary),
            ],
            currentIndex: currentIndex,
            onTap: (index) {
              if (index == 3) {
                showSearch(context: context, delegate: SearchDataScreen());
              } else {
                cubit.changecurrentIndex(index);
              }
            },
          ),
        );
      },
    );
  }
}
