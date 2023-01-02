import 'dart:async';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:qr_scanner/myappbar.dart';
import 'package:qr_scanner/qrcode.dart';

class HistoryPage extends StatefulWidget {
  final Function onContent;

  const HistoryPage(this.onContent, {super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _db = Localstore.instance;
  final _items = <String, QrCode>{};
  StreamSubscription<Map<String, dynamic>>? _subscription;

  @override
  void initState() {
    _subscription = _db.collection('history').stream.listen((event) {
      setState(() {
        final item = QrCode.fromMap(event);
        _items.putIfAbsent(item.id, () => item);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String title = "QrCode - History";
    return Scaffold(
      backgroundColor: const Color.fromARGB(50, 255, 224, 178),
      appBar: MyAppBar(title: title, actions: appBarActions),
      body: body(),
    );
  }

  ListView body() {
    //Sort map descending order by time
    List<MapEntry<String, QrCode>> listMappedEntries = _items.entries.toList();
    listMappedEntries.sort((a, b) => b.value.time.compareTo(a.value.time));
    final Map<String, QrCode> sortedMapData =
        Map.fromEntries(listMappedEntries);

    return ListView.builder(
      itemCount: sortedMapData.keys.length,
      itemBuilder: (context, index) {
        final key = sortedMapData.keys.elementAt(index);
        final item = sortedMapData[key]!;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: InkWell(
            onTap: () {
              widget.onContent(
                item.title,
                item.type.toUpperCase(),
                false,
              );
            },
            child: contentCard(item),
          ),
        );
      },
    );
  }

  Card contentCard(QrCode item) {
    return Card(
      child: Column(
        children: [
          listTile(item),
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: const Divider(
              color: Colors.red,
              height: 16,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.time.toIso8601String(),
                style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.normal,
                    fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListTile listTile(QrCode item) {
    return ListTile(
      leading: SizedBox(
        width: 50,
        child: QrCode.getAvatar(item.type),
      ),
      title: Text(item.title),
      trailing: IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () {
          setState(() {
            item.delete();
            _items.remove(item.id);
          });
        },
      ),
    );
  }

  List<Widget> get appBarActions {
    return [
      IconButton(
        iconSize: 28.0,
        onPressed: () {
          removeAll();
        },
        icon: const Icon(Icons.delete_outlined),
      )
    ];
  }

  void removeAll() {
    setState(() {
      _db.collection('history').delete();
      _items.clear();
    });
  }

  @override
  void dispose() {
    if (_subscription != null) _subscription?.cancel();
    super.dispose();
  }
}
