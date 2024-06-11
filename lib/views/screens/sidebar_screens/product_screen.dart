import 'package:flutter/material.dart';
import 'package:shop_flex_web_admin/views/screens/sidebar_screens/widgets/row_headers.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});
  static const String routeName = 'productScreen';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Manage Products',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
            ),
              Row(
            children: [
              RowHeaders(flex: 1, text: 'Image'),
              RowHeaders(flex: 3, text: 'Name'),
              RowHeaders(flex: 2, text: 'Price'),
              RowHeaders(flex: 2, text: 'Quantity'),
              RowHeaders(flex: 1, text: 'Action'),
              RowHeaders(flex: 1, text: 'View more'),
            ],
          ),
          ],
        ),
      );
  }
}