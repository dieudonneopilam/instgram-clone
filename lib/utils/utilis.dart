import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

imagePicker(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  final XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('non selected image');
}
