import 'package:google_fonts/google_fonts.dart';
import 'package:screentasia/screentasia.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/values_manager.dart';

class ListSetting extends StatelessWidget {
  final Function()? ontap;
  final String text;
  final Widget? leading;
  const ListSetting({
    super.key,
    required this.ontap,
    required this.text,
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppMargin.m10),
      color: ColorManager.primary,
      child: ListTile(
        onTap: ontap,
        title: Text(
          text,
          style: GoogleFonts.getFont(
            'Merriweather Sans',
            color: Colors.white,
            fontSize: 14.sp,
          ),
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
