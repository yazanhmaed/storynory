import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storynory/modules/login_screen/cubit/cubit.dart';
import 'package:storynory/modules/login_screen/cubit/states.dart';
import 'package:storynory/modules/on_boarding/on_boarding_screen.dart';
import 'package:storynory/resources/values_manager.dart';
import 'package:storynory/resources/widgets/dropdown.dart';

import '../../resources/color_manager.dart';
import '../../resources/components.dart';
import '../../resources/string_manager.dart';
import '../../resources/widgets/list_setting_widget.dart';
import '../../shared/network/local/cache_helper.dart';
import '../favorite_screen/favorite_screen.dart';
import '../login_screen/login_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final user = FirebaseAuth.instance.currentUser;
        var cubit = LoginCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.darksecondary,
          appBar: AppBar(
            title: Text(
              user?.displayName??'',
              style: TextStyle(
                  color: ColorManager.white, fontWeight: FontWeight.bold),
            )
            ,
            elevation: AppSize.s0,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p20, horizontal: AppPadding.p5),
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    maxRadius: AppSize.s60,
                    backgroundImage: Image(
                      image: NetworkImage(
                          user?.photoURL ?? AppString.googleImages),
                      height: Appheight.h200,
                      width: Appwidth.w200,
                      fit: BoxFit.fill,
                      errorBuilder: (context, url, error) => const Image(
                        image: AssetImage(AppString.errorimage),
                        height: Appheight.h200,
                        fit: BoxFit.fill,
                      ),
                    ).image,
                    //NetworkImage(user!.photoURL!),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(top: AppPadding.p20),
                    children: [
                      ListSetting(
                        ontap: () {
                          navigateTo(context, const FavoriteScreen());
                        },
                        text: AppString.list1,
                        trainling: FaIcon(
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
                                  content: const DropDownWidget(),
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
                          trainling: FaIcon(
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
                                  content: const Text(AppString.labelText2),
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
                          trainling: Icon(
                            Icons.description,
                            color: ColorManager.white,
                          )),
                      ListSetting(
                          ontap: () {
                            navigateTo(context, const OnBoardingScreen());
                          },
                          text: AppString.list4,
                          trainling: FaIcon(
                            FontAwesomeIcons.book,
                            color: ColorManager.white,
                          )),
                      ListSetting(
                          ontap: () {
                            CacheHelper.removeData(key: AppString.tokenkey);
                            cubit.logout();
                            navigateTo(context, const LoginScreen());
                          },
                          text: AppString.list5,
                          trainling: Icon(
                            Icons.logout,
                            color: ColorManager.white,
                          )),
                    ],
                  ),
                ),
                Text(
                  AppString.byname,
                  style: TextStyle(
                      color: ColorManager.primary, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
