import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner/myappbar.dart';

class ScannerPage extends StatefulWidget {
  final Function onContent;

  const ScannerPage(this.onContent, {super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    String title = 'QrCode - Scan';

    return Scaffold(
      backgroundColor: const Color.fromARGB(50, 255, 224, 178),
      appBar: MyAppBar(title: title, actions: appBarActions),
      body: mobileScanner(),
    );
  }

  mobileScanner() {
    return MobileScanner(
      allowDuplicates: false,
      controller: cameraController,
      fit: BoxFit.fill,
      onDetect: (barcode, args) {
        if (barcode.rawValue != null) {
          final String code = barcode.rawValue!;
          String type = barcode.type.toString().replaceAll("BarcodeType.", "");
          debugPrint('Barcode found! $code');

          if (code.toLowerCase().contains("br.gov.bcb.pix")) type = "PIX";

          if (code.toLowerCase().contains("http") ||
              code.toLowerCase().contains("www")) {
            type = "URL";
          }

          if (code.toLowerCase().contains("begin:vcard")) type = "CONTACTINFO";

          widget.onContent(
            code,
            type.toUpperCase(),
            true,
          );
        }
      },
    );
  }

  List<Widget> get appBarActions {
    return [
      IconButton(
        color: Colors.white,
        icon: ValueListenableBuilder(
          valueListenable: cameraController.torchState,
          builder: (context, state, child) {
            switch (state) {
              case TorchState.off:
                return const Icon(Icons.flash_off, color: Colors.white);
              case TorchState.on:
                return const Icon(Icons.flash_on, color: Colors.yellow);
            }
          },
        ),
        iconSize: 28.0,
        onPressed: () => cameraController.toggleTorch(),
      ),
      IconButton(
        color: Colors.white,
        icon: ValueListenableBuilder(
          valueListenable: cameraController.cameraFacingState,
          builder: (context, state, child) {
            switch (state) {
              case CameraFacing.front:
                return const Icon(Icons.camera_front);
              case CameraFacing.back:
                return const Icon(Icons.camera_rear);
            }
          },
        ),
        iconSize: 28.0,
        onPressed: () => cameraController.switchCamera(),
      ),
    ];
  }
}
