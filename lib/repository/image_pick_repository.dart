import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

abstract class BaseImagePickRepository {
  Future<void> imagePick();
}

final imageRepositoryProvider = Provider<ImagePickRepository>((ref) {
  return ImagePickRepository(ref.read);
});

class ImagePickRepository implements BaseImagePickRepository {
  final Reader _read;
  ImagePickRepository(this._read);

  File? imgFile;

  @override
  Future imagePick() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    imgFile = File(image!.path);
    File compressedImage = await imageCompress(imgFile!);
    return compressedImage;
  }

  @override
  Future imageCompress(File imgFile) async {
    final filePath = imgFile.absolute.path;

    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    var result = await FlutterImageCompress.compressAndGetFile(
      imgFile.absolute.path,
      outPath,
      quality: 5,
    );

    return result;
  }
}
