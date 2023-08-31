import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:storynory/modules/layout/view/screens/stream.dart';
import 'package:storynory/resources/color_manager.dart';
import 'package:storynory/resources/string_manager.dart';
import 'package:storynory/resources/styles_manager.dart';
import 'package:storynory/resources/values_manager.dart';

import '../../../../shared/network/local/cache_helper.dart';

import '../../../../resources/components.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      image: AppString.onBorderimages1,
      title: AppString.onBordertitle1,
      body: AppString.onBorderbody1,
    ),
    BoardingModel(
      image: AppString.onBorderimages2,
      title: AppString.onBordertitle2,
      body: AppString.onBorderbody2,
    ),
    BoardingModel(
      image: AppString.onBorderimages3,
      title: AppString.onBordertitle3,
      body: AppString.onBorderbody3,
    ),
    BoardingModel(
      image: AppString.onBorderimages4,
      title: AppString.onBordertitle4,
      body: AppString.onBorderbody4,
    ),
  ];
  void submit() {
    CacheHelper.seveData(key: AppString.onBorderkey, value: true).then((value) {
      if (value) {
        return navigateAndFinish(context, const StreamScreen());
      }
      // print(value);
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  bool isLast = false;
  var boardController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightPrimary,
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: Text(
                AppString.onBorderSKIP,
                style: getSemiBoldStyle(
                    color: ColorManager.secondary, fontSize: AppSize.s15),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p30),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: ColorManager.primary,
                    dotHeight: Appheight.h10,
                    expansionFactor: AppSize.s4,
                    dotWidth: Appwidth.w10,
                    spacing: AppSize.s5,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: ColorManager.primary,
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                          duration:
                              const Duration(milliseconds: AppDuration.s500),
                          curve: Curves.easeIn);
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: ColorManager.secondary,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Center(child: Image(image: AssetImage(model.image)))),
          const SizedBox(height: Appheight.h30),
          Text(
            model.title,
            style: const TextStyle(fontSize: AppSize.s24),
          ),
        ],
      );
}
