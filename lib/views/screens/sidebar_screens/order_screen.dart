import 'package:flutter/material.dart';
import 'package:shop_flex_web_admin/views/screens/sidebar_screens/widgets/row_headers.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  static const String routeName = 'orderScreen';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Order',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Row(
            children: [
              RowHeaders(flex: 1, text: 'IMage'),
              RowHeaders(flex: 3, text: 'full Name'),
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
