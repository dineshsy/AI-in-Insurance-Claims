import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';


class ImageHelper  {
    File pickedImage;

    Future pickImage() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);
    pickedImage = tempStore;
    return pickedImage;
  }
}