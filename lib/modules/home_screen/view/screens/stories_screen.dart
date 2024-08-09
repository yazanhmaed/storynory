import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screentasia/screentasia.dart';
import 'package:storynory/modules/layout/controller/cubit.dart';
import 'package:storynory/modules/layout/controller/states.dart';

import 'package:storynory/resources/color_manager.dart';

import '../../../../models/ads/banner_ad.dart';

import '../../../../models/ads/view_ad.dart';
import '../../../../resources/components.dart';
import '../../../storie_layout/view/screens/storie_screen.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StorieCubit, StorieStates>(
      builder: (context, state) {
        var cubit = StorieCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.primary,
          body: ConditionalBuilder(
            condition: cubit.stories.isNotEmpty,
            builder: (context) => Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.only(top: 20),
                    physics: const BouncingScrollPhysics(),
                    itemCount: cubit.stories.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      int revIndex = cubit.stories.length - 1 - index;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            AdInterstitialView.loadinterstitalAd();
                            navigateTo(
                                context,
                                StorieScreen(
                                  title: cubit.stories[revIndex].title!,
                                  text: cubit.stories[revIndex].text!,
                                  image: cubit.stories[revIndex].image!,
                                  author: cubit.stories[revIndex].author!,
                                  dec: cubit.stories[revIndex].dec!,
                                  id: cubit.stories[revIndex].id!,
                                ));
                            cubit.updateData(
                                count: 1, uId: cubit.stories[revIndex].id!);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 4),
                                  blurRadius: 8.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: GridTile(
                                footer: GridTileBar(
                                  backgroundColor: Colors.white60,
                                  title: Text(
                                    cubit.stories[revIndex].title!,
                                    style: GoogleFonts.getFont(
                                        'Merriweather Sans',
                                        color: Colors.black,
                                        fontSize: 14.sp),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    FadeInImage(
                                      placeholder: const AssetImage(
                                          'assets/images/no_image.jpg'),
                                      image: NetworkImage(
                                          cubit.stories[revIndex].image!),
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black54,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const AdBannerModels(),
              ],
            ),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
