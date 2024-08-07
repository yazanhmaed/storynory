import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:storynory/modules/on_boarding/view/screens/on_boarding_screen.dart';
import 'package:storynory/resources/values_manager.dart';
import 'package:storynory/modules/setting_screen/view/widgets/dropdown.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/components.dart';
import '../../../../resources/string_manager.dart';
import '../widgets/list_setting_widget.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../../favorite_screen/view/screens/favorite_screen.dart';
import '../../../authentication/view/screens/authentication_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final googleSignIn = GoogleSignIn();

    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: AppBar(
        title: Text(
          'Profile',
          style:
              TextStyle(color: ColorManager.white, fontWeight: FontWeight.bold),
        ),
        elevation: AppSize.s0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: AppPadding.p20, horizontal: AppPadding.p5),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                backgroundColor: ColorManager.white,
                maxRadius: AppSize.s60,
                backgroundImage: Image(
                  image: NetworkImage(user?.photoURL ?? AppString.imageUrl),
                  height: Appheight.h200,
                  width: Appwidth.w200,
                  fit: BoxFit.fill,
                  errorBuilder: (context, url, error) => const Image(
                    image: AssetImage(AppString.errorimage),
                    height: Appheight.h200,
                    fit: BoxFit.fill,
                  ),
                ).image,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                user?.displayName ?? '',
                style: TextStyle(
                    color: ColorManager.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                user!.email ?? ' ',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: AppPadding.p20),
                children: [
                  ListSetting(
                    ontap: () {
                      navigateTo(context, const FavoriteScreen());
                    },
                    text: AppString.list1,
                    leading: FaIcon(
                      Icons.favorite,
                      color: ColorManager.white,
                    ),
                  ),
                  ListSetting(
                      ontap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              backgroundColor: ColorManager.primary,
                              title: Text(
                                AppString.adtext1,
                                style: TextStyle(
                                    color: ColorManager.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: SizedBox(
                                  width: MediaQuery.sizeOf(context).width,
                                  child: const DropDownWidget()),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, AppString.ok);
                                  },
                                  child: Text(
                                    AppString.ok,
                                    style: TextStyle(
                                      color: ColorManager.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      text: AppString.list2,
                      leading: FaIcon(
                        Icons.g_translate,
                        color: ColorManager.white,
                      )),
                  ListSetting(
                      ontap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              backgroundColor: ColorManager.primary,
                              title: Text(
                                AppString.adtext2,
                                style: TextStyle(
                                    color: ColorManager.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: const Text(
                                AppString.labelText2,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, AppString.ok);
                                  },
                                  child: Text(
                                    AppString.ok,
                                    style: TextStyle(
                                      color: ColorManager.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      text: AppString.list3,
                      leading: Icon(
                        Icons.description,
                        color: ColorManager.white,
                      )),
                  ListSetting(
                      ontap: () {
                        navigateTo(context, const OnBoardingScreen());
                      },
                      text: AppString.list4,
                      leading: FaIcon(
                        FontAwesomeIcons.book,
                        color: ColorManager.white,
                      )),
                  ListSetting(
                      ontap: () {
                        final InAppReview inAppReview = InAppReview.instance;

                        inAppReview.openStoreListing();
                      },
                      text: 'Rate',
                      leading: Icon(
                        Icons.star,
                        color: ColorManager.white,
                      )),
                  ListSetting(
                      ontap: () {
                        CacheHelper.removeData(key: 'token').then((value) =>
                            navigateAndFinish(
                                context, const AuthenticationScreen()));
                        currentIndex = 0;
                        FirebaseAuth.instance.signOut().then((value) {
                          googleSignIn.disconnect();
                        });
                      },
                      text: AppString.list5,
                      leading: Icon(
                        Icons.logout,
                        color: ColorManager.white,
                      )),
                ],
              ),
            ),
            Text(
              AppString.byname,
              style: TextStyle(
                  color: ColorManager.white.withOpacity(0.2),
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
