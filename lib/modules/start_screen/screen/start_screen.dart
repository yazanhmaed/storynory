import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screentasia/screentasia.dart';
import 'package:storynory/modules/layout/controller/states.dart';
import 'package:storynory/modules/login_screen/controller/cubit.dart';
import 'package:storynory/modules/splash_screen/view/screens/splashscreen.dart';
import 'package:storynory/resources/theme_manager.dart';

import '../../layout/controller/cubit.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
  }

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
            child: const SplashScreens(),
          );
        },
      ),
    );
  }
}
