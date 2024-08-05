import '../../../models/login_model.dart';

abstract class AuthenticationStates {}

class LoginInitialState extends AuthenticationStates {}

class StorieLoginSuccessState extends AuthenticationStates {
  final TokenLogin tokenLogin;

  StorieLoginSuccessState(this.tokenLogin);
}

class StorieLoginErrorState extends AuthenticationStates {}

class StorieSignOutSuccessState extends AuthenticationStates {}

class StorieSignOutErrorState extends AuthenticationStates {}

class StorieUserSuccessState extends AuthenticationStates {}

class StorieUserErrorState extends AuthenticationStates {}

class UserInitialState extends AuthenticationStates {}

class UserLoadingState extends AuthenticationStates {}

class UserSuccessState extends AuthenticationStates {
  final String uId;
  final String email;

  UserSuccessState(this.uId, this.email);
}

class UserErrorState extends AuthenticationStates {}

class CreateUserErrorState extends AuthenticationStates {}

class GetUserSuccessState extends AuthenticationStates {
  final String name;

  GetUserSuccessState(this.name);
}

class ChangeCurrentSwitchSuccessState extends AuthenticationStates {}

class EmailVerifySuccessState extends AuthenticationStates {}

class EmailVerifyErrorState extends AuthenticationStates {}

class PasswordResetSuccessState extends AuthenticationStates {}

class PasswordResetErrorState extends AuthenticationStates {}

class ChangeobscureTextSuccessState extends AuthenticationStates {}

class NewUserLoadingState extends AuthenticationStates {}

class NewUserSuccessState extends AuthenticationStates {}

class NewUserErrorState extends AuthenticationStates {
  final String error;

  NewUserErrorState(this.error);
}

class NewCreateUserSuccessState extends AuthenticationStates {}

class LogoutSuccessState extends AuthenticationStates {}

class LogoutErrorState extends AuthenticationStates {}

class ChangeDrawState extends AuthenticationStates {}
