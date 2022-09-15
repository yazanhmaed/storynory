import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storynory/models/ads/view_ad.dart';
import 'package:storynory/resources/styles_manager.dart';

import '../../layout/cubit/cubit.dart';

import '../../modules/storie_layout/storie_screen.dart';

import '../color_manager.dart';
import '../string_manager.dart';
import '../values_manager.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required this.context,
    required this.model,
    required this.cubit,
  }) : super(key: key);

  final BuildContext context;
  final dynamic model;
  final StorieCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          //var i = 1;
          //print(model.id);
          AdInterstitialView.loadinterstitalAd();
          
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

          if (cubit.currentIndex == 1) {
            cubit.updateAdvanceData(count: 1, uId: model.id);
          }
          if (cubit.currentIndex == 0) {
            cubit.updateData(count: 1, uId: model.id);
          }
        },
        child: Container(
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
                          errorBuilder: (context, url, error) => const Image(
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
      ),
    );
  }
}
