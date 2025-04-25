import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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

  Future<void> _loadImageUrl() async {
    final url = await ProfileImageService.getProfileImagePath();
    if (mounted) setState(() => _localImagePath = url);
  }

  @override
  void initState() {
    _loadImageUrl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddImageCubit, AddImageState>(
      listener: (context, state) {
        if (state is AddImageSuccess) {
          _loadImageUrl();
          log('messageeeee');
          //setState(() {});
        }
      },
      child: CircleAvatar(
        radius: 40,
        child: _buildImageContent(),
      ),
    );

    /*
      builder: (context, state) {
      
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
    */
  }

  Widget _buildImageContent() {
    if (_localImagePath != null) {
      return CachedNetworkImage(
        imageUrl: _localImagePath!,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }
    return _buildInitials();
  }

  Widget _buildInitials() {
    return Text(
      widget.currentUserName.substring(0, 2).toUpperCase(),
      style: const TextStyle(color: Colors.white, fontSize: 23),
    );
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
