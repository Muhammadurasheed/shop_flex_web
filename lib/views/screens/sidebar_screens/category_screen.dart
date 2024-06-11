import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shop_flex_web_admin/views/screens/sidebar_screens/widgets/category_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});
  static const String routeName = 'categoryscreen';

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseStorage _storage = FirebaseStorage.instance;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String categoryName;

  dynamic _imageFile;

  String? fileName;

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

  _uploadCategoryImageToStorage(dynamic image) async {
    if (_formKey.currentState!.validate() && _imageFile != null) {
      EasyLoading.show(status: 'uploading');
      Reference ref = _storage.ref().child('categories Image').child(fileName!);
      UploadTask uploadTask = ref.putData(image);
      TaskSnapshot snapshot = await uploadTask;
      String imageURL = await snapshot.ref.getDownloadURL();
      return imageURL;
    } else {
      Get.snackbar('Error', 'Please fill the approprite field(s)',
          colorText: Colors.white, backgroundColor: Colors.red);
      return;
    }
  }

  _uploadCategoryImageToFirestore() async {
    String imageURL = await _uploadCategoryImageToStorage(_imageFile);
    await _firestore.collection('categories').doc(fileName).set(
      {
        'image': imageURL,
        'categoryName': categoryName,
      },
    ).whenComplete(() {
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Uploaded successfully!');
      setState(() {
        _imageFile = null;
        _formKey.currentState!.reset();
      });
    });
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
              'Categories',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          Form(
            key: _formKey,
            child: Row(
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
                                child: Text('Category'),
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
                          'Upload Category',
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
                Flexible(
                  child: SizedBox(
                    width: 180,
                    child: TextFormField(
                      onChanged: (value) {
                        categoryName = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Category name must not be empty!';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Category name',
                          hintText: 'Category name'),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _uploadCategoryImageToFirestore();
                  },
                  child: Text(
                    'save',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow.shade900),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Categories',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
          CategoryWidget()
        ],
      ),
    );
  }
}
