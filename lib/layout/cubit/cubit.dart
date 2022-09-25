import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:storynory/layout/cubit/states.dart';
import 'package:storynory/models/lang_model.dart';
import 'package:storynory/resources/components.dart';

import 'package:translator/translator.dart';

import '../../models/advance_storie_model.dart';

import '../../models/storie_model.dart';
import '../../modules/screens/advance_story_screen.dart';
import '../../modules/screens/story_screen.dart';

class StorieCubit extends Cubit<StorieStates> {
  StorieCubit() : super(StorieInitialState());

  static StorieCubit get(context) => BlocProvider.of(context);

  List<AdvanceStorieModel> advanceStorie = [];

  Future<void> getAdvanceStorie() async {
    advanceStorie = [];
    emit(StorieGetAdvanceloadingState());
    await FirebaseFirestore.instance
        .collection('AdvanceStorie')
        .get()
        .then((value) {
      for (var e in value.docs) {
        advanceStorie.add(AdvanceStorieModel.fromJson(e.data()));
      }
      emit(StorieGetAdvanceSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(StorieGetAdvanceErrorState());
    });
  }

  List<StorieModel> storie = [];

  Future<void> getStorie() async {
    storie = [];
    emit(StorieGetloadingState());
    await FirebaseFirestore.instance.collection('Storie').get().then((value) {
      for (var e in value.docs) {
        storie.add(StorieModel.fromJson(e.data()));
      }

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
    print('$tranLang yazan');
    emit(StorieLangSuccessState(langModel));
  }

  String? transWord = '';

  String? orword = '';
  final translator = GoogleTranslator();
  void translatorWord({required String text}) {
    translator.translate(text, from: 'en', to: lan!).then((value) {
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

  void updateAdvanceData({
    required int count,
    required String uId,
  }) {
    FirebaseFirestore.instance
        .collection('AdvanceStorie')
        .doc(uId)
        .update({'view': FieldValue.increment(count)}).then((value) {
      emit(StorieUpdateSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(StorieUpdateErrorState());
    });
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

  int currentIndex = 0;
  List<Widget> screen = [
    const StoryScreen(),
    const AdvanceStoryScreen(),
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
