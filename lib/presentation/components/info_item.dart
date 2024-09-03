import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String value;
  const InfoItem({
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    var _sizeWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: _sizeWidth * .06,
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: _sizeWidth * .04,
          ),
        ),
      ],
    );
  }
}
