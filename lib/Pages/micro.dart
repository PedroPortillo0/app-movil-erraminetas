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
  String _speechText = '';
  String _selectedLanguage = "es-MX";

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
  }

  // Inicializar la función de Speech-to-Text
  Future<void> _initializeSpeech() async {
    _speech = stt.SpeechToText();
    await _requestMicrophonePermission();
  }

  // Pedir permisos de micrófono
  Future<void> _requestMicrophonePermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      await Permission.microphone.request();
    }
  }

  // Iniciar la grabación de voz
  Future<void> _startListening() async {
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          if (val == 'done') {
            _stopListening();
          }
        },
        onError: (val) => print('Error: $val'),
      );

      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) {
            setState(() {
              _speechText = val.recognizedWords;
            });
          },
          localeId: _selectedLanguage,
        );
      }
    } else {
      print("Permisos de micrófono denegados");
    }
  }

  // Detener la grabación de voz
  void _stopListening() {
    setState(() => _isListening = false);
    _speech.stop();
  }

  // Cambiar el idioma para la voz
  void _changeLanguage(String languageCode) {
    setState(() {
      _selectedLanguage = languageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100], // Fondo azul claro
      appBar: AppBar(
        title: Text('Grabar Texto'),
        backgroundColor: Colors.indigoAccent,
        elevation: 0, // Sin sombra
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                _speechText.isEmpty
                    ? 'Presiona el micrófono para empezar a grabar...'
                    : _speechText,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          FloatingActionButton(
            onPressed: _isListening ? _stopListening : _startListening,
            backgroundColor: _isListening ? Colors.redAccent : Colors.indigoAccent,
            child: Icon(
              _isListening ? Icons.mic_off : Icons.mic,
              size: 32.0,
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: _selectedLanguage,
              onChanged: (String? newValue) {
                _changeLanguage(newValue!);
              },
              items: <String>['en-US', 'es-MX', 'fr-FR']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text('Idioma: $value'),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
