import 'dart:io';

import 'package:dartz/dartz.dart' as dartz;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:qhub/Domain/SubmitPost/UploadImageModel.dart';

class AddImageWidget extends StatelessWidget {
  final UploadImageModel imageUploader;

  dartz.Option<String> _imageName = dartz.None();
  dartz.Option<String> _imagePath = dartz.None();

  AddImageWidget(this.imageUploader);

  void upload() async {
    final pickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    if (pickerResult != null) {
      final imageFile = File(pickerResult.files.single.path);
      print("[AddImageWidget.dart] imageFile path: ${imageFile.path}");
      print("[AddImageWidget.dart] imageFile uri: ${imageFile.uri}");
      imageUploader.uploadImage(imageFile);

      _imageName = dartz.Some(imageFile.path.split('/').last);
      _imagePath = dartz.Some(imageFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: ValueListenableBuilder<UploadImageStatus>(
        valueListenable: imageUploader.uploadStatus,
        builder: (context, status, child) {
          switch (status) {
            case UploadImageStatus.notSelected:
              return _buildEmpty(context);
            case UploadImageStatus.uploading:
              return _buildLoading(context);
            case UploadImageStatus.uploaded:
              return _buildUploaded(context);
          }
        },
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 50,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            SizedBox(
              height: 25,
              width: 60,
              child: LinearProgressIndicator(
                color: theme.colorScheme.onSurface,
                backgroundColor: Colors.transparent,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                imageUploader.cancel();
              },
              icon: Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 50,
      child: InkWell(
        onTap: () async {
          upload();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text('Attach image', style: theme.textTheme.headline6),
              Spacer(),
              Icon(Icons.add),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploaded(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(_imageName.foldRight('', (a, previous) => a), style: theme.textTheme.headline6),
              Spacer(),
              IconButton(
                onPressed: () {
                  imageUploader.cancel();
                },
                icon: Icon(Icons.close),
              ),
            ],
          ),
        ),
        Image.file(File(_imagePath.foldRight('', (a, previous) => a)))
      ],
    );
  }
}
