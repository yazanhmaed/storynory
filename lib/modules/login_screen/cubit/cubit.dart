import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:storynory/modules/login_screen/cubit/states.dart';

import '../../../models/login_model.dart';
import '../../../models/user_model.dart';
import '../../../resources/components.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  String? userid;
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future signInWithGoogle() async {
    TokenLogin tokenLogin;
    // Trigger the authentication flow
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential

    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      //  print(value.credential!.token);
      tokenLogin = TokenLogin(uid: value.user!.uid);

      userCreate(uId: value.user!.uid);
      userid = value.user!.uid;
      token = value.user!.uid;

      emit(StorieLoginSuccessState(tokenLogin));
    }).catchError((onError) {
      emit(StorieLoginErrorState());
      print(onError);
    });
  }

  Future logout() async {
    FirebaseAuth.instance.signOut().then((value) {
      googleSignIn.disconnect();
      print(token);
      emit(StorieLogoutSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(StorieLogoutErrorState());
    });
  }

  void userCreate({required String uId}) {
    UserStorieModel user = UserStorieModel(
      id: uId,
    );
    FirebaseFirestore.instance
        .collection('user')
        .doc(uId)
        .set(user.toMap())
        .then((value) {
      emit(StorieUserSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(StorieUserErrorState());
    });
  }

}
