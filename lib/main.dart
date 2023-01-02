import 'package:flutter/material.dart';
import 'package:qr_scanner/scanner.dart';
import 'package:qr_scanner/content.dart';
import 'package:qr_scanner/history.dart';
import 'package:localstore/localstore.dart';
import 'package:qr_scanner/qrcode.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QrCode',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'QrCode'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _value = "";
  String _type = "";
  int _index = 0;

  void onTabTapped(int index) {
    setState(() {
      _index = index;
      if (index == 0) _value = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      bottomNavigationBar: navigationBar(),
      body: body(),
    );
    return scaffold;
  }

  navigationBar() {
    final List<BottomNavigationBarItem> items = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.qr_code),
        label: 'Scan',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.content_paste),
        label: 'Content',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.history),
        label: 'History',
      ),
    ];
    return BottomNavigationBar(
      onTap: onTabTapped,
      items: items,
      fixedColor: Colors.blue,
      currentIndex: _index,
    );
  }

  body() {
    if (_index == 0) return ScannerPage(onContent);
    if (_index == 1) return ContentPage(_value, _type);
    if (_index == 2) return HistoryPage(onContent);
  }

  onContent(String code, String type, bool newItem) async {
    if (_value == code) return;

    //if from Scan - Save new item on history
    if (newItem) {
      final db = Localstore.instance;
      final id = db.collection('history').doc().id;

      final now = DateTime.now();
      final item = QrCode(
        id: id,
        title: code,
        type: type,
        time: now,
      );
      item.save();
    }

    setState(() {
      _value = code;
      _type = type;
      _index = 1;
    });
  }
}
