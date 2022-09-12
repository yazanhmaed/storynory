import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storynory/modules/favorite_screen/cubit/cubit.dart';

import 'package:storynory/resources/styles_manager.dart';


import '../../modules/storie_layout/storie_screen.dart';
import '../../resources/color_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/values_manager.dart';

class CardWidget2 extends StatelessWidget {
  const CardWidget2({
    Key? key,
    required this.context,
    required this.model,
    required this.cubit,
  }) : super(key: key);

  final BuildContext context;
  final dynamic model;
  final FavoriteCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          //var i = 1;
          //print(model.id);

          Navigator.push(
            context,
            PageTransition(
              duration: const Duration(milliseconds: AppDuration.s800),
              curve: Curves.linear,
              type: PageTransitionType.leftToRightWithFade,
              child: StorieScreen(
                title: model.title!,
                text: model.text!,
                image: model.image!,
                author: model.author!,
                dec: model.dec!,
                id: model.id!,
              ),
            ),
          );

          // if (cubit.currentIndex == 1) {
          //   cubit.updateAdvanceData(count: 1, uId: model.id);
          // }
          // if (cubit.currentIndex == 0) {
          //   cubit.updateData(count: 1, uId: model.id);
          // }
        },
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Container(
              color: ColorManager.secondary,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: AlignmentDirectional.topCenter,
                          children: [
                            Image(
                              image: NetworkImage('${model.image}'),
                              height: Appheight.h200,
                              width: Appwidth.w200,
                              fit: BoxFit.fill,
                              errorBuilder: (context, url, error) =>
                                  const Image(
                                image: AssetImage(AppString.errorimage),
                                height: Appheight.h200,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Text(
                              AppString.storynory,
                              style: TextStyle(color: ColorManager.secondary),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: AppPadding.p10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model.title!,
                                style: getBoldStyle(
                                    color: ColorManager.black,
                                    fontSize: AppSize.s18),
                              ),
                              const SizedBox(height: Appheight.h5),
                              Text(
                                model.author!,
                                style: getLightStyle(
                                    color: ColorManager.grey,
                                    fontSize: AppSize.s15),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.all(AppMargin.m8),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red),
                child: IconButton(
                    onPressed: () {
                     cubit.removeFavorite(id: model.id);
                   
                    },
                    icon: const Icon(
                      Icons.delete,
                    )))
          ],
        ),
      ),
    );
  }
}
