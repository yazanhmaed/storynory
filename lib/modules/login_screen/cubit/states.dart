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


class UserInitialState extends LoginStates {}

class UserLoadingState extends LoginStates {}

class UserSuccessState extends LoginStates {
  final String uId;
  final String email;

  UserSuccessState(this.uId, this.email);
}

class UserErrorState extends LoginStates {}

class CreateUserErrorState extends LoginStates {}

class GetUserSuccessState extends LoginStates {
  final String name;

  GetUserSuccessState(this.name);
}

class ChangeSuccessState extends LoginStates {}

class EmailVerifySuccessState extends LoginStates {}

class EmailVerifyErrorState extends LoginStates {}

class PasswordResetSuccessState extends LoginStates {}

class PasswordResetErrorState extends LoginStates {}

class ChangeobscureTextSuccessState extends LoginStates {}

class AddUserLoadingState extends LoginStates {}

class AddUserSuccessState extends LoginStates {}

class AddUserErrorState extends LoginStates {
  final String error;

  AddUserErrorState(this.error);
}

class AddCreateUserSuccessState extends LoginStates {}

class LogoutSuccessState extends LoginStates {}

class LogoutErrorState extends LoginStates {}

class ChangeDrawState extends LoginStates {}



