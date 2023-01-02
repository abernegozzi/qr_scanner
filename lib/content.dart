import 'package:flutter/material.dart';
import 'package:qr_scanner/myappbar.dart';
import 'package:qr_scanner/myfooter.dart';
import 'package:qr_scanner/qrcode.dart';

class ContentPage extends StatelessWidget {
  final String texto;
  final String type;

  const ContentPage(this.texto, this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    String title = 'QrCode - Content';
    List<Widget> appBarActions = [];
    return Scaffold(
        backgroundColor: const Color.fromARGB(50, 255, 224, 178),
        appBar: MyAppBar(title: title, actions: appBarActions),
        body: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: SizedBox(
                      width: 50,
                      child: QrCode.getAvatar(type),
                    ),
                    title: SizedBox(
                      height: MediaQuery.of(context).size.height * .4,
                      child: SingleChildScrollView(
                        child: Text(texto),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: const Divider(
                      color: Colors.red,
                      height: 16,
                    ),
                  ),
                  MyFooter(title: texto, type: type)
                ],
              ),
            ),
          ),
        ));
  }
}



// bool _hasCallSupport = false;
// Future<void>? _launched;
// String _phone = '';


    // Check for phone call support.
    // canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
    //   setState(() {
    //     _hasCallSupport = result;
    //   });
    // });


// Future<void> _launchInBrowser(Uri url) async {
//   if (!await launchUrl(
//     url,
//     mode: LaunchMode.externalApplication,
//   )) {
//     throw 'Could not launch $url';
//   }
// }

// Future<void> _launchInWebViewOrVC(Uri url) async {
//   if (!await launchUrl(
//     url,
//     mode: LaunchMode.inAppWebView,
//     webViewConfiguration: const WebViewConfiguration(
//         headers: <String, String>{'my_header_key': 'my_header_value'}),
//   )) {
//     throw 'Could not launch $url';
//   }
// }

// Future<void> _launchInWebViewWithoutJavaScript(Uri url) async {
//   if (!await launchUrl(
//     url,
//     mode: LaunchMode.inAppWebView,
//     webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
//   )) {
//     throw 'Could not launch $url';
//   }
// }

// Future<void> _launchInWebViewWithoutDomStorage(Uri url) async {
//   if (!await launchUrl(
//     url,
//     mode: LaunchMode.inAppWebView,
//     webViewConfiguration: const WebViewConfiguration(enableDomStorage: false),
//   )) {
//     throw 'Could not launch $url';
//   }
// }

// Future<void> _launchUniversalLinkIos(Uri url) async {
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

// Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
//   if (snapshot.hasError) {
//     return Text('Error: ${snapshot.error}');
//   } else {
//     return const Text('');
//   }
// }

// Future<void> _makePhoneCall(String phoneNumber) async {
//   final Uri launchUri = Uri(
//     scheme: 'tel',
//     path: phoneNumber,
//   );
//   await launchUrl(launchUri);
// }

// void _onClick(String value) => setState(() => _value = value);

