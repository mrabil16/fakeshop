import 'package:flutter/material.dart';

class SeparatorWidget extends StatelessWidget {
  final double? height;

  SeparatorWidget({Key? key, this.height = 16});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: height!),
      height: 1,
      color: Colors.grey[300],
    );
  }
}
