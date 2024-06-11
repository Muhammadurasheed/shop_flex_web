import 'package:flutter/material.dart';

class RowHeaders extends StatelessWidget {
  const RowHeaders({super.key, required this.flex, required this.text});

  final String text;
  final int flex;

  //   Widget buildRowHeaders (String text, int flex) {
  //     return Expanded(
  //       flex:  flex,
  //     child: Container(
  //       decoration: BoxDecoration(
  //         border: Border.all(color: Colors.yellow.shade900),
  //       ),
  //       child: Text(text),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
           color: Colors.yellow.shade900,
          border: Border.all(color: Colors.grey.shade700,),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
