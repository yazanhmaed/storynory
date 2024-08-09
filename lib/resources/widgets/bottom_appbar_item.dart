import 'package:screentasia/screentasia.dart';
import 'package:storynory/resources/color_manager.dart';

class BottomBarItem extends StatelessWidget {
  final IconData icon;
  final bool colorCondition;
  final void Function()? onPressed;
  final String title;
  const BottomBarItem({
    super.key,
    required this.icon,
    required this.title,
    required this.colorCondition,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          children: [
            Icon(
              icon,
              color:
                  colorCondition ? ColorManager.secondary2 : Colors.grey[600],
              size: 25.r,
            ),
            Text(
              title,
              style: TextStyle(
                color:
                    colorCondition ? ColorManager.secondary2 : Colors.grey[600],
              ),
            )
          ],
        ),
      ),
    );
  }
}
