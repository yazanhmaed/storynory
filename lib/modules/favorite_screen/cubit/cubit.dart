import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storynory/modules/favorite_screen/cubit/states.dart';

import '../../../models/faviorit.dart';
import '../../../models/storie_model.dart';
import '../../../resources/components.dart';

class FavoriteCubit extends Cubit<FavoriteStates> {
  FavoriteCubit() : super(FavoriteInitialState());
  static FavoriteCubit get(context) => BlocProvider.of(context);

  final userF = FirebaseAuth.instance.currentUser;
  List<FavoriteModel> favSt = [];

  void getFavoriteStorie() async {
    favSt = [];
    favoriteList = [];
   
    await FirebaseFirestore.instance
        .collection('user')
        .doc(token)
        .collection('favorite')
        .get()
        .then((value) {
      for (var e in value.docs) {
        favSt.add(FavoriteModel.fromJson(e.data()));

      
      }
      for (int i = 0; i <= favSt.length; i++) {
        print(favSt[i].id);
        favoriteList.add(favSt[i].id!);
       
      }
      

      emit(StorieGetFavSuccessState());
    }).catchError((onError) {
      print(onError);
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
      getFavoriteStorie();
      emit(StorieRemoveFavSuccessState());
    }).catchError((onError) {
      emit(StorieRemoveFavErrorState());
    });
  }

  bool boolfav = false;
  void boolFav({required String id}) {
    boolfav = favoriteList.contains(id);
    print(boolfav);
    emit(StorieBoolFavState());
  }
}
