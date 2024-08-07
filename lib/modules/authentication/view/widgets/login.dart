import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:storynory/modules/authentication/controller/cubit.dart';
import 'package:storynory/modules/authentication/password_reset/view/screens/password_reset.dart';
import 'package:storynory/resources/color_manager.dart';
import 'package:storynory/resources/components.dart';
import 'package:storynory/resources/string_manager.dart';
import 'package:storynory/resources/styles_manager.dart';
import 'package:storynory/resources/widgets/button_custom.dart';
import 'package:storynory/resources/widgets/input_text.dart';
import 'package:text_divider/text_divider.dart';

class LoginBuilder extends StatelessWidget {
  final AuthenticationCubit cubit;
  const LoginBuilder({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.loginnKey,
      child: AnimationConfiguration.staggeredList(
        position: cubit.position.index,
        duration: const Duration(milliseconds: 1500),
        child: SlideAnimation(
          horizontalOffset: -300,
          child: FadeInAnimation(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: ColorManager.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      InputText(
                        type: TextInputType.emailAddress,
                        hintText: '',
                        validator: cubit.emailController.text.isEmpty
                            ? 'Enter your Email'
                            : 'Enter the email correctly',
                        icon: Icons.email,
                        controller: cubit.emailController,
                        labelText: 'Email',
                        checkEmail: false,
                      ),
                      InputText(
                        checkEmail: true,
                        type: TextInputType.visiblePassword,
                        hintText: '',
                        validator: 'Enter your Password',
                        icon: Icons.password,
                        controller: cubit.passwordController,
                        labelText: 'Password',
                        obscureText: cubit.obscureText,
                        suffixIcon: IconButton(
                            onPressed: () => cubit.changeobscureText(),
                            icon: cubit.obscureText == true
                                ? Icon(
                                    Icons.visibility,
                                    color: ColorManager.primary,
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    color: ColorManager.primary,
                                  )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Forgot password',
                                style: getBoldStyle(color: ColorManager.black),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () => navigateTo(
                                    context, const PasswordResetScreen()),
                                child: Text(
                                  'Click',
                                  style: getBoldStyle(
                                      color: Colors.amber, fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          ButtomCustom(
                            onPressed: () => cubit.validLogin(),
                            textStyle: TextStyle(color: ColorManager.white),
                            text: 'Login',
                            color: ColorManager.amber,
                          ),
                        ],
                      ),
                      TextDivider.horizontal(
                          color: ColorManager.amber.withOpacity(0.6),
                          text: const Text('or'),
                          thickness: 5),
                      const SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () => cubit.signInWithGoogle(),
                        child: Image.asset(
                          AppString.google,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
