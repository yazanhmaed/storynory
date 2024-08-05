import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screentasia/screentasia.dart';
import 'package:storynory/modules/authentication/controller/cubit.dart';
import 'package:storynory/modules/authentication/controller/states.dart';
import 'package:storynory/modules/authentication/view/widgets/login.dart';
import 'package:storynory/modules/authentication/view/widgets/signup.dart';
import 'package:storynory/resources/color_manager.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../resources/string_manager.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationStates>(
        listener: (context, state) {
      AuthenticationCubit.get(context)
          .authenticationStates(state: state, context: context);
    }, builder: (context, state) {
      var cubit = AuthenticationCubit.get(context);
      return Scaffold(
        backgroundColor: ColorManager.primary,
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          child: Column(
            children: [
              Center(
                  child: Image.asset(
                AppString.logoImage,
                height: 300.h,
                width: double.infinity,
                fit: BoxFit.cover,
              )),
              const SizedBox(
                height: 20,
              ),
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
                initialLabelIndex: cubit.position.index,
                totalSwitches: AuthenticationEnum.values.length,
                labels: AuthenticationEnum.nameList(),
                radiusStyle: true,
                onToggle: (index) {
                  cubit.changeCurrentSwitch(
                      switchPosition: AuthenticationEnum.values[index!]);
                },
              ),
              if (cubit.position == AuthenticationEnum.login) ...[
                SizedBox(
                  height: 500.h,
                  child: LoginBuilder(
                    cubit: cubit,
                  ),
                )
              ] else ...[
                SizedBox(
                  height: 600.h,
                  child: SignUpBuilder(
                    cubit: cubit,
                  ),
                )
              ],
            ],
          ),
        ),
      );
    });
  }
}
