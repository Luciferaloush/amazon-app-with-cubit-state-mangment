import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../snackbar.dart';

void errorHandling({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msf']);
    case 500:
      showSnackBar(context, jsonDecode(response.body)['msf']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}
