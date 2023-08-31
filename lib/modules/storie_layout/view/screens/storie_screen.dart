import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storynory/modules/layout/controller/cubit.dart';
import 'package:storynory/modules/layout/controller/states.dart';
import 'package:storynory/modules/layout/view/screens/home_layout.dart';
import 'package:storynory/resources/color_manager.dart';
import 'package:storynory/resources/components.dart';


import '../widgets/book_display.dart';

class StorieScreen extends StatelessWidget {
  const StorieScreen({
    Key? key,
    required this.title,
    required this.text,
    required this.author,
    required this.image,
    required this.dec,
    required this.id,
  }) : super(key: key);

  final String id;
  final String title;
  final String dec;
  final String text;
  final String author;
  final String image;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StorieCubit, StorieStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = StorieCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.darksecondary,
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    cubit.boolfav == false
                        ? cubit.favirote(
                            author: author,
                            dec: dec,
                            id: id,
                            image: image,
                            text: text,
                            title: title)
                        : cubit.removeFavorite(id: id);
                  },
                  icon: cubit.boolfav == true
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border))
            ],
            title: Text(title),
            leading: IconButton(
                onPressed: () {
                  cubit.empty();
                  cubit.changecurrentIndex(0);
                  navigateAndFinish(context, const HomeLayoutScreen());
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
          body: BookDisplay(
            title: title,
            author: author,
            image: image,
            dec: dec,
            text: text,
            cubit: cubit,
          ),
        );
      },
    );
  }
}
