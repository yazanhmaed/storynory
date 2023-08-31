import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storynory/modules/login_screen/controller/cubit.dart';
import 'package:storynory/modules/login_screen/controller/states.dart';

import '../../../../../resources/color_manager.dart';
import '../../../../../resources/components.dart';
import '../../../../../resources/widgets/button_custom.dart';
import '../../../../../resources/widgets/input_text.dart';
import '../../../login_screen/view/screens/login_screen.dart';

class PasswordResetScreen extends StatelessWidget {
  const PasswordResetScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is PasswordResetSuccessState) {
            navigateAndFinish(context, const LoginScreen());
          }
        },
        builder: (context, state) {
          var key = GlobalKey<FormState>();
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey.shade100,
              leading: IconButton(
                  onPressed: () {
                    navigateAndFinish(context, const LoginScreen());
                  },
                  icon: const Icon(
                    Icons.logout,
                  )),
            ),
            body: Form(
              key: key,
              child: Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Column(
                  children: [
                    Text(
                      'Storynory',
                      style:
                          TextStyle(fontSize: 40, color: ColorManager.error),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: ColorManager.primary.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          InputText(
                            checkEmail: false,
                            type: TextInputType.emailAddress,
                            hintText: '',
                            validator: cubit.emailController.text.isEmpty
                                ? 'Enter_your_Email'
                                : 'Enter_the_email_correctly',
                            icon: Icons.email,
                            controller: cubit.emailController,
                            labelText: 'Email',
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ButtomCustom(
                                text: 'Reset',
                                color: ColorManager.amber,
                                onPressed: () {
                                  if (key.currentState!.validate()) {
                                    cubit.getPassword(
                                        email: cubit.emailController.text);
                                  }
                                },
                              ),
                              const SizedBox(
                                width: 20,
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
