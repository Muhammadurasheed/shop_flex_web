import 'package:flutter/material.dart';
import 'package:shop_flex_web_admin/views/screens/sidebar_screens/widgets/row_headers.dart';

class WithdrawalScreen extends StatelessWidget {
  const WithdrawalScreen({super.key});
  static const String routeName = 'withdrawalScreen';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Withdrawal',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Row(
            children: [
              RowHeaders(flex: 1, text: 'Name'),
              RowHeaders(flex: 3, text: 'Amount'),
              RowHeaders(flex: 2, text: 'Bank Name'),
              RowHeaders(flex: 2, text: 'Bank Acount'),
              RowHeaders(flex: 1, text: 'Email'),
              RowHeaders(flex: 1, text: 'Phone'),
            ],
          ),
        ],
      ),
    );
  }
}
