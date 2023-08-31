
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lottie/lottie.dart';

import 'package:loading_animations/loading_animations.dart';
import 'package:storynory/modules/layout/controller/cubit.dart';
import 'package:storynory/modules/layout/controller/states.dart';
import 'package:storynory/resources/color_manager.dart';
import 'package:storynory/resources/styles_manager.dart';
import 'package:storynory/resources/values_manager.dart';

import '../../../../resources/string_manager.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({Key? key, required this.startWidget}) : super(key: key);
  final Widget startWidget;

  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StorieCubit()..getStorie(),
      child: BlocListener<StorieCubit, StorieStates>(
        listener: (context, state) {
          if (state is StorieGetSuccessState) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => widget.startWidget));
          }
         
        },
        child: Scaffold(
          backgroundColor: ColorManager.primary,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Lottie.asset(AppString.splashScreensimages)),
              const SizedBox(height: Appheight.h1),
              Text(AppString.storynory,
                  style: getBoldStyle(
                      color: ColorManager.white, fontSize: AppSize.s40)),
              const SizedBox(height: Appheight.h40),
              Tab(
                child: LoadingBumpingLine.circle(
                  size: AppSize.s40,
                  backgroundColor: ColorManager.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
