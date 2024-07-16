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
import 'package:storynory/modules/start_screen/screen/start_screen.dart';
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
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  Bloc.observer = MyBlocObserver();
  runApp(const StartScreen());
}
