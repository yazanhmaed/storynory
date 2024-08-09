import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screentasia/screentasia.dart';
import 'package:storynory/modules/layout/controller/cubit.dart';
import 'package:storynory/modules/layout/controller/states.dart';
import 'package:storynory/resources/color_manager.dart';
import 'package:storynory/resources/components.dart';
import 'package:storynory/resources/string_manager.dart';
import 'package:storynory/resources/widgets/bottom_appbar_item.dart';

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StorieCubit, StorieStates>(
      builder: (context, state) {
        StorieCubit cubit = StorieCubit.get(context);
        return BottomAppBar(
          elevation: 20,
          height: 75.h,
          color: ColorManager.primary,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              BottomBarItem(
                title: 'Home',
                icon: Icons.home,
                colorCondition: currentIndex == 0,
                onPressed: () => cubit.changeCurrentIndex(0),
              ),
              BottomBarItem(
                title: AppString.storie,
                icon: Icons.menu_book_outlined,
                colorCondition: currentIndex == 1,
                onPressed: () => cubit.changeCurrentIndex(1),
              ),
              BottomBarItem(
                title: AppString.list1,
                icon: Icons.favorite,
                colorCondition: currentIndex == 2,
                onPressed: () => cubit.changeCurrentIndex(2),
              ),
              BottomBarItem(
                title: 'Search',
                icon: Icons.search,
                colorCondition: currentIndex == 3,
                onPressed: () => cubit.changeCurrentIndex(3),
              ),
              BottomBarItem(
                title: 'Profile',
                icon: Icons.person,
                colorCondition: currentIndex == 4,
                onPressed: () => cubit.changeCurrentIndex(4),
              ),
            ],
          ),
        );
      },
    );
  }
}
