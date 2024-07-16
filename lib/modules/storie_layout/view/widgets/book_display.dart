import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:pagination_flutter/pagination.dart';
import 'package:screentasia/screentasia.dart';
import 'package:storynory/modules/layout/controller/cubit.dart';
import 'package:word_selectable_text/word_selectable_text.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/string_manager.dart';
import '../../../../resources/styles_manager.dart';
import '../../../../resources/values_manager.dart';

class BookDisplay extends StatefulWidget {
  const BookDisplay({
    super.key,
    required this.text,
    required this.title,
    required this.author,
    required this.image,
    required this.dec,
    required this.cubit,
  });

  final String title;
  final String author;
  final String image;
  final String dec;
  final String text;
  final StorieCubit cubit;

  @override
  // ignore: library_private_types_in_public_api
  _BookDisplayState createState() => _BookDisplayState();
}

class _BookDisplayState extends State<BookDisplay> {
  final PageController _pageController = PageController(initialPage: 0);

  final List<String> _pages = [
    ' ',
  ];
  final double _pageSize = 600.0; // Set your desired page size

  @override
  void initState() {
    super.initState();
    _splitTextIntoPages();
  }

  void _splitTextIntoPages() {
    final words = widget.text.split(
      '.',
    );
    String currentPage = '';
    double currentPageSize = 1;

    for (final word in words) {
      final wordSize = word.length.toDouble();
      final spaceSize = ' '.length.toDouble();

      if ((currentPageSize + wordSize + spaceSize) <= _pageSize) {
        currentPage += ' $word';
        currentPageSize += wordSize + spaceSize;
      } else {
        _pages.add(currentPage.trim());
        currentPage = word;
        currentPageSize = wordSize + spaceSize;
      }
    }

    if (currentPage.isNotEmpty) {
      _pages.add(currentPage.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightPrimary,
      body: PageView.builder(
        onPageChanged: (value) {
          if (widget.cubit.orword.isNotEmpty) {
            widget.cubit.empty();
            widget.cubit.changecurrentSwitch(false);
          }
        },
        physics: const BouncingScrollPhysics(),
        controller: _pageController,
        itemCount: _pages.length,
        itemBuilder: (BuildContext context, int index) {
          return ConditionalBuilder(
            condition: index > 0,
            fallback: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p12, top: AppPadding.p14),
                    child: Text(
                      widget.title,
                      style: getBoldStyle(
                          color: ColorManager.black.withOpacity(0.8),
                          fontSize: AppSize.s20),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p12, top: AppPadding.p2, bottom: 10),
                    child: Text(
                      widget.author,
                      style: getLightStyle(
                          color: ColorManager.grey, fontSize: AppSize.s15),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Center(
                      child: FadeInImage(
                        placeholder: const AssetImage('assets/no_image.jpg'),
                        image: NetworkImage(widget.image),
                        height: 350,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: AppPadding.p12, top: 20),
                    child: Text(
                      widget.dec,
                      style: getMediumStyle(
                          color: ColorManager.grey, fontSize: AppSize.s15),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        '( $index  / ${_pages.length} )',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        size: 40,
                      )
                    ],
                  )
                ],
              );
            },
            builder: (context) => Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 40)
                          .w,
                      child: Center(
                        child: WordSelectableText(
                          highlightColor: ColorManager.amber,
                          selectable: true,
                          text: _pages[index],
                          highlight: widget.cubit.highlight,
                          onWordTapped: (word, index) async {
                            widget.cubit.translatorWord(text: word);
                            widget.cubit.word(word: word);
                          },
                          style: TextStyle(
                            fontSize: 18.sp,
                            height: 1.5,
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),

           
                  ],
                ),
                if (widget.cubit.transWord != '' &&
                    widget.cubit.orword != '' &&
                    _pageController.page!.toInt() == index) ...[
                  Container(
                    width: double.infinity,
                    height: 60.h,
                    color: ColorManager.primary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Appwidth.w80.w,
                        ),
                        Expanded(
                          child: Text(
                            '${widget.cubit.orword} : ${widget.cubit.transWord!}',
                            style: getBoldStyle(
                                color: ColorManager.white,
                                fontSize: AppSize.s20.sp),
                          ),
                        ),
                        IconButton(
                          tooltip: AppString.hideText,
                          onPressed: () {
                            widget.cubit.empty();
                            widget.cubit.changecurrentSwitch(false);
                          },
                          icon: const Icon(Icons.arrow_drop_down_circle_sharp),
                          color: ColorManager.darksecondary,
                        )
                      ],
                    ),
                  )
                ],
                if (!(widget.cubit.transWord != '' &&
                    widget.cubit.orword != '' &&
                    _pageController.page!.toInt() == index)) ...[
                  Pagination(
                    numOfPages: _pages.length - 1,
                    selectedPage: index,
                    pagesVisible: 4,
                    spacing: 5,
                    onPageChanged: (page) {
                      setState(() {
                        _pageController.jumpToPage(page);
                        index = page;
                      });
                    },
                    nextIcon: Icon(
                      Icons.chevron_right_rounded,
                      color: ColorManager.primary,
                      size: 20,
                    ),
                    previousIcon: Icon(
                      Icons.chevron_left_rounded,
                      color: ColorManager.primary,
                      size: 20,
                    ),
                    activeTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    activeBtnStyle: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(ColorManager.primary),
                      shape: WidgetStateProperty.all(CircleBorder(
                        side: BorderSide(
                          color: ColorManager.primary,
                          width: 1,
                        ),
                      )),
                    ),
                    inactiveBtnStyle: ButtonStyle(
                      elevation: WidgetStateProperty.all(0),
                      backgroundColor: WidgetStateProperty.all(Colors.white),
                      shape: WidgetStateProperty.all(CircleBorder(
                        side: BorderSide(
                          color: ColorManager.primary,
                          width: 1,
                        ),
                      )),
                    ),
                    inactiveTextStyle: TextStyle(
                      fontSize: 14,
                      color: ColorManager.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ]
              ],
            ),
          );
        },
      ),
    );
  }
}
