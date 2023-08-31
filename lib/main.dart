import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:screentasia/screentasia.dart';
import 'package:storynory/modules/layout/controller/cubit.dart';
import 'package:storynory/modules/layout/controller/states.dart';
import 'package:storynory/modules/layout/view/screens/home_layout.dart';
import 'package:storynory/modules/login_screen/controller/cubit.dart';
import 'package:storynory/modules/no_internet/view/screens/no_internet.dart';
import 'package:storynory/resources/components.dart';

import 'package:storynory/resources/string_manager.dart';
import 'package:storynory/resources/theme_manager.dart';

import 'package:storynory/shared/bloc.dart';


import 'modules/login_screen/view/screens/login_screen.dart';
import 'modules/on_boarding/view/screens/on_boarding_screen.dart';
import 'modules/splash_screen/view/screens/splashscreen.dart';
import 'shared/network/local/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Widget widget;

  bool? onBording = CacheHelper.getData(key: AppString.onBorderkey);
  token = CacheHelper.getData(key: AppString.tokenkey);
  lan = CacheHelper.getData(key: 'lang');
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  bool result = await InternetConnectionChecker().hasConnection;
  if (result == true) {
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
  } else {
    widget = const NoInternet();
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
          create: (context) => LoginCubit(),
        ),
        BlocProvider(create: (context) => StorieCubit()..getStorie()),
      ],
      child: BlocConsumer<StorieCubit, StorieStates>(
        listener: (context, state) {},
        builder: (context, state) {
     
          return ScreentasiaInit(
            adaptiveFrom: AdaptiveFrom.mobile,
            adaptivePercentage: const AdaptivePercentage(
                mobile: 100, tablet: 100, desktop: 100),
            builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: getApplicationTheme(),
                home: child,
              );
            },
            child: SplashScreens(
              startWidget: startWidget,
            ),
          );
        },
      ),
    );
  }
}
