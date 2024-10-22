import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScreen extends StatelessWidget {
  const QrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escáner de QR'),
      ),
      body: MobileScanner(
        onDetect: (BarcodeCapture capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Código escaneado: ${barcode.rawValue}')),
            );
          }
        },
      ),
    );
  }
}
