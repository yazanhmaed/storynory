import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storynory/layout/home_layout.dart';
import 'package:storynory/modules/login_screen/cubit/cubit.dart';
import 'package:storynory/modules/login_screen/cubit/states.dart';

import 'package:storynory/resources/color_manager.dart';
import 'package:storynory/resources/components.dart';

import 'package:storynory/resources/values_manager.dart';
import 'package:storynory/shared/network/local/cache_helper.dart';

import '../../resources/string_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(listener: (context, state) {
      if (state is StorieLoginSuccessState) {
        if (state.tokenLogin.uid != null) {
          CacheHelper.seveData(
                  key: AppString.tokenkey, value: state.tokenLogin.uid)
              .then((value) {
            token = state.tokenLogin.uid!;
            print(lan);

            navigateAndFinish(context, const HomeLayoutScreen());
          }).catchError((onError) {
            print(onError);
          });
        }
      }
    }, builder: (context, state) {
      var cubit = LoginCubit.get(context);

      return Scaffold(
        backgroundColor: ColorManager.primary,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image.asset(AppString.errorimage)),
            const SizedBox(height: Appheight.h1),
            GestureDetector(
              onTap: () {
                lan = AppString.language;
                cubit.signInWithGoogle();
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: AppSize.s20),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(AppSize.s15)),
                padding: const EdgeInsets.symmetric(
                    horizontal: Appheight.h10, vertical: Appheight.h15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: Appheight.h30,
                      child: Image.asset(AppString.googleImages),
                    ),
                    Text(
                      AppString.googleUp,
                      style: TextStyle(
                        color: ColorManager.black,
                        fontSize: AppSize.s18,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
