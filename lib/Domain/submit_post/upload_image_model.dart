import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:qhub/domain/core/api.dart' as api;
import 'package:qhub/domain/core/flashbar_controller.dart';
import 'package:qhub/domain/locators.dart';

enum UploadImageStatus {
  notSelected,
  uploading, 
  uploaded,
}

class UploadImageModel {
  final _cancelToken = CancelToken();
  final _statusNotifier = ValueNotifier<UploadImageStatus>(UploadImageStatus.notSelected);
  Option<String> _uploadedImageUri = None();
  Option<String> get uploadedImageUri => _uploadedImageUri;

  UploadImageModel();

  /// Wheather the image is uploaded or not (bool). If none,  
  ValueListenable<UploadImageStatus> get uploadStatus => _statusNotifier;

  Future<Option<String>> uploadImage(File imageFile) async {
    // If uploading is already in process, cancel it before starting a new one.
    if (uploadStatus.value == UploadImageStatus.uploading) cancel();

    _statusNotifier.value = UploadImageStatus.uploading;
    final res = await api.uploadImage(imageFile, _cancelToken);

    return _uploadedImageUri = res.fold(
      (l) {
        locator<FlashbarController>().send(l);
        _statusNotifier.value = UploadImageStatus.notSelected;
        return None();
      },
      (r) {
        _statusNotifier.value = UploadImageStatus.uploaded;
        return Some(r);
      },
    );
  }

  void cancel() {
    _cancelToken.cancel();
    _statusNotifier.value = UploadImageStatus.notSelected;
    _uploadedImageUri = None();
  }
}
