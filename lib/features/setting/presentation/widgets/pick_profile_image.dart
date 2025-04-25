import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sign_lang_app/core/di/dependency_injection.dart';
import 'package:sign_lang_app/core/utils/constants.dart';
import 'package:sign_lang_app/core/utils/profile_image_service.dart';
import 'package:sign_lang_app/core/utils/sharedprefrence.dart';
import 'package:sign_lang_app/core/widgets/profile_circle_avatar.dart';
import 'package:sign_lang_app/features/setting/data/models/add_image_req.dart';
import 'package:sign_lang_app/features/setting/domain/usecase/add_image_use_case.dart';
import 'package:sign_lang_app/features/setting/presentation/manager/add_image_cubit/add_image_cubit.dart';
import 'package:sign_lang_app/features/setting/presentation/manager/add_image_cubit/add_image_state.dart';

class PickProfileImage extends StatefulWidget {
  const PickProfileImage({super.key, required this.currentUserName});
  final String currentUserName;

  @override
  State<PickProfileImage> createState() => _PickProfileImageState();
}

class _PickProfileImageState extends State<PickProfileImage> {
  final picker = ImagePicker();
  File? _image;
  String? _localImagePath;
  String? _imageUrl;

  @override
  void initState() {
    //_loadImageUrl();
    super.initState();
    _loadLocalProfileImage();
  }

  Future<void> _loadImageUrl() async {
    final url = await ProfileImageService.getProfileImagePath();
    if (mounted) setState(() => _imageUrl = url);
  }

  // Load locally saved image path on init
  Future<void> _loadLocalProfileImage() async {
    final path = await ProfileImageService.getProfileImagePath();
    if (path != null && mounted) {
      setState(() {
        _localImagePath = path;
      });
    }
  }

  // Pick image from gallery and save locally
  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null && mounted) {
      final imageFile = File(pickedFile.path);
      setState(() {
        _image = imageFile;
      });
      // Save the image path locally
      //await ProfileImageService.saveProfileImagePath(pickedFile.path);
    }
  }

  Future<String> _getUserToken() async {
    final userToken =
        await SharedPrefHelper.getStringNullable(SharedPrefKeys.userToken);
    return userToken!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddImageCubit(),
      child: Column(
        children: [
          BlocConsumer<AddImageCubit, AddImageState>(
            builder: (context, state) {
              // Show locally saved image if available

              if (_localImagePath != null) {
                //log('local path image is $_localImagePath');
                return Column(
                  children: [
                    ProfileCircleAvatar(currentUserName: widget.currentUserName)
                    /*CircleAvatar(
                      radius: 40,
                      backgroundImage: FileImage(File(_localImagePath!)),
                    ),*/
                    ,
                    buildTextButton(context),
                  ],
                );
              } else {
                return Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue[200],
                      radius: 40,
                      child: Text(
                        widget.currentUserName.substring(0, 2).toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: 23),
                      ),
                    ),
                    buildTextButton(context),
                  ],
                );
              }
            },
            listener: (context, state) async {
              if (state is AddImageFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                    'Failed to upload image',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  )),
                );
              } else if (state is AddImageSuccess) {
                // Optionally save the server image URL locally
                if (state.addImageResponse.user.image != null) {
                  await ProfileImageService.saveProfileImagePath(
                    state.addImageResponse.user.image!,
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }

  TextButton buildTextButton(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await getImageFromGallery();
        if (_image != null) {
          final request = AddImageReq(
            image: _image!,
            token: await _getUserToken(),
          );
          context.read<AddImageCubit>().addImage(
                addImageUseCase: getIt<AddImageUseCase>(),
                addImageReq: request,
              );
          _loadLocalProfileImage();
        }
      },
      child: const Text(
        'Change Picture',
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }
}
