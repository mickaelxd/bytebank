import 'package:flutter/material.dart';

class CenteredMessage extends StatelessWidget {
  final String message;
  final IconData? icon;
  final double iconSize;
  final double fontSize;

  CenteredMessage({
    required this.message,
    this.iconSize = 64,
    this.fontSize = 24,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Visibility(
            child: Icon(
              icon,
              size: iconSize,
            ),
            visible: icon != null,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Text(
              message,
              style: TextStyle(fontSize: fontSize),
            ),
          ),
        ],
      ),
    );
  }
}
