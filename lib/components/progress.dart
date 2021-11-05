import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  final String message;

  const Progress({
    this.message = 'Loading...',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(message, style: TextStyle(fontSize: 16.0)),
          ),
        ],
      ),
    );
  }
}
