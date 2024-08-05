import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:storynory/modules/authentication/controller/cubit.dart';
import 'package:storynory/resources/color_manager.dart';
import 'package:storynory/resources/widgets/button_custom.dart';
import 'package:storynory/resources/widgets/input_text.dart';

class SignUpBuilder extends StatelessWidget {
  final AuthenticationCubit cubit;
  const SignUpBuilder({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.signupKey,
      child: AnimationConfiguration.staggeredList(
        position: cubit.position.index,
        duration: const Duration(milliseconds: 1500),
        child: SlideAnimation(
          horizontalOffset: 300,
          child: FadeInAnimation(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: ColorManager.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      InputText(
                        checkEmail: true,
                        type: TextInputType.name,
                        hintText: '',
                        validator: 'Enter your Name',
                        icon: Icons.person,
                        controller: cubit.nameController,
                        labelText: 'Name',
                      ),
                      InputText(
                        checkEmail: false,
                        type: TextInputType.emailAddress,
                        hintText: '',
                        validator: cubit.emailController.text.isEmpty
                            ? 'Enter your Email'
                            : 'Enter the email correctly',
                        icon: Icons.email,
                        controller: cubit.emailController,
                        labelText: 'Email',
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
                      ButtomCustom(
                        onPressed: () => cubit.validRegister(),
                        textStyle: TextStyle(color: ColorManager.white),
                        text: 'Sign Up',
                        color: ColorManager.amber,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
