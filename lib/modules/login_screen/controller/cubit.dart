import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:storynory/modules/login_screen/controller/states.dart';

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
      userCreate(
        uId: value.user!.uid,
        email: value.user!.email!,
        name: value.user!.displayName!,
        token: token,
      );

      getUser(uId: value.user!.uid);

      emit(UserSuccessState(
        value.user!.uid,
        value.user!.email!,
      ));
    }).catchError((onError) {
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

  void getPassword({
    required String email,
  }) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      emit(PasswordResetSuccessState());
    }).catchError((onError) {
      Fluttertoast.showToast(
          msg: 'Check your Email',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(PasswordResetErrorState());
    });
  }

  int positive = 0;
  void changecurrentSwitch({required int posit}) {
    positive = posit;
    emit(ChangeSuccessState());
  }

  userCreate({
    required String uId,
    required String name,
    required String email,
    required String token,
  }) {
    UserModel userModel = UserModel(
      name: name,
      uId: uId,
      email: email,
      token: token,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('profile')
        .doc()
        .set(userModel.toMap())
        .then((value) {
      emit(AddCreateUserSuccessState());
    }).catchError((onError) {
      print(onError);
    });
  }

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var token = '';
  userLogin({
    required String email,
    required String password,
  }) {
    emit(UserLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      getUser(uId: value.user!.uid);
      emit(UserSuccessState(value.user!.uid, value.user!.email!));
    }).catchError((onError) {
      print(onError);
      emit(UserErrorState());
    });
  }

  List<UserModel> users = [];
  String n = '';
  void getUser({
    required String uId,
  }) async {
    users = [];
    await FirebaseFirestore.instance
        .collection('Users/')
        .doc(uId)
        .collection('profile')
        .get()
        .then((value) {
      for (var e in value.docs) {
        users.add(UserModel.fromJson(e.data()));
      }
      nameUser = users[0].name!;
      n = users[0].name!;

      emit(GetUserSuccessState(users[0].name!));
    }).catchError((onError) {
      print(onError);
    });
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String token,
  }) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(
        uId: value.user!.uid,
        name: name,
        email: email,
        token: token,
      );
      emit(AddUserSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(AddUserErrorState(onError.toString()));
    });
  }
   bool obscureText = true;
  void changeobscureText() {
    obscureText = !obscureText;
    emit(ChangeobscureTextSuccessState());
  }
}
