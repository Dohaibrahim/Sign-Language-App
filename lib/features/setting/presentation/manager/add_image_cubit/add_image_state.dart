import 'package:sign_lang_app/features/setting/data/models/add_image_response.dart';

abstract class AddImageState {}

class AddImageInitial extends AddImageState {}

class AddImageLoading extends AddImageState {}

class AddImageSuccess extends AddImageState {
  final AddImageResponse addImageResponse;
  AddImageSuccess(this.addImageResponse);
}

class AddImageFailure extends AddImageState {
  final String message;
  AddImageFailure(this.message);
}
