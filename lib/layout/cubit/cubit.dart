import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:storynory/layout/cubit/states.dart';
import 'package:storynory/models/lang_model.dart';
import 'package:storynory/resources/components.dart';

import 'package:translator/translator.dart';

import '../../models/storie_model.dart';
import '../../modules/favorite_screen/favorite_screen.dart';
import '../../modules/screens/storys.dart';
import '../../modules/screens/home_screen.dart';
import '../../modules/setting_screen/setting_screen.dart';

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

  String? orword = '';
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
    emit(TextEmptewordState());
  }

  void word({required String word}) {
    orword = word;
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
}
