import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_lang_app/core/utils/profile_image_service.dart';
import 'package:sign_lang_app/features/setting/presentation/manager/add_image_cubit/add_image_cubit.dart';
import 'package:sign_lang_app/features/setting/presentation/manager/add_image_cubit/add_image_state.dart';

class ProfileCircleAvatar extends StatefulWidget {
  const ProfileCircleAvatar({
    super.key,
    required this.currentUserName,
    this.onImageUpdated,
  });
  final String currentUserName;
  final VoidCallback? onImageUpdated;

  @override
  State<ProfileCircleAvatar> createState() => _ProfileCircleAvatarState();
}

class _ProfileCircleAvatarState extends State<ProfileCircleAvatar> {
  String? _localImagePath;

  Future<void> _loadLocalProfileImage() async {
    final path = await ProfileImageService.getProfileImagePath();
    if (path != null && mounted) {
      setState(() {
        _localImagePath = path;
      });
    }
  }

  @override
  void initState() {
    _loadLocalProfileImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? imagePath;
    return BlocBuilder<AddImageCubit, AddImageState>(builder: (context, state) {
      if (state is AddImageSuccess) {
        setState(() {
          imagePath = state.addImageResponse.user.image;
          //_loadLocalProfileImage();
        });
        CircleAvatar(
          radius: 40,
          backgroundImage: FileImage(File(imagePath!)),
        );
      } else {
        // uncommenting this will make a huge rebuilds
        //_loadLocalProfileImage();
        imagePath = _localImagePath;

        if (imagePath == null) {
          return CircleAvatar(
              radius: 40,
              child:
                  Text(widget.currentUserName.substring(0, 2).toUpperCase()));
        }
        return CircleAvatar(
          radius: 40,
          backgroundImage: FileImage(File(imagePath!)),
        );
      }
      return SizedBox();
    });
  }
}

/*
class ProfileCircleAvatar extends StatefulWidget {
  final String currentUserName;

  const ProfileCircleAvatar({
    super.key,
    required this.currentUserName,
  });

  @override
  State<ProfileCircleAvatar> createState() => _ProfileCircleAvatarState();
}

class _ProfileCircleAvatarState extends State<ProfileCircleAvatar> {
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final path = await ProfileImageService.getProfileImagePath();
    if (mounted) {
      setState(() => _imagePath = path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddImageCubit, AddImageState>(
      listener: (context, state) {
        if (state is AddImageSuccess &&
            state.addImageResponse.user.image != null) {
          if (mounted) {
            setState(() => _imagePath = state.addImageResponse.user.image);
          }
        }
      },
      child: CircleAvatar(
        radius: 40,
        backgroundImage:
            _imagePath != null ? FileImage(File(_imagePath!)) : null,
        child: _imagePath == null
            ? Text(widget.currentUserName.substring(0, 2).toUpperCase())
            : null,
      ),
    );
  }
}
*/
