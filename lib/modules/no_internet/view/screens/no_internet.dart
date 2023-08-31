import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:storynory/modules/layout/view/screens/home_layout.dart';
import 'package:storynory/resources/color_manager.dart';
import 'package:storynory/resources/widgets/button_custom.dart';

import '../../../../resources/components.dart';
import '../../../../resources/string_manager.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../../login_screen/view/screens/login_screen.dart';
import '../../../on_boarding/view/screens/on_boarding_screen.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: ColorManager.primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FaIcon(
              FontAwesomeIcons.wifi,
              size: 130,
              color: Colors.white,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Check internet connection...!!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            ButtomCustom(
              text: 'Refersh',
              textStyle: TextStyle(fontSize: 20, color: ColorManager.primary),
              color: Colors.white,
              onPressed: () async {
                bool? onBording =
                    CacheHelper.getData(key: AppString.onBorderkey);
                token = CacheHelper.getData(key: AppString.tokenkey);
                bool result = await InternetConnectionChecker().hasConnection;
                if (result == true) {
                  if (onBording != null) {
                    // ignore: unrelated_type_equality_checks
                    if (token != null) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeLayoutScreen()));
                    } else {
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    }
                  } else {
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OnBoardingScreen()));
                  }
                } else {}
              },
            )
          ],
        ),
      ),
    );
  }
}
