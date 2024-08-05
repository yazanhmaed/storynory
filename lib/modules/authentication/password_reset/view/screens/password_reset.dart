import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screentasia/screentasia.dart';
import 'package:storynory/modules/authentication/controller/cubit.dart';
import 'package:storynory/modules/authentication/controller/states.dart';

import '../../../../../../resources/color_manager.dart';
import '../../../../../../resources/components.dart';
import '../../../../../../resources/widgets/button_custom.dart';
import '../../../../../../resources/widgets/input_text.dart';
import '../../../view/screens/authentication_screen.dart';

class PasswordResetScreen extends StatelessWidget {
  const PasswordResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationStates>(
      listener: (context, state) {
        if (state is PasswordResetSuccessState) {
           Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var key = GlobalKey<FormState>();
        var cubit = AuthenticationCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ColorManager.primary,
            leading: IconButton(
                onPressed: () {
                  navigateAndFinish(context, const AuthenticationScreen());
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                )),
          ),
          body: Form(
            key: key,
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              color: ColorManager.primary.withOpacity(.9),
              child: Center(
                child: Container(
                  height: MediaQuery.sizeOf(context).height / 2,
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 6,
                    color: ColorManager.primary,
                    borderRadius: BorderRadius.circular(15),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 100.h),
                            child: Text(
                              'Storynory',
                              style: TextStyle(
                                  fontSize: 40.sp,
                                  color: ColorManager.secondary),
                            ),
                          ),
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
                                    cubit.sendPasswordResetEmail(
                                        email: cubit.emailController.text);
                                  }
                                },
                              ),
                              const SizedBox(
                                width: 20,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
