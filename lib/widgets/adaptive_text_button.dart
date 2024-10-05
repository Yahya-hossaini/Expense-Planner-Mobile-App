import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants_and_styles.dart';

class AdaptiveTextButton extends StatelessWidget {
  final String text;
  final VoidCallback handler;

  const AdaptiveTextButton({
    super.key,
    required this.text,
    required this.handler,
  });

  // It Select A Button base on the Platform
  @override
  Widget build(BuildContext context) {

    //IOS Button
    return Platform.isIOS
        ? CupertinoButton(
      onPressed: handler,
      child: Text(
        text,
        style: kDatePickerButtonTextStyle,
      ),
    )

        //Android Button
        : TextButton(
      onPressed: handler,
      child: Text(
        text,
        style: kDatePickerButtonTextStyle,
      ),
    );
  }
}
