// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';



void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

String? token = '';
String? lan = 'ar';

List<String> favoriteList = [];
