import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_lang_app/core/utils/profile_image_service.dart';
import 'package:sign_lang_app/features/setting/data/models/add_image_req.dart';
import 'package:sign_lang_app/features/setting/domain/usecase/add_image_use_case.dart';
import 'package:sign_lang_app/features/setting/presentation/manager/add_image_cubit/add_image_state.dart';
import 'package:sign_lang_app/features/setting/presentation/widgets/pick_profile_image.dart';

class AddImageCubit extends Cubit<AddImageState> {
  AddImageCubit() : super(AddImageInitial());
  String? currentImagePath;

  Future<void> addImage({
    required AddImageUseCase addImageUseCase,
    required AddImageReq addImageReq,
  }) async {
    try {
      emit(AddImageLoading());

      // 2. Upload to server
      final result = await addImageUseCase.call(addImageReq);

      result.fold(
        (failure) => emit(AddImageFailure(failure.toString())),
        (data) async {
          if (data.user.image != null) {
            currentImagePath = data.user.image;
            await ProfileImageService.saveProfileImagePath(currentImagePath!);
            //context.read<AddImageCubit>().emit(AddImageSuccess());
            //ProfileImageService.saveProfileImagePath(data.user.image!);
          }
          //_loadLocalProfileImage();
          emit(AddImageSuccess(data));
        },
      );
    } catch (e) {
      emit(AddImageFailure(e.toString()));
    }
  }
}
