
import 'package:flutter/material.dart';

const Color primaryColor = Colors.purple;

const TextStyle kDatePickerButtonTextStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.bold,
);

const TextStyle kAddTransactionTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

Decoration kFirstStackChildBoxDecoration = BoxDecoration(
  border: Border.all(color: Colors.grey, width: 1.0),
  color: const Color.fromRGBO(220, 220, 220, 1),
  borderRadius: BorderRadius.circular(10),
);

Decoration kLastStackChildBoxDecoration = BoxDecoration(
  color: primaryColor,
  borderRadius: BorderRadius.circular(10),
);

const TextStyle kTitleMediumTextStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    fontSize: 18,
);

const TextStyle kAppBarTextStyle = TextStyle(
  fontFamily: 'OpenSans',
  fontSize: 20,
  fontWeight: FontWeight.bold,
);