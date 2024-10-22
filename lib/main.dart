import 'package:flutter/material.dart';
import 'pages/home_screen.dart';
import 'pages/chat_screen.dart';
import 'pages/gps.dart';
import 'pages/qr.dart';
import 'pages/micro.dart';
import 'pages/sensores.dart';  // Importar la pantalla de sensores
import 'pages/text_to_speech.dart';  // Importar la pantalla de Text-to-Speech

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatbot App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/chat': (context) => ChatScreen(),
        '/gps': (context) => GpsScreen(),
        '/qr': (context) => QrScreen(),
        '/micro': (context) => MicroScreen(),
        '/sensores': (context) => SensoresScreen(),  // Nueva ruta para la pantalla de sensores
        '/text_to_speech': (context) => TextToSpeechScreen(),  // Nueva ruta para la pantalla de Text-to-Speech
      },
    );
  }
}
