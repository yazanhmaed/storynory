import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:storynory/resources/color_manager.dart';
import 'package:storynory/resources/string_manager.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/network/local/cache_helper.dart';
import '../components.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StorieCubit, StorieStates>(
      listener: (context, state) {
        if (state is StorieLangSuccessState) {
          if (state.langModel.lang != null) {
            CacheHelper.seveData(key: 'lang', value: state.langModel.lang)
                .then((value) {
              print(state.langModel.lang);
              lan = state.langModel.lang;
            }).catchError((onError) {
              print(onError);
            });
          }
        }
      },
      builder: (context, state) {
        var cubit = StorieCubit.get(context);
        return SelectFormField(
          type: SelectFormFieldType.dropdown,
          initialValue: lan,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorManager.white)),
            icon: FaIcon(
              Icons.translate,
              color: ColorManager.white,
            ),
            labelText: AppString.labelText,
            labelStyle: TextStyle(color: ColorManager.white),
          ),
          style: TextStyle(
              color: ColorManager.white,
              fontWeight: FontWeight.bold,
              fontSize: 18),
          items: cubit.items,
          onChanged: (val) {
            cubit.translation(val);
          },
        );
      },
    );
  }
}
