import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:screentasia/screentasia.dart';
import 'package:storynory/firebase_options.dart';
import 'package:storynory/modules/start_screen/screen/start_screen.dart';
import 'package:storynory/shared/bloc.dart';

import 'shared/network/local/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  Bloc.observer = MyBlocObserver();
  runApp(const StartScreen());
}
