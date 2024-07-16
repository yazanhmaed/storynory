import 'package:screentasia/screentasia.dart';
import 'package:storynory/models/ads/view_ad.dart';
import 'package:storynory/modules/layout/controller/cubit.dart';
import 'package:storynory/modules/storie_layout/view/screens/storie_screen.dart';
import 'package:storynory/resources/components.dart';

class MovieCardItem extends StatelessWidget {
  final int itemIndex;
  final int itemCount;
  final bool needsSpacing;
  final dynamic model;
  final StorieCubit cubit;

  const MovieCardItem({
    super.key,
    required this.itemIndex,
    required this.itemCount,
    required this.needsSpacing,
    this.model,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          AdInterstitialView.loadinterstitalAd();
          navigateTo(
              context,
              StorieScreen(
                title: model.title!,
                text: model.text!,
                image: model.image!,
                author: model.author!,
                dec: model.dec!,
                id: model.id!,
              ));
          cubit.updateData(count: 1, uId: model.id);
        },
        child: SizedBox(
          width: 150.w,
          height: 100.h,
          child: Hero(
            tag: model.image!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FadeInImage(
                  placeholder: const AssetImage('assets/images/no_image.jpg'),
                  image: NetworkImage(model.image!),
                  fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }
}
