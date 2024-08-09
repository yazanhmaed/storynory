 import 'package:google_fonts/google_fonts.dart';
import 'package:screentasia/screentasia.dart';
import 'package:storynory/modules/layout/controller/cubit.dart';

 
class MovieListTitle extends StatelessWidget {
  final String title;
  final StorieCubit cubit;
  const MovieListTitle({
    super.key,
    required this.title,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.getFont(
              'Merriweather Sans',
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => cubit.changeCurrentIndex(1),
            child: Text(
              'See all',
              style: GoogleFonts.getFont(
                'Merriweather Sans',
                color: Colors.amber,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
