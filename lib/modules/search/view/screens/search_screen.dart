import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screentasia/screentasia.dart';
import 'package:storynory/models/ads/view_ad.dart';
import 'package:storynory/models/storie_model.dart';
import 'package:storynory/modules/layout/controller/cubit.dart';
import 'package:storynory/modules/layout/controller/states.dart';
import 'package:storynory/modules/storie_layout/view/screens/storie_screen.dart';
import 'package:storynory/resources/color_manager.dart';
import 'package:storynory/resources/components.dart';
import 'package:storynory/resources/styles_manager.dart';
import 'package:storynory/resources/values_manager.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StorieCubit, StorieStates>(
      builder: (context, state) {
        StorieCubit cubit = StorieCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.primary,
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 15.w, left: 15.w, top: 20.h),
                child: CupertinoSearchTextField(
                  padding: const EdgeInsets.all(15),
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                    color: Colors.grey,
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    cubit.filterItems(value);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cubit.storiesSearch.length,
                  itemBuilder: (context, index) {
                    StorieModel story = cubit.storiesSearch[index];
                    return ListTile(
                      onTap: () {
                        AdInterstitialView.loadinterstitalAd();
                        navigateTo(
                            context,
                            StorieScreen(
                              id: story.id!,
                              title: story.title!,
                              text: story.text!,
                              author: story.author!,
                              image: story.image!,
                              dec: story.dec!,
                            ));
                        cubit.updateData(count: 1, uId: story.id!);
                      },
                      title: Text(
                        story.title!,
                        style: getBoldStyle(
                            color: ColorManager.white, fontSize: AppSize.s20),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(story.image!),
                        radius: AppSize.s30,
                      ),
                      subtitle: Text(
                        story.author!,
                        style: getLightStyle(
                            color: ColorManager.grey2, fontSize: AppSize.s15),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
