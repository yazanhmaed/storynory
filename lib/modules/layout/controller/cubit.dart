import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:storynory/models/faviorit.dart';
import 'package:storynory/models/lang_model.dart';
import 'package:storynory/modules/layout/controller/states.dart';
import 'package:storynory/modules/search/view/screens/search_screen.dart';
import 'package:storynory/modules/search/view/screens/searchdata.dart';
import 'package:storynory/resources/components.dart';

import 'package:translator/translator.dart';

import '../../../models/storie_model.dart';
import '../../favorite_screen/view/screens/favorite_screen.dart';
import '../../home_screen/view/screens/stories_screen.dart';
import '../../home_screen/view/screens/home_screen.dart';
import '../../setting_screen/view/screens/setting_screen.dart';

class StorieCubit extends Cubit<StorieStates> {
  StorieCubit() : super(StorieInitialState());

  static StorieCubit get(context) => BlocProvider.of(context);

  dynamic screen(BuildContext context) {
    switch (currentIndex) {
      case 0:
        return const HomeStorysScreen();
      case 1:
        return const StoriesScreen();
      case 2:
        return const FavoriteScreen();
      case 3:
        return const SearchScreen();
      case 4:
        return const SettingScreen();

      default:
        return const HomeStorysScreen();
    }
  }

  final List<Map<String, dynamic>> itemsTranslator = [
    {
      'value': 'ar',
      'label': 'English to Arabic',
    },
    {
      'value': 'ru',
      'label': 'English to Russia',
    },
    {
      'value': 'es',
      'label': 'English to Span',
    },
    {
      'value': 'zh-cn',
      'label': 'English to China',
    },
    {
      'value': 'pt',
      'label': 'English to Portuguese',
    },
    {
      'value': 'tr',
      'label': 'English to Turkish',
    },
  ];
  String translatorLang = 'ar';
  String? transWord = '';
  String originalWord = '';
  bool highlight = false;
  List<StorieModel> stories = [];
  List<StorieModel> storiesSearch = [];
  final translator = GoogleTranslator();
  int bookDisplayIndex = 0;
  final user = FirebaseAuth.instance.currentUser;
  List<FavoriteModel> favorites = [];

  Future<void> getStorie() async {
    stories = [];
    emit(StorieGetloadingState());
    await FirebaseFirestore.instance.collection('Storie').get().then((value) {
      for (var e in value.docs) {
        stories.add(StorieModel.fromJson(e.data()));
      }
      emit(StorieGetSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(StorieGetErrorState());
    });
  }

  void translation(String value) {
    LanguageModel languageModel;
    translatorLang = value;
    languageModel = LanguageModel(language: value);
    print(translatorLang);
    emit(StorieLanguageSuccessState(languageModel));
  }

  void translatorWord({required String text}) {
    originalWord = text;
    highlight = true;
    translator.translate(text, from: 'en', to: language ?? 'ar').then((value) {
      transWord = value.toString();
      emit(TextTransSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(TextTransErrorState());
    });
  }

  void emptyTranslatorWord() {
    originalWord = '';
    transWord = '';
    highlight = false;
    emit(TextEmptewordState());
  }

  void updateData({
    required int count,
    required String uId,
  }) {
    FirebaseFirestore.instance
        .collection('Storie')
        .doc(uId)
        .update({'view': FieldValue.increment(count)}).then((value) {
      emit(StorieUpdateSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(StorieUpdateErrorState());
    });
  }

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(StorieChangeState());
  }

  void getFavorites({required String id}) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(token)
        .collection('favorite')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      emit(StorieChangeFavState());
    });
  }

//////////////////////////////////////////////////

  void getFavoriteStorie() async {
    favorites = [];
    await FirebaseFirestore.instance
        .collection('user')
        .doc(token)
        .collection('favorite')
        .get()
        .then((value) {
      for (var e in value.docs) {
        favorites.add(FavoriteModel.fromJson(e.data()));
      }
      emit(StorieGetFavSuccessState());
    }).catchError((onError) {
      // print(onError);
      emit(StorieGetFavErrorState());
    });
  }

  void setFavirotes({
    required String id,
    required String title,
    required String dec,
    required String author,
    required String text,
    required String image,
    int? view,
  }) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(token)
        .collection('favorite')
        .doc(id)
        .set({
      'id': id,
      'title': title,
      'dec': dec,
      'author': author,
      'text': text,
      'image': image,
      'view': view,
    }).then((value) {
      getFavoriteStorie();
      emit(StorieUserFavSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(StorieUserFavErrorState());
    });
  }

  void removeFavorites({
    required String id,
  }) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .collection('favorite')
        .doc(id)
        .delete()
        .then((value) {
      getFavoriteStorie();
      emit(StorieRemoveFavSuccessState());
    }).catchError((onError) {
      emit(StorieRemoveFavErrorState());
    });
  }

//BookDisplay
  void onPageChangedIndex(int index) {
    bookDisplayIndex = index;
    emit(StorieChangeState());
  }

    void filterItems(String query) {
    final results = stories.where((item) => item.title!.toLowerCase().contains(query.toLowerCase())).toList();
   
      storiesSearch = results;
    emit(StorieSearchState());
   
  }
}
