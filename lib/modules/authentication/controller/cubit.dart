import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:storynory/modules/layout/view/screens/home_layout.dart';
import 'package:storynory/modules/authentication/controller/states.dart';
import 'package:storynory/shared/network/local/cache_helper.dart';

import '../../../models/user_model.dart';
import '../../../resources/components.dart';




enum AuthenticationEnum {
  login(),
  signUp();

  const AuthenticationEnum();

  static List<String> nameList() {
    return [
      'Login',
      'Sign Up',
    ];
  }
}

class AuthenticationCubit extends Cubit<AuthenticationStates> {
  
  AuthenticationCubit() : super(LoginInitialState());
  static AuthenticationCubit get(context) => BlocProvider.of(context);

  String? userid;

  AuthenticationEnum position = AuthenticationEnum.login;

  GlobalKey<FormState> loginnKey = GlobalKey();
  GlobalKey<FormState>  signupKey = GlobalKey();

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var token = '';
  bool obscureText = true;

  Future signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      newCreateUser(
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

  Future<void> newCreateUser({
    required String uId,
    required String name,
    required String email,
    required String token,
  }) async {
    UserModel userModel = UserModel(
      name: name,
      uId: uId,
      email: email,
      token: token,
    );
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('profile')
        .doc()
        .set(userModel.toMap())
        .then((value) {
      emit(NewCreateUserSuccessState());
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> userLogin() async {
    emit(UserLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      getUser(uId: value.user!.uid);
      emit(UserSuccessState(value.user!.uid, value.user!.email!));
    }).catchError((onError) {
      print(onError);
      emit(UserErrorState());
    });
  }

  Future signOut() async {
    FirebaseAuth.instance.signOut().then((value) {
      googleSignIn.disconnect();
      emit(StorieSignOutSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(StorieSignOutErrorState());
    });
  }

  void sendPasswordResetEmail({
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

  void changeCurrentSwitch({required AuthenticationEnum switchPosition}) {
    position = switchPosition;
    emit(ChangeCurrentSwitchSuccessState());
  }

  Future<void> getUser({
    required String uId,
  }) async {
    await FirebaseFirestore.instance
        .collection('Users/')
        .doc(uId)
        .collection('profile')
        .get()
        .then((value) {
      var data = UserModel.fromJson(value.docs.first.data());
      nameUser = data.name!;
      emit(GetUserSuccessState(data.name!));
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> userRegister() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      newCreateUser(
        uId: value.user!.uid,
        name: nameController.text,
        email: emailController.text,
        token: token,
      );
      emit(NewUserSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(NewUserErrorState(onError.toString()));
    });
  }

  void changeobscureText() {
    obscureText = !obscureText;
    emit(ChangeobscureTextSuccessState());
  }

  void validLogin() {
    if (loginnKey.currentState!.validate()) {
      userLogin();
    }
  }

  void validRegister() {
    if (signupKey.currentState!.validate()) {
      userRegister();
    }
  }

  void authenticationStates(
      {required AuthenticationStates state, required BuildContext context}) {
    if (state is NewUserErrorState) {
      if (state.error.toString() ==
          '[firebase_auth/weak-password] Password should be at least 6 characters') {
        Fluttertoast.showToast(
            msg: 'Password should be at least 6 characters',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: 'Email already exists',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
    if (state is UserErrorState) {
      Fluttertoast.showToast(
          msg: 'Verify your email and password',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    if (state is UserSuccessState) {
      token = state.uId;
      CacheHelper.seveData(key: 'token', value: state.uId).then((value) {
        navigateAndFinish(context, const HomeLayoutScreen());
      });

      if (state is NewCreateUserSuccessState) {
        AuthenticationCubit.get(context).position = AuthenticationEnum.login;
      }
    }
  }
}
