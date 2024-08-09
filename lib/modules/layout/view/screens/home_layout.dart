import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storynory/modules/layout/controller/cubit.dart';
import 'package:storynory/modules/layout/controller/states.dart';
import 'package:storynory/modules/search/view/screens/searchdata.dart';
import 'package:storynory/resources/color_manager.dart';

import 'package:storynory/resources/string_manager.dart';

import 'package:storynory/resources/components.dart';
import 'package:storynory/resources/widgets/bottom_appbar.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StorieCubit, StorieStates>(
      builder: (context, state) {
        var cubit = StorieCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.primary,
          body: SafeArea(child: cubit.screen(context)),
          bottomNavigationBar: const AppBottomBar(),

          // BottomNavigationBar(
          //   items: [
          //     BottomNavigationBarItem(
          //         icon: const Icon(Icons.home),
          //         label: 'Home',
          //         backgroundColor: ColorManager.primary),
          //     BottomNavigationBarItem(
          //         icon: const Icon(Icons.menu_book_outlined),
          //         label: AppString.storie,
          //         backgroundColor: ColorManager.primary),
          //     BottomNavigationBarItem(
          //         icon: const Icon(Icons.favorite),
          //         label: AppString.list1,
          //         backgroundColor: ColorManager.primary),
          //     BottomNavigationBarItem(
          //         icon: const Icon(Icons.search),
          //         label: 'Search',
          //         backgroundColor: ColorManager.primary),
          //     BottomNavigationBarItem(
          //         icon: const Icon(Icons.person),
          //         label: 'Profile',
          //         backgroundColor: ColorManager.primary),
          //   ],
          //   currentIndex: currentIndex,
          //   elevation: 10,
          //   type: BottomNavigationBarType.fixed,
          //   onTap: (index) {
          //     if (index == 3) {
          //       showSearch(context: context, delegate: SearchDataScreen());
          //     } else {
          //       cubit.changeCurrentIndex(index);
          //     }
          //   },
          // ),
        );
      },
    );
  }
}
