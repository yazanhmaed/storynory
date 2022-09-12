import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:storynory/resources/color_manager.dart';

import '../../resources/widgets/cardview_widget.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

class AdvanceStoryScreen extends StatelessWidget {
  const AdvanceStoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StorieCubit, StorieStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = StorieCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.primary,
          body: ConditionalBuilder(
            condition: cubit.advanceStorie.isNotEmpty,
            builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  int revIndex = cubit.advanceStorie.length - 1 - index;
                  return CardWidget(
                      context: context,
                      model: cubit.advanceStorie[revIndex],
                      cubit: cubit);
                },
                separatorBuilder: (context, index) => const SizedBox(),
                itemCount: cubit.advanceStorie.length),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
