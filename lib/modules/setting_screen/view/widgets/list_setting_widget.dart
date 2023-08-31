import 'package:flutter/material.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/values_manager.dart';

class ListSetting extends StatelessWidget {
  final Function()? ontap;
  final String text;
  final Widget? leading;
  const ListSetting({
    Key? key,
    required this.ontap,
    required this.text,
    required this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppMargin.m10),
      color: ColorManager.primary,
      child: ListTile(
        onTap: ontap,
        title: Text(
          text,
          style:
              TextStyle(color: ColorManager.white, fontWeight: FontWeight.bold),
        ),
        leading: leading,
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
        ),
      ),
    );
  }
}
