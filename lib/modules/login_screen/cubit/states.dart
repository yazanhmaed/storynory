import '../../../models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class StorieLoginSuccessState extends LoginStates {
  final TokenLogin tokenLogin;

  StorieLoginSuccessState(this.tokenLogin);
}

class StorieLoginErrorState extends LoginStates {}

class StorieLogoutSuccessState extends LoginStates {}

class StorieLogoutErrorState extends LoginStates {}

class StorieUserSuccessState extends LoginStates {}

class StorieUserErrorState extends LoginStates {}




