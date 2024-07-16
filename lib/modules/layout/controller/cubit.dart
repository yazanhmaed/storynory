import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:storynory/models/faviorit.dart';
import 'package:storynory/models/lang_model.dart';
import 'package:storynory/modules/layout/controller/states.dart';
import 'package:storynory/resources/components.dart';

import 'package:translator/translator.dart';

import '../../../models/storie_model.dart';
import '../../favorite_screen/view/screens/favorite_screen.dart';
import '../../home_screen/view/screens/storys.dart';
import '../../home_screen/view/screens/home_screen.dart';
import '../../setting_screen/view/screens/setting_screen.dart';

class StorieCubit extends Cubit<StorieStates> {
  StorieCubit() : super(StorieInitialState());

  static StorieCubit get(context) => BlocProvider.of(context);

  List<StorieModel> storie = [];
  List<StorieModel> stories = [];

  Future<void> getStorie() async {
    storie = [];
    stories = [];
    emit(StorieGetloadingState());
    await FirebaseFirestore.instance.collection('Storie').get().then((value) {
      for (var e in value.docs) {
        storie.add(StorieModel.fromJson(e.data()));
      }

      stories.addAll(storie);

      emit(StorieGetSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(StorieGetErrorState());
    });
  }

  final List<Map<String, dynamic>> items = [
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
  ];
  String tranLang = 'ar';

  void translation(String val) {
    LangModel langModel;
    tranLang = val;
    langModel = LangModel(lang: val);
    print(tranLang);
    emit(StorieLangSuccessState(langModel));
  }

  String? transWord = '';

  String orword = '';
  bool highlight = false;
  final translator = GoogleTranslator();
  void translatorWord({required String text}) {
    translator.translate(text, from: 'en', to: lan ?? 'ar').then((value) {
      transWord = value.toString();
      emit(TextTransSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(TextTransErrorState());
    });
  }

  void empty() {
    orword = '';
    transWord = '';
    highlight = false;
    emit(TextEmptewordState());
  }

  void word({required String word}) {
    orword = word;
    highlight = true;
    emit(TextwordState());
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

  List<Widget> screen = [
    const HomeStorysScreen(),
    const StorysScreen(),
    const FavoriteScreen(),
    Container(),
    const SettingScreen(),
  ];
  void changecurrentIndex(int index) {
    currentIndex = index;
    emit(StorieChangeState());
  }

  bool switched = false;
  void changecurrentSwitch(bool index) {
    switched = index;
    emit(StorieChangeSwatchState());
  }

  bool f = false;
  void getFav({required String id}) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(token)
        .collection('favorite')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        f = true;
        emit(StorieChangeFavState());
        print('f= $f');
      } else {
        f = false;
        emit(StorieChangeFavState());
        print('f= $f');
      }
    });
  }

//////////////////////////////////////////////////
  final userF = FirebaseAuth.instance.currentUser;
  List<FavoriteModel> favSt = [];
  bool boolfav = false;
  void getFavoriteStorie() async {
    favSt = [];

    await FirebaseFirestore.instance
        .collection('user')
        .doc(token)
        .collection('favorite')
        .get()
        .then((value) {
      for (var e in value.docs) {
        favSt.add(FavoriteModel.fromJson(e.data()));
      }
      emit(StorieGetFavSuccessState());
    }).catchError((onError) {
      // print(onError);
      emit(StorieGetFavErrorState());
    });
  }

  StorieModel storieModel = StorieModel();

  void favirote({
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
      boolFav(id: id);
      getFavoriteStorie();
      emit(StorieUserFavSuccessState());
    }).catchError((onError) {
      emit(StorieUserFavErrorState());
      print(onError);
    });
  }

  void removeFavorite({
    required String id,
  }) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(userF!.uid)
        .collection('favorite')
        .doc(id)
        .delete()
        .then((value) {
      boolFav(id: id);
      getFavoriteStorie();
      emit(StorieRemoveFavSuccessState());
    }).catchError((onError) {
      emit(StorieRemoveFavErrorState());
    });
  }

  void boolFav({required String id}) {
    //boolfav = favoriteList.contains(id);
    // print(boolfav);
    FirebaseFirestore.instance
        .collection('user')
        .doc(token)
        .collection('favorite')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        boolfav = true;
        emit(StorieChangeFavState());
        print('f= $boolfav');
      } else {
        boolfav = false;
        emit(StorieChangeFavState());
        print('f= $boolfav');
      }
    });
    emit(StorieBoolFavState());
  }
}
