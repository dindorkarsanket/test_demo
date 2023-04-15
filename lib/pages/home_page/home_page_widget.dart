import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;
  // XFile? _imageFile;
  final url = 'https://holainnstorage.blob.core.windows.net/';
  String? _uploadedImageUrl;
  String? _fileName =
      'https://holainnstorage.blob.core.windows.net/holainncontainer/IMG_20230402_164923.jpg';

  // Future<Object> _uploadImage(hotelID, imagenumber, _imagefileone) async {
  //   print("a");
  //   if (_imagefileone != null) {
  //     print("b");
  //     final imageBytes = await _imagefileone[0]!.bytes;
  //     final fileName = _imagefileone![0]
  //         .storagePath
  //         .toString(); //hotelID + "_" + imagenumber
  //     final uploadedImagePath = 'images/$fileName';

  //     const containerName = 'holainncontainer';
  //     const sasToken =
  //         '?sv=2021-12-02&ss=bfqt&srt=o&sp=rwdlacupiytfx&se=2024-04-05T00:34:20Z&st=2023-04-04T16:34:20Z&spr=https&sig=9y0rprNcbcVYSZQX9SjKS6Vhctnu0R0IP5Kk2irvs5Q%3D';
  //     final uploadUrl = '$url$containerName/$fileName$sasToken';
  //     print(uploadUrl);
  //     final httpClient = HttpClient();
  //     final request = await httpClient.putUrl(Uri.parse(uploadUrl));
  //     request.headers.set('x-ms-blob-type', 'BlockBlob');
  //     request.headers.set('Content-Length', imageBytes.length.toString());
  //     request.add(imageBytes);
  //     final response = await request.close();
  //     print(response.statusCode);
  //     if (response.statusCode == 201) {
  //       print("e");
  //       final uploadedImageUrl =
  //           '$url$containerName/$uploadedImagePath$sasToken';
  //       print(uploadedImageUrl);
  //       setState(() {
  //         _uploadedImageUrl = uploadedImageUrl;
  //       });
  //     }
  //     return url.toString() + fileName.toString();
  //   }
  //   return "";
  // }

  Future<String> _uploadImage(hotelID, imagenumber, _imagefileone) async {
    if (_imagefileone != null) {
      final imageBytes = await _imagefileone[0]!.bytes;
      final fileName = hotelID.toString() +
          imagenumber.toString() +
          ".jpg"; //_imagefileone![0].storagePath.toString();
      final uploadedImagePath = 'images/$fileName';

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
        final uploadedImageUrl =
            '$url$containerName/$uploadedImagePath$sasToken';
        setState(() {
          _uploadedImageUrl = uploadedImageUrl;
        });
        return url.toString() + fileName.toString();
      }
    }
    return '';
  }

  // Future<void> _confirmUpload() async {
  //   await _uploadImage();
  // }

  // Future<void> _selectImage() async {
  //   final imagePicker = ImagePicker();
  //   final pickedImage = await imagePicker.pickImage(
  //     source: ImageSource.gallery,
  //   );
  //   if (pickedImage != null) {
  //     setState(() {
  //       _imageFile = pickedImage;
  //       _uploadedImageUrl = null;
  //     });
  //   }
  // }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0.0, -0.1),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          15.0, 15.0, 15.0, 15.0),
                      child: GridView(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 1.0,
                        ),
                        scrollDirection: Axis.vertical,
                        children: [
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 10.0, 10.0, 10.0),
                              child: InkWell(
                                onTap: () async {
                                  final selectedMedia =
                                      await selectMediaWithSourceBottomSheet(
                                    context: context,
                                    allowPhoto: true,
                                  );
                                  if (selectedMedia != null &&
                                      selectedMedia.every((m) =>
                                          validateFileFormat(
                                              m.storagePath, context))) {
                                    setState(() async {
                                      _fileName = await _uploadImage(
                                              "H76", "image1", selectedMedia)
                                          .toString();
                                    });
                                  }
                                },
                                child: Image.network(
                                  _fileName.toString(),
                                  width: double.infinity,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 10.0, 10.0, 10.0),
                              child: InkWell(
                                onTap: () async {
                                  final selectedMedia =
                                      await selectMediaWithSourceBottomSheet(
                                    context: context,
                                    allowPhoto: true,
                                  );
                                  if (selectedMedia != null &&
                                      selectedMedia.every((m) =>
                                          validateFileFormat(
                                              m.storagePath, context))) {
                                    setState(
                                        () => _model.isDataUploading2 = true);
                                    var selectedUploadedFiles =
                                        <FFUploadedFile>[];

                                    try {
                                      selectedUploadedFiles = selectedMedia
                                          .map((m) => FFUploadedFile(
                                                name: m.storagePath
                                                    .split('/')
                                                    .last,
                                                bytes: m.bytes,
                                                height: m.dimensions?.height,
                                                width: m.dimensions?.width,
                                              ))
                                          .toList();
                                    } finally {
                                      _model.isDataUploading2 = false;
                                    }
                                    if (selectedUploadedFiles.length ==
                                        selectedMedia.length) {
                                      setState(() {
                                        _model.uploadedLocalFile2 =
                                            selectedUploadedFiles.first;
                                      });
                                    } else {
                                      setState(() {});
                                      return;
                                    }
                                  }
                                },
                                child: Image.asset(
                                  'assets/images/png-transparent-scalable-graphics-computer-icons-upload-uploading-cdr-angle-text.png',
                                  width: double.infinity,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 10.0, 10.0, 10.0),
                              child: InkWell(
                                onTap: () async {
                                  final selectedMedia =
                                      await selectMediaWithSourceBottomSheet(
                                    context: context,
                                    allowPhoto: true,
                                  );
                                  if (selectedMedia != null &&
                                      selectedMedia.every((m) =>
                                          validateFileFormat(
                                              m.storagePath, context))) {
                                    setState(
                                        () => _model.isDataUploading3 = true);
                                    var selectedUploadedFiles =
                                        <FFUploadedFile>[];

                                    try {
                                      selectedUploadedFiles = selectedMedia
                                          .map((m) => FFUploadedFile(
                                                name: m.storagePath
                                                    .split('/')
                                                    .last,
                                                bytes: m.bytes,
                                                height: m.dimensions?.height,
                                                width: m.dimensions?.width,
                                              ))
                                          .toList();
                                    } finally {
                                      _model.isDataUploading3 = false;
                                    }
                                    if (selectedUploadedFiles.length ==
                                        selectedMedia.length) {
                                      setState(() {
                                        _model.uploadedLocalFile3 =
                                            selectedUploadedFiles.first;
                                      });
                                    } else {
                                      setState(() {});
                                      return;
                                    }
                                  }
                                },
                                child: Image.asset(
                                  'assets/images/png-transparent-scalable-graphics-computer-icons-upload-uploading-cdr-angle-text.png',
                                  width: double.infinity,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 10.0, 10.0, 10.0),
                              child: InkWell(
                                onTap: () async {
                                  final selectedMedia =
                                      await selectMediaWithSourceBottomSheet(
                                    context: context,
                                    allowPhoto: true,
                                  );
                                  if (selectedMedia != null &&
                                      selectedMedia.every((m) =>
                                          validateFileFormat(
                                              m.storagePath, context))) {
                                    setState(
                                        () => _model.isDataUploading4 = true);
                                    var selectedUploadedFiles =
                                        <FFUploadedFile>[];

                                    try {
                                      selectedUploadedFiles = selectedMedia
                                          .map((m) => FFUploadedFile(
                                                name: m.storagePath
                                                    .split('/')
                                                    .last,
                                                bytes: m.bytes,
                                                height: m.dimensions?.height,
                                                width: m.dimensions?.width,
                                              ))
                                          .toList();
                                    } finally {
                                      _model.isDataUploading4 = false;
                                    }
                                    if (selectedUploadedFiles.length ==
                                        selectedMedia.length) {
                                      setState(() {
                                        _model.uploadedLocalFile4 =
                                            selectedUploadedFiles.first;
                                      });
                                    } else {
                                      setState(() {});
                                      return;
                                    }
                                  }
                                },
                                child: Image.asset(
                                  'assets/images/png-transparent-scalable-graphics-computer-icons-upload-uploading-cdr-angle-text.png',
                                  width: double.infinity,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 10.0, 10.0, 10.0),
                              child: InkWell(
                                onTap: () async {
                                  final selectedMedia =
                                      await selectMediaWithSourceBottomSheet(
                                    context: context,
                                    allowPhoto: true,
                                  );
                                  if (selectedMedia != null &&
                                      selectedMedia.every((m) =>
                                          validateFileFormat(
                                              m.storagePath, context))) {
                                    setState(
                                        () => _model.isDataUploading5 = true);
                                    var selectedUploadedFiles =
                                        <FFUploadedFile>[];

                                    try {
                                      selectedUploadedFiles = selectedMedia
                                          .map((m) => FFUploadedFile(
                                                name: m.storagePath
                                                    .split('/')
                                                    .last,
                                                bytes: m.bytes,
                                                height: m.dimensions?.height,
                                                width: m.dimensions?.width,
                                              ))
                                          .toList();
                                    } finally {
                                      _model.isDataUploading5 = false;
                                    }
                                    if (selectedUploadedFiles.length ==
                                        selectedMedia.length) {
                                      setState(() {
                                        _model.uploadedLocalFile5 =
                                            selectedUploadedFiles.first;
                                      });
                                    } else {
                                      setState(() {});
                                      return;
                                    }
                                  }
                                },
                                child: Image.asset(
                                  'assets/images/png-transparent-scalable-graphics-computer-icons-upload-uploading-cdr-angle-text.png',
                                  width: double.infinity,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 10.0, 10.0, 10.0),
                              child: InkWell(
                                onTap: () async {
                                  final selectedMedia =
                                      await selectMediaWithSourceBottomSheet(
                                    context: context,
                                    allowPhoto: true,
                                  );
                                  if (selectedMedia != null &&
                                      selectedMedia.every((m) =>
                                          validateFileFormat(
                                              m.storagePath, context))) {
                                    setState(
                                        () => _model.isDataUploading6 = true);
                                    var selectedUploadedFiles =
                                        <FFUploadedFile>[];

                                    try {
                                      selectedUploadedFiles = selectedMedia
                                          .map((m) => FFUploadedFile(
                                                name: m.storagePath
                                                    .split('/')
                                                    .last,
                                                bytes: m.bytes,
                                                height: m.dimensions?.height,
                                                width: m.dimensions?.width,
                                              ))
                                          .toList();
                                    } finally {
                                      _model.isDataUploading6 = false;
                                    }
                                    if (selectedUploadedFiles.length ==
                                        selectedMedia.length) {
                                      setState(() {
                                        _model.uploadedLocalFile6 =
                                            selectedUploadedFiles.first;
                                      });
                                    } else {
                                      setState(() {});
                                      return;
                                    }
                                  }
                                },
                                child: Image.asset(
                                  'assets/images/png-transparent-scalable-graphics-computer-icons-upload-uploading-cdr-angle-text.png',
                                  width: double.infinity,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 10.0, 10.0, 10.0),
                              child: InkWell(
                                onTap: () async {
                                  final selectedMedia =
                                      await selectMediaWithSourceBottomSheet(
                                    context: context,
                                    allowPhoto: true,
                                  );
                                  if (selectedMedia != null &&
                                      selectedMedia.every((m) =>
                                          validateFileFormat(
                                              m.storagePath, context))) {
                                    setState(
                                        () => _model.isDataUploading7 = true);
                                    var selectedUploadedFiles =
                                        <FFUploadedFile>[];

                                    try {
                                      selectedUploadedFiles = selectedMedia
                                          .map((m) => FFUploadedFile(
                                                name: m.storagePath
                                                    .split('/')
                                                    .last,
                                                bytes: m.bytes,
                                                height: m.dimensions?.height,
                                                width: m.dimensions?.width,
                                              ))
                                          .toList();
                                    } finally {
                                      _model.isDataUploading7 = false;
                                    }
                                    if (selectedUploadedFiles.length ==
                                        selectedMedia.length) {
                                      setState(() {
                                        _model.uploadedLocalFile7 =
                                            selectedUploadedFiles.first;
                                      });
                                    } else {
                                      setState(() {});
                                      return;
                                    }
                                  }
                                },
                                child: Image.asset(
                                  'assets/images/png-transparent-scalable-graphics-computer-icons-upload-uploading-cdr-angle-text.png',
                                  width: double.infinity,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 100.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: FFButtonWidget(
                  onPressed: () {
                    print('Button pressed ...');
                  },
                  text: 'Button',
                  options: FFButtonOptions(
                    width: 130.0,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
