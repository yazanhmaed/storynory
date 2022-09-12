import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:storynory/modules/favorite_screen/cubit/cubit.dart';

import 'package:storynory/resources/color_manager.dart';
import 'package:storynory/resources/string_manager.dart';
import 'package:storynory/resources/values_manager.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

import '../../resources/widgets/storie_widget.dart';

class StorieScreen extends StatelessWidget {
  const StorieScreen({
    Key? key,
    required this.title,
    required this.text,
    required this.author,
    required this.image,
    required this.dec,
    required this.id,
  }) : super(key: key);

  final String id;
  final String title;
  final String dec;
  final String text;
  final String author;
  final String image;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StorieCubit, StorieStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = StorieCubit.get(context);
        var cubit2 = FavoriteCubit.get(context);
        cubit2.boolFav(id: id);

        bool switchbool = cubit.switched;
        return Scaffold(
          backgroundColor: ColorManager.darksecondary,
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: AppPadding.p10),
                child: FlutterSwitch(
                  activeColor: ColorManager.darksecondary,
                  inactiveText: AppString.inactiveText,
                  inactiveIcon:
                      const FaIcon(Icons.translate, color: Colors.black),
                  activeText: AppString.activeText,
                  activeIcon: const FaIcon(
                    Icons.translate,
                    color: Colors.black,
                  ),
                  width: Appwidth.w100,
                  height: Appwidth.w40,
                  valueFontSize: AppSize.s10,
                  toggleSize: AppSize.s40,
                  value: cubit.switched,
                  borderRadius: AppSize.s30,
                  padding: AppPadding.p5,
                  showOnOff: true,
                  onToggle: (val) {
                    cubit.changecurrentSwitch(val);
                    if (val == false) {
                      cubit.empty();
                    }
                  },
                ),
              ),
              IconButton(
                  onPressed: () {
                    cubit2.boolfav == false
                        ? cubit2.favirote(
                            author: author,
                            dec: dec,
                            id: id,
                            image: image,
                            text: text,
                            title: title)
                        : cubit2.removeFavorite(id: id);
                  },
                  icon: cubit2.boolfav == true
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border))
            ],
            title: Text(title),
            leading: IconButton(
                onPressed: () {
                  cubit.empty();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
          body: StorieWidget(
              title: title,
              author: author,
              image: image,
              dec: dec,
              text: text,
              cubit: cubit,
              switchbool: switchbool),
        );
      },
    );
  }
}
