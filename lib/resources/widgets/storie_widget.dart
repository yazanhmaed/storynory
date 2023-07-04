// import 'package:flutter/material.dart';

// import 'package:storynory/resources/color_manager.dart';
// import 'package:storynory/resources/string_manager.dart';
// import 'package:storynory/resources/styles_manager.dart';
// import 'package:storynory/resources/values_manager.dart';
// import 'package:word_selectable_text/word_selectable_text.dart';

// import 'word_storie.dart';

// class StorieWidget extends StatelessWidget {
//   const StorieWidget({
//     Key? key,
//     required this.title,
//     required this.author,
//     required this.image,
//     required this.dec,
//     required this.text,
//     required this.cubit,
//     required this.switchbool,
//   }) : super(key: key);

//   final String title;
//   final String author;
//   final String image;
//   final String dec;
//   final String text;
//   final dynamic cubit;
//   final bool switchbool;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: AlignmentDirectional.bottomCenter,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(right: AppPadding.p10),
//           child: Scrollbar(
//             thumbVisibility: true,
//             child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         left: AppPadding.p12, top: AppPadding.p14),
//                     child: Text(
//                       title,
//                       style: getBoldStyle(
//                           color: ColorManager.black.withOpacity(0.8),
//                           fontSize: AppSize.s20),
//                     ),
//                   ),
//                   const SizedBox(height: Appheight.h5),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         left: AppPadding.p12, top: AppPadding.p2),
//                     child: Text(
//                       author,
//                       style: getLightStyle(
//                           color: ColorManager.grey, fontSize: AppSize.s15),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: AppPadding.p8),
//                     child: Stack(
//                       alignment: AlignmentDirectional.topCenter,
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(20),
//                           child: Center(
//                             child: FadeInImage(
//                               placeholder:
//                                   const AssetImage('assets/no_image.jpg'),
//                               image: NetworkImage(image),
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                         Text(
//                           AppString.storynory,
//                           style: TextStyle(color: ColorManager.secondary),
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: Appheight.h5),
//                   Padding(
//                     padding: const EdgeInsets.only(left: AppPadding.p12),
//                     child: Text(
//                       dec,
//                       style: getLightStyle(
//                           color: ColorManager.grey, fontSize: AppSize.s15),
//                     ),
//                   ),
//                   const SizedBox(height: Appheight.h10),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: AppPadding.p50),
//                     child: Padding(
//                       padding: const EdgeInsets.all(AppPadding.p8),
//                       child: switchbool == true
//                           ? WordSelectableText(
//                               highlightColor: ColorManager.amber,
//                               selectable: true,
//                               text: text,
//                               onWordTapped: (word, index) async {
//                                 print(word);
//                                 cubit.translatorWord(text: word);
//                                 cubit.word(word: word);
//                               },
//                               style: const TextStyle(
//                                 fontSize: AppSize.s20,
                                
//                               ),
//                             )
//                           : WordSelect(
//                               highlightColor: ColorManager.amber,
//                               text: text,
//                               style: const TextStyle(
//                                 fontSize: AppSize.s20,
//                               ),
//                             ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         if (cubit.transWord != '' && cubit.orword != '' && switchbool == true)
//           Container(
//             width: double.infinity,
//             height: Appheight.h50,
//             color: ColorManager.primary,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const SizedBox(width: Appwidth.w80),
//                 Expanded(
//                   child: Text(
//                     '${cubit.orword} : ${cubit.transWord!}',
//                     style: getBoldStyle(
//                         color: ColorManager.white, fontSize: AppSize.s20),
//                   ),
//                 ),
//                 IconButton(
//                   tooltip: AppString.hideText,
//                   onPressed: () {
//                     cubit.empty();
//                     cubit.changecurrentSwitch(false);
//                   },
//                   icon: const Icon(Icons.arrow_drop_down_circle_sharp),
//                   color: ColorManager.darksecondary,
//                 )
//               ],
//             ),
//           )
//       ],
//     );
//   }
// }
