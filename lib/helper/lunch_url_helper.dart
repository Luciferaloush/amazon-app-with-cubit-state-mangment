// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
//
// //============> this function will we use to lunch link in browser
// Future<void> launchInBrowser(Uri url) async {
//   if (!await launchUrl(
//     url,
//     mode: LaunchMode.externalApplication,
//   )) {
//     throw Exception('Could not launch $url');
//   }
// }
// Future<void> launchPhoneNumber(Uri url) async {
//   if (!await launchUrl(
//       url)) {
//     throw Exception(
//         'Could not launch $url');
//   }
// }
//
// Future<void> launchInWebViewOrVC(Uri url) async {
//   if (!await launchUrl(
//     url,
//     mode: LaunchMode.inAppWebView,
//     webViewConfiguration: const WebViewConfiguration(
//         headers: <String, String>{'my_header_key': 'my_header_value'}),
//   )) {
//     throw Exception('Could not launch $url');
//   }
// }
//
// Future<void> launchInWebViewWithoutJavaScript(Uri url) async {
//   if (!await launchUrl(
//     url,
//     mode: LaunchMode.inAppWebView,
//     webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
//   )) {
//     throw Exception('Could not launch $url');
//   }
// }
//
// Future<void> launchInWebViewWithoutDomStorage(Uri url) async {
//   if (!await launchUrl(
//     url,
//     mode: LaunchMode.inAppWebView,
//     webViewConfiguration: const WebViewConfiguration(enableDomStorage: false),
//   )) {
//     throw Exception('Could not launch $url');
//   }
// }
//
// Future<void> launchUniversalLinkIos(Uri url) async {
//   final bool nativeAppLaunchSucceeded = await launchUrl(
//     url,
//     mode: LaunchMode.externalNonBrowserApplication,
//   );
//   if (!nativeAppLaunchSucceeded) {
//     await launchUrl(
//       url,
//       mode: LaunchMode.inAppWebView,
//     );
//   }
// }
//
// Widget launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
//   if (snapshot.hasError) {
//     return Text('Error: ${snapshot.error}');
//   } else {
//     return const Text('');
//   }
// }
