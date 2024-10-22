import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class MicroScreen extends StatefulWidget {
  @override
  _MicroScreenState createState() => _MicroScreenState();
}

class _MicroScreenState extends State<MicroScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  bool _speechEnabled = false;
  String _statusMessage = '';
  TextEditingController _textController = TextEditingController();
  String _localeId = 'es_ES'; // Puedes cambiarlo a 'es_MX' si prefieres

  @override
  void initState() {
    super.initState();
    _requestMicrophonePermission(); // Pedir permiso para el micrófono
    _initSpeech();
  }

  // Pedir permisos de micrófono
  Future<void> _requestMicrophonePermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      await Permission.microphone.request();
    }
  }

  // Inicializar el reconocimiento de voz
  void _initSpeech() async {
    _speech = stt.SpeechToText();
    bool available = await _speech.initialize(
      onStatus: (val) {
        setState(() {
          _statusMessage = 'Estado: $val';
        });
        print('onStatus: $val');
      },
      onError: (val) {
        setState(() {
          _statusMessage = 'Error: $val';
        });
        print('onError: $val');
      },
    );
    
    // Obtener los idiomas soportados
    var locales = await _speech.locales();
    print('Idiomas soportados: $locales');

    setState(() {
      _speechEnabled = available;
      if (!available) {
        _statusMessage = 'Reconocimiento de voz no disponible';
      }
    });
  }

  // Función para iniciar o detener el reconocimiento de voz
  void _listen() async {
    if (_speechEnabled && !_isListening) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (val) => setState(() {
          _textController.text = val.recognizedWords;
        }),
        localeId: _localeId,  // Establecer el idioma
        listenFor: Duration(seconds: 10),  // Escucha por un máximo de 10 segundos
        pauseFor: Duration(seconds: 5),    // Pausa el reconocimiento después de 5 segundos de silencio
        onDevice: true,                    // Forzar el reconocimiento en dispositivo
      );
    } else if (_isListening) {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  // Limpiar el campo de texto
  void _clearText() {
    setState(() {
      _textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reconocimiento de Voz'),
      ),
      backgroundColor: _isListening ? Colors.green[100] : Colors.red[100],  // Cambia el color de fondo
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Texto reconocido',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  onPressed: _speechEnabled ? _listen : null,
                  backgroundColor: _isListening ? Colors.green : Colors.red,  // Cambia el color del botón
                  child: Icon(_isListening ? Icons.mic : Icons.mic_none),
                ),
                ElevatedButton(
                  onPressed: _clearText,
                  child: Text('Limpiar'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(_statusMessage),
          ],
        ),
      ),
    );
  }
}
