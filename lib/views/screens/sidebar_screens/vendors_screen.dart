import 'package:flutter/material.dart';
import 'package:shop_flex_web_admin/views/screens/sidebar_screens/widgets/row_headers.dart';

class VendorsScreen extends StatelessWidget {
  const VendorsScreen({super.key});
  static const String routeName = 'vendorScreen';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Manage Vendors',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Row(
            children: [
              RowHeaders(flex: 1, text: 'Logo'),
              RowHeaders(flex: 3, text: 'Business Name'),
              RowHeaders(flex: 2, text: 'City'),
              RowHeaders(flex: 2, text: 'State'),
              RowHeaders(flex: 1, text: 'Action'),
              RowHeaders(flex: 1, text: 'View more'),
            ],
          ),
        ],
      ),
    );
  }
}
