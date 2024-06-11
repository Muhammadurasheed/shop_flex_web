import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerWidget extends StatelessWidget {
  BannerWidget({super.key});

  final Stream<QuerySnapshot> _bannerStream =
      FirebaseFirestore.instance.collection('banners').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _bannerStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          Get.snackbar('Error', 'error occured');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.yellow.shade900,
              semanticsLabel: 'Fetching banners list',
            ),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.size,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6, mainAxisSpacing: 8, crossAxisSpacing: 8),
            itemBuilder: (context, index) {
              final _bannerData = snapshot.data!.docs[index];
              return Column(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.network(_bannerData['image']),
                  ),
                ],
              );
            });
      },
    );
  }
}
