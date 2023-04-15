import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AzureBlobStorageDemo(),
    );
  }
}

class AzureBlobStorageDemo extends StatefulWidget {
  @override
  _AzureBlobStorageDemoState createState() => _AzureBlobStorageDemoState();
}

class _AzureBlobStorageDemoState extends State<AzureBlobStorageDemo> {
  XFile? _imageFile;
  String? _uploadedImageUrl;

  Future<void> _uploadImage() async {
    print("a");
    if (_imageFile != null) {
      print("b");
      final imageBytes = await _imageFile!.readAsBytes();
      final fileName = _imageFile!.name;
      final uploadedImagePath = 'images/$fileName';
      const url = 'https://holainnstorage.blob.core.windows.net/';
      const containerName = 'holainncontainer';
      const sasToken =
          '?sv=2021-12-02&ss=bfqt&srt=o&sp=rwdlacupiytfx&se=2024-04-05T00:34:20Z&st=2023-04-04T16:34:20Z&spr=https&sig=9y0rprNcbcVYSZQX9SjKS6Vhctnu0R0IP5Kk2irvs5Q%3D';
      final uploadUrl = '$url$containerName/$fileName$sasToken';
      print(uploadUrl);
      final httpClient = HttpClient();
      final request = await httpClient.putUrl(Uri.parse(uploadUrl));
      request.headers.set('x-ms-blob-type', 'BlockBlob');
      request.headers.set('Content-Length', imageBytes.length.toString());
      request.add(imageBytes);
      final response = await request.close();
      print(response.statusCode);
      if (response.statusCode == 201) {
        print("e");
        final uploadedImageUrl =
            '$url$containerName/$uploadedImagePath$sasToken';
        print(uploadedImageUrl);
        setState(() {
          _uploadedImageUrl = uploadedImageUrl;
        });
      }
    }
  }

  Future<void> _removeImage() async {
    if (_imageFile != null) {
      final localImagePath = _imageFile!.path;
      final localImageFile = File(localImagePath);
      await localImageFile.delete();
      setState(() {
        _imageFile = null;
        _uploadedImageUrl = null;
      });
    }
  }

  Future<void> _confirmUpload() async {
    await _uploadImage();
  }

  Future<void> _selectImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        _imageFile = pickedImage;
        _uploadedImageUrl = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Azure Blob Storage Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageFile != null)
              Image.file(
                File(_imageFile!.path),
                height: 200,
              ),
            if (_uploadedImageUrl != null)
              Image.network(
                _uploadedImageUrl!,
                height: 200,
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _selectImage,
              child: Text('Select Image'),
            ),
            if (_imageFile != null)
              IconButton(
                onPressed: _removeImage,
                icon: Icon(Icons.clear),
              ),
            if (_uploadedImageUrl == null && _imageFile != null)
              ElevatedButton(
                onPressed: _confirmUpload,
                child: Text('Confirm Upload'),
              ),
          ],
        ),
      ),
    );
  }
}
