import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({super.key});

  final Stream<QuerySnapshot> _categoryStream =
      FirebaseFirestore.instance.collection('categories').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _categoryStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          Get.snackbar('Error', 'message');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.yellow.shade900,
              semanticsLabel: 'Fetching categories list',
            ),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.size,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6, mainAxisSpacing: 8, crossAxisSpacing: 8),
            itemBuilder: (context, index) {
              final _categoryData = snapshot.data!.docs[index];
              return Column(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.network(_categoryData['image']),
                  ),

                Text(_categoryData['categoryName'])
                ],
              );
            });
      },
    );
  }
}
