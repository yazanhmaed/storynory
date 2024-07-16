import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:lottie/lottie.dart';

import 'package:loading_animations/loading_animations.dart';
import 'package:storynory/modules/layout/controller/cubit.dart';
import 'package:storynory/modules/layout/controller/states.dart';
import 'package:storynory/modules/layout/view/screens/home_layout.dart';
import 'package:storynory/modules/login_screen/view/screens/login_screen.dart';
import 'package:storynory/modules/no_internet/view/screens/no_internet.dart';
import 'package:storynory/modules/on_boarding/view/screens/on_boarding_screen.dart';
import 'package:storynory/resources/color_manager.dart';
import 'package:storynory/resources/components.dart';
import 'package:storynory/resources/styles_manager.dart';
import 'package:storynory/resources/values_manager.dart';
import 'package:storynory/shared/network/local/cache_helper.dart';

import '../../../../resources/string_manager.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({super.key });
 

  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  bool? onBoarding;
  bool? result;
  @override
    void  initState()   {
    super.initState();
    onBoarding = CacheHelper.getData(key: AppString.onBorderkey);
    token = CacheHelper.getData(key: AppString.tokenkey);
    lan = CacheHelper.getData(key: 'lang');
      WidgetsBinding.instance.addPostFrameCallback((_){
    _asyncMethod();
  });
  }
void _asyncMethod()async{
    result = await InternetConnectionChecker().hasConnection;

}
  @override
  Widget build(BuildContext context) {
    return BlocListener<StorieCubit, StorieStates>(
        listener: (context, state) async {
          if (state is StorieGetSuccessState) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              if (result == true) {
                if (onBoarding != null) {
                   if (token != null) {
                    return const HomeLayoutScreen();
                  } else {
                    return const LoginScreen();
                  }
                } else {
                  return const OnBoardingScreen();
                }
              } else {
                return const NoInternet();
              }
            }));
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
      );
  }
}
