import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:storynory/modules/favorite_screen/cubit/cubit.dart';
import 'package:storynory/modules/login_screen/cubit/cubit.dart';
import 'package:storynory/resources/components.dart';

import 'package:storynory/resources/string_manager.dart';
import 'package:storynory/resources/theme_manager.dart';

import 'package:storynory/shared/bloc.dart';

import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';

import 'layout/home_layout.dart';
import 'modules/login_screen/login_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'modules/splash_screen/splashscreen.dart';
import 'shared/network/local/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  RequestConfiguration configuration = RequestConfiguration(
    testDeviceIds: <String>[
      'ca-app-pub-8887736687313297/2361886259',
      'c904ae40-ebc2-4dad-9805-c1f19a5e649a',
      '5AA745771F7E3307328336D67FD5E1E5',
      '622E5C582D3103E1CB310E5BFF1101E8'
    ],
  );
  MobileAds.instance.updateRequestConfiguration(configuration);
  await Firebase.initializeApp();
  await CacheHelper.init();
  Widget widget;

  bool? onBording = CacheHelper.getData(key: AppString.onBorderkey);
  token = CacheHelper.getData(key: AppString.tokenkey);
  lan = CacheHelper.getData(key: 'lang');

  if (onBording != null) {
    // ignore: unrelated_type_equality_checks
    if (token != null) {
      widget = const HomeLayoutScreen();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }
  Bloc.observer = MyBlocObserver();
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.startWidget}) : super(key: key);
  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StorieCubit()
            ..getStorie()
            ..getAdvanceStorie(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => FavoriteCubit()..getFavoriteStorie(),
        ),
      ],
      child: BlocConsumer<StorieCubit, StorieStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: getApplicationTheme(),
            home: SplashScreens(
              startWidget: startWidget,
            ),
          );
        },
      ),
    );
  }
}
