import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shop_flex_web_admin/views/screens/sidebar_screens/widgets/banner_widget.dart';

class UploadBannerScreen extends StatefulWidget {
  const UploadBannerScreen({super.key});
  static const String routeName = 'routeName';

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseStorage _storage = FirebaseStorage.instance;

  dynamic _imageFile;

  String? fileName;

  _uploadBannerToStorage(dynamic image) async {
    Reference ref = _storage.ref().child('Banners').child(fileName!);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String bannerDownloadUrl = await taskSnapshot.ref.getDownloadURL();
    return bannerDownloadUrl;
  }

  _uploadToFirestoreDatabase() async {
    try {
      if (_imageFile != null) {
        EasyLoading.show(status: 'uploading');
        // EasyLoading.showProgress(0.3, status: 'uploading...');
        String imageURL = await _uploadBannerToStorage(_imageFile);
        await _firestore
            .collection('banners')
            .doc(fileName)
            .set({'image': imageURL}).whenComplete(() {
          EasyLoading.showSuccess('uploaded successfully');
          setState(() {
            _imageFile = null;
          });
        });
      } else {
        return Get.snackbar('Error', 'Pick an image');
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  _pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);
    if (result != null) {
      setState(() {
        _imageFile = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Banners',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade900),
                      ),
                      child: _imageFile != null
                          ? Image.memory(
                              _imageFile,
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Text('Banner'),
                            ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _pickFile();
                      },
                      child: Text(
                        'Upload banners',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow.shade900),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  _uploadToFirestoreDatabase();
                },
                child: Text(
                  'save',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow.shade900),
              ),
            ],
          ),
          Divider(
            color: Colors.grey,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Banners',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
          BannerWidget(),
        ],
      ),
    );
  }
}
