import 'dart:io';

import 'package:dio/dio.dart';

extension MultiPart on File {
  Future<MultipartFile> toMultipart() async {
    final fileName = path.split('/').last;
    return await MultipartFile.fromFile(path, filename: fileName);
  }

  String get name => path.split('/').last;
  String get extension => name.split('.').last;

  bool get isImage {
    const imageExtensions = [
      'jpg',
      'jpeg',
      'png',
      'gif',
      'bmp',
      'webp',
      'heic',
    ];
    return imageExtensions.contains(extension);
  }
}
