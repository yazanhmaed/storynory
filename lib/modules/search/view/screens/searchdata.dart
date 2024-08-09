import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:storynory/resources/string_manager.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/components.dart';
import '../../../../resources/styles_manager.dart';
import '../../../../resources/values_manager.dart';

import '../../../storie_layout/view/screens/storie_screen.dart';

class SearchDataScreen extends SearchDelegate {
  CollectionReference storie = FirebaseFirestore.instance.collection('Storie');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(
            Icons.close,
            color: ColorManager.primary,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          currentIndex = 0;
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: ColorManager.primary,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: storie.snapshots().asBroadcastStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data!.docs
                .where((QueryDocumentSnapshot<Object?> element) =>
                    element['title']
                        .toString()
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                .isEmpty) {
              return Container(
                color: ColorManager.primary,
                child: Center(
                  child: Text(
                    AppString.searchScreenText,
                    style: getBoldStyle(
                        color: ColorManager.white, fontSize: AppSize.s20),
                  ),
                ),
              );
            } else {
              return Container(
                color: ColorManager.primary,
                child: ListView(
                  children: [
                    ...snapshot.data!.docs
                        .where((QueryDocumentSnapshot<Object?> element) =>
                            element['title']
                                .toString()
                                .toLowerCase()
                                .contains(query.toLowerCase()))
                        .map((QueryDocumentSnapshot<Object?> data) {
                      final String title = data.get('title');
                      final String image = data['image'];
                      final String author = data['author'];
                      final String text = data['text'];
                      final String id = data['id'];
                      final String dec = data['dec'];

                      return ListTile(
                        onTap: () {
                          navigateTo(
                              context,
                              StorieScreen(
                                id: id,
                                title: title,
                                text: text,
                                author: author,
                                image: image,
                                dec: dec,
                              ));
                        },
                        title: Text(
                          title,
                          style: getBoldStyle(
                              color: ColorManager.white, fontSize: AppSize.s20),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(image),
                          radius: AppSize.s30,
                        ),
                        subtitle: Text(
                          author,
                          style: getLightStyle(
                              color: ColorManager.grey, fontSize: AppSize.s15),
                        ),
                      );
                    })
                  ],
                ),
              );
            }
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: ColorManager.primary,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
            Text(
              AppString.searchScreenText2,
              style: getBoldStyle(
                  color: ColorManager.white, fontSize: AppSize.s20),
            ),
          ],
        ),
      ),
    );
  }
}
