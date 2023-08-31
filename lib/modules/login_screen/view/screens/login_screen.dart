import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:screentasia/screentasia.dart';
import 'package:storynory/modules/layout/view/screens/home_layout.dart';
import 'package:storynory/modules/login_screen/controller/cubit.dart';
import 'package:storynory/modules/login_screen/controller/states.dart';
import 'package:storynory/modules/login_screen/view/widgets/login.dart';
import 'package:storynory/modules/login_screen/view/widgets/signup.dart';

import 'package:storynory/resources/color_manager.dart';
import 'package:storynory/resources/components.dart';

import 'package:storynory/shared/network/local/cache_helper.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../resources/string_manager.dart';

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
      if (state is AddUserErrorState) {
        if (state.error.toString() ==
            '[firebase_auth/weak-password] Password should be at least 6 characters') {
          Fluttertoast.showToast(
              msg: 'Password should be at least 6 characters',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: 'Email already exists',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
      if (state is UserErrorState) {
        Fluttertoast.showToast(
            msg: 'Verify your email and password',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      if (state is UserSuccessState) {
        token = state.uId;
        CacheHelper.seveData(key: 'token', value: state.uId).then((value) {
          print(state.uId);
          navigateAndFinish(context, const HomeLayoutScreen());
        });

        if (state is AddCreateUserSuccessState) {
          LoginCubit.get(context).positive = 0;
        }
      }
    }, builder: (context, state) {
      var cubit = LoginCubit.get(context);
      var key = GlobalKey<FormState>();
      return Scaffold(
        backgroundColor: ColorManager.primary,
        body: Form(
          key: key,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            child: Column(
              children: [
                Center(
                    child: Image.asset(
                  AppString.errorimage,
                  height: 300.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )),
                ToggleSwitch(
                  animate: true,
                  minHeight: 40,
                  minWidth: 190.0,
                  cornerRadius: 30.0,
                  activeBgColors: [
                    [ColorManager.amber],
                    [ColorManager.amber]
                  ],
                  borderColor: [
                    ColorManager.white.withOpacity(0.7),
                    ColorManager.white.withOpacity(0.7),
                  ],
                  borderWidth: 10,
                  activeFgColor: Colors.white,
                  inactiveBgColor: ColorManager.primary.withOpacity(0.7),
                  inactiveFgColor: Colors.white,
                  initialLabelIndex: cubit.positive,
                  totalSwitches: 2,
                  labels: const ['Login', 'Sign Up'],
                  radiusStyle: true,
                  onToggle: (index) {
                    cubit.changecurrentSwitch(posit: index!);
                  },
                ),
                cubit.positive == 0
                    ? SizedBox(
                        height: 500.h,
                        child: LoginBuilder(
                          positive: cubit.positive,
                          onTap: () => cubit.signInWithGoogle(),
                          obscureText: cubit.obscureText,
                          onPressedobscureText: () => cubit.changeobscureText(),
                          emailController: cubit.emailController,
                          passwordController: cubit.passwordController,
                          onPressed: () async {
                            if (key.currentState!.validate()) {
                              cubit.userLogin(
                                  email: cubit.emailController.text,
                                  password: cubit.passwordController.text);
                            }
                          },
                        ),
                      )
                    : SizedBox(
                        height: 600.h,
                        child: SignUpBuilder(
                            positive: cubit.positive,
                            obscureText: cubit.obscureText,
                            onPressedobscureText: () =>
                                cubit.changeobscureText(),
                            nameController: cubit.nameController,
                            emailController: cubit.emailController,
                            passwordController: cubit.passwordController,
                            onPressed: () {
                              if (key.currentState!.validate()) {
                                cubit.userRegister(
                                  name: cubit.nameController.text,
                                  email: cubit.emailController.text,
                                  password: cubit.passwordController.text,
                                  token: cubit.token,
                                );
                              }
                            }),
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
