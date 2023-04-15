// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:image_picker/image_picker.dart';

import 'dart:io';

Future<void> uploadImageToBlobStorage(XFile imageFile) async {
  final imagePicker = ImagePicker();
  final imageFile = await imagePicker.pickImage(source: ImageSource.gallery);
  await uploadImageToBlobStorage(imageFile!);

  final imageBytes = await imageFile.readAsBytes();
  final fileName = "niraj2"; //_imageFile!.name;
  final uploadedImagePath = 'images/$fileName';
  const url = 'https://holainnstorage.blob.core.windows.net/';
  const containerName = 'holainncontainer';
  const sasToken =
      '?sv=2021-12-02&ss=bfqt&srt=o&sp=rwdlacupiytfx&se=2024-04-05T00:34:20Z&st=2023-04-04T16:34:20Z&spr=https&sig=9y0rprNcbcVYSZQX9SjKS6Vhctnu0R0IP5Kk2irvs5Q%3D';
  final uploadUrl = '$url$containerName/$fileName$sasToken';

  final httpClient = HttpClient();
  final request = await httpClient.putUrl(Uri.parse(uploadUrl));
  request.headers.set('x-ms-blob-type', 'BlockBlob');
  request.headers.set('Content-Length', imageBytes.length.toString());
  request.add(imageBytes);
  final response = await request.close();

  if (response.statusCode == 201) {
    final uploadedImageUrl = '$url$containerName/$uploadedImagePath$sasToken';
    // Do something with uploadedImageUrl, such as saving it to a database.
  }
}
