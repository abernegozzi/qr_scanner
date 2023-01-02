import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class MyFooter extends StatelessWidget implements PreferredSizeWidget {
  final double height = 52.0;

  @override
  Size get preferredSize => Size.fromHeight(height);
  final String title;
  final String type;

  const MyFooter({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _callPhone(title),
        _mailTo(title),
        _addContact(title),
        _maps(title),
        _sms(title),
        _launchUrl(title, type),
        _copyClipboard(context, title),
        _share(title),
      ],
    );
  }

  Widget _callPhone(String phone) {
    bool validURL = phone.toUpperCase().contains("TEL:");

    if (validURL) {
      validURL = !phone.toUpperCase().contains("VCARD");
    }

    return Visibility(
      visible: validURL,
      child: IconButton(
        icon: const Icon(
          Icons.call,
          color: Colors.red,
        ),
        onPressed: () async {
          try {
            await launchUrl(Uri.parse(phone));
          } catch (e) {
            print(phone);
          }
        },
      ),
    );
  }

  Widget _mailTo(String email) {
    bool validURL = email.toUpperCase().contains("MAILTO:");

    if (validURL) {
      validURL = !email.toUpperCase().contains("VCARD");
    }

    return Visibility(
      visible: validURL,
      child: IconButton(
        icon: const Icon(
          Icons.email,
          color: Colors.red,
        ),
        onPressed: () async {
          try {
            await launchUrl(Uri.parse(email));
          } catch (e) {
            print(email);
          }
        },
      ),
    );
  }

  Widget _addContact(String vcard) {
    bool validURL = vcard.toUpperCase().contains("VCARD");

    return Visibility(
      visible: validURL,
      child: IconButton(
        icon: const Icon(
          Icons.call,
          color: Colors.red,
        ),
        onPressed: () async {
          try {
            await launchUrl(Uri.parse(vcard));
          } catch (e) {
            print(vcard);
          }
        },
      ),
    );
  }

  Widget _maps(String geo) {
    bool validURL = geo.toUpperCase().contains("GEO:");

    return Visibility(
      visible: validURL,
      child: IconButton(
        icon: const Icon(
          Icons.location_on,
          color: Colors.red,
        ),
        onPressed: () async {
          try {
            await launchUrl(Uri.parse(geo));
          } catch (e) {
            print(geo);
          }
        },
      ),
    );
  }

  Widget _sms(String sms) {
    bool validURL = sms.toUpperCase().contains("SMSTO:");

    return Visibility(
      visible: validURL,
      child: IconButton(
        icon: const Icon(
          Icons.sms,
          color: Colors.red,
        ),
        onPressed: () async {
          try {
            await launchUrl(Uri.parse(sms));
          } catch (e) {
            print(sms);
          }
        },
      ),
    );
  }

  Widget _launchUrl(String link, String type) {
    bool validURL = type == "URL"; //Uri.parse(link).isAbsolute;

    if (validURL) {
      validURL = (link.toLowerCase().contains("http") ||
          link.toLowerCase().contains("www"));
    }

    return Visibility(
      visible: validURL,
      child: IconButton(
        icon: const Icon(
          Icons.language,
          color: Colors.red,
        ),
        onPressed: () async {
          try {
            await launchUrl(Uri.parse(link));
          } catch (e) {
            print(link);
          }
        },
      ),
    );
  }

  Widget _copyClipboard(BuildContext context, String text) {
    return IconButton(
      icon: const Icon(
        Icons.copy,
        color: Colors.red,
      ),
      onPressed: () async {
        Clipboard.setData(ClipboardData(text: text));
        _showToast(context, "Content copied to clipboard");
      },
    );
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        // action: SnackBarAction(
        //     label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  Widget _share(String text) {
    return IconButton(
      icon: const Icon(
        Icons.share,
        color: Colors.red,
      ),
      onPressed: () {
        Share.share(text);
      },
    );
  }
}
