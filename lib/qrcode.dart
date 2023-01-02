import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

/// Data Model
class QrCode {
  final String id;
  String title;
  String type;
  DateTime time;

  QrCode({
    required this.id,
    required this.title,
    required this.type,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory QrCode.fromMap(Map<String, dynamic> map) {
    return QrCode(
      id: map['id'],
      title: map['title'],
      type: map['type'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }

  static Container getAvatar(String type) {
    Icon icon;
    Color color;

    switch (type) {
      case 'UNKNOWN':
        icon = const Icon(Icons.qr_code);
        color = const Color(0xFF8ec641);
        break;
      case 'CONTACTINFO':
        icon = const Icon(Icons.person_add);
        color = const Color(0xFF2cb24f);
        break;
      case 'EMAIL':
        icon = const Icon(Icons.email);
        color = const Color(0xFF1a8d7c);
        break;
      case 'ISBN':
        icon = const Icon(Icons.horizontal_distribute);
        color = const Color(0xFF4165af);
        break;
      case 'PHONE':
        icon = const Icon(Icons.phone_in_talk);
        color = const Color(0xFFf05624);
        break;
      case 'PRODUCT':
        icon = const Icon(Icons.inventory_2);
        color = const Color(0xFF773191);
        break;
      case 'SMS':
        icon = const Icon(Icons.sms);
        color = const Color(0xFF9e4098);
        break;
      case 'TEXT':
        icon = const Icon(Icons.description);
        color = const Color(0xFFec1d23);
        break;
      case 'URL':
        icon = const Icon(Icons.language);
        color = const Color(0xFF665ba7);
        break;
      case 'WIFI':
        icon = const Icon(Icons.wifi);
        color = const Color(0xFFfced22);
        break;
      case 'GEO':
        icon = const Icon(Icons.location_on);
        color = const Color(0xFFf78f20);
        break;
      case 'CALENDAREVENT':
        icon = const Icon(Icons.event);
        color = const Color(0xFFfbcb09);
        break;
      case 'DRIVERLICENSE':
        icon = const Icon(Icons.time_to_leave);
        color = const Color(0xFF8ec641);
        break;
      case 'PIX':
        icon = const Icon(Icons.pix);
        color = const Color(0xFF3da79f);
        break;
      default:
        icon = const Icon(Icons.qr_code);
        color = const Color(0xFF8ec641);
        break;
    }

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.6),
            color,
          ],
        ),
      ),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        child: icon,
      ),
    );
  }
}

extension ExtQrCode on QrCode {
  Future save() async {
    final db = Localstore.instance;
    return db.collection('history').doc(id).set(toMap());
  }

  Future delete() async {
    final db = Localstore.instance;
    return db.collection('history').doc(id).delete();
  }
}
