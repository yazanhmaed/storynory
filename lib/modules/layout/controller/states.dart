import 'package:storynory/models/lang_model.dart';

abstract class StorieStates {}

class StorieInitialState extends StorieStates {}

// storie
class StorieLoadingState extends StorieStates {}

class StorieSuccessState extends StorieStates {}

class StorieErrorState extends StorieStates {}

//Image Picker
class StorieImagePicSuccessState extends StorieStates {}

class StorieImagePicErrorState extends StorieStates {}

//get data
class StorieGetloadingState extends StorieStates {}

class StorieGetSuccessState extends StorieStates {}

class StorieGetErrorState extends StorieStates {}

//delete data
class StorieRemoveSuccessState extends StorieStates {}

class StorieRemoveErrorState extends StorieStates {}

//Update data
class StorieUpdateSuccessState extends StorieStates {}

class StorieUpdateErrorState extends StorieStates {}

class StorieChangeState extends StorieStates {}

class StorieChangeSwatchState extends StorieStates {}

class StorieChangeFavState extends StorieStates {}

class StorieLanguageSuccessState extends StorieStates {
  final LanguageModel langModel;

  StorieLanguageSuccessState(this.langModel);
}

//Trans
class TextTransSuccessState extends StorieStates {}

class TextTransErrorState extends StorieStates {}

class TextEmptewordState extends StorieStates {}

class TextwordState extends StorieStates {}

/////////////////////////////
class StorieUserFavSuccessState extends StorieStates {}

class StorieUserFavErrorState extends StorieStates {}

class StorieGetFavSuccessState extends StorieStates {}

class StorieGetFavErrorState extends StorieStates {}

class StorieRemoveFavSuccessState extends StorieStates {}

class StorieRemoveFavErrorState extends StorieStates {}

class StorieBoolFavState extends StorieStates {}
