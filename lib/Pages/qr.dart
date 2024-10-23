import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  _QrScreenState createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  String? matricula; // Variable para guardar la matrícula escaneada

  // Método que se ejecuta cuando se detecta un código QR
  void _onDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      // Verificar si el código QR contiene una matrícula
      if (barcode.rawValue != null && _isValidMatricula(barcode.rawValue!)) {
        setState(() {
          matricula = barcode.rawValue; // Guardar la matrícula escaneada
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Matrícula escaneada: $matricula')),
        );
      }
    }
  }

  // Método para validar si el QR contiene una matrícula
  bool _isValidMatricula(String qrValue) {
    // Aquí puedes agregar validaciones específicas para la matrícula
    // Por ejemplo, verificar que tenga el formato correcto
    // Vamos a asumir que es un número de 6 dígitos como ejemplo
    final matriculaPattern = RegExp(r'^\d{6}$');
    return matriculaPattern.hasMatch(qrValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escáner de QR'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: MobileScanner(
              onDetect: _onDetect,
            ),
          ),
          if (matricula != null) // Si la matrícula ha sido escaneada, mostrarla
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Matrícula escaneada: $matricula',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          if (matricula == null) // Si no hay matrícula, mostrar mensaje
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Escanea un código QR que contenga tu matrícula.',
                style: TextStyle(fontSize: 18),
              ),
            ),
        ],
      ),
    );
  }
}
