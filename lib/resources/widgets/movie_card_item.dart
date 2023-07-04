import 'package:screentasia/screentasia.dart';

import '../../layout/cubit/cubit.dart';
import '../../models/ads/view_ad.dart';
import '../../modules/storie_layout/storie_screen.dart';
import '../components.dart';

class MovieCardItem extends StatelessWidget {
  final int itemIndex;
  final int itemCount;
  final bool needsSpacing;
  final dynamic model;
  final StorieCubit cubit;

  const MovieCardItem({
    Key? key,
    required this.itemIndex,
    required this.itemCount,
    required this.needsSpacing,
    this.model,
    required this.cubit,
  }) : super(key: key);

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
