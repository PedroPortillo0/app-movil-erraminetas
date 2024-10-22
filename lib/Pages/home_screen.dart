import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  // Función para abrir el enlace del repositorio en el navegador
  void _launchURL() async {
    const url = 'https://github.com/VeroVelas/funcionalidades.git';  // Cambia este URL por el de tu repositorio
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir el enlace $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información del Alumno'),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Logo en el centro
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo.jpg'),
                  radius: 80,  // Tamaño del logo
                ),
              ),
              SizedBox(height: 20),

              // Información del alumno
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Verónica Velasco Jiménez',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Matrícula: 221224',
                        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Carrera: Ingeniería en Software',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Materia: Programación Móvil',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Grupo: A',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Lista de opciones con botones estilizados
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.code, color: Colors.redAccent),
                      title: Text('Ver Repositorio'),
                      onTap: _launchURL,
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.chat, color: Colors.redAccent),
                      title: Text('Ir al Chatbot'),
                      onTap: () {
                        Navigator.pushNamed(context, '/chat');
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.gps_fixed, color: Colors.redAccent),
                      title: Text('Ver Ubicación Actual'),
                      onTap: () {
                        Navigator.pushNamed(context, '/gps');
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.qr_code_scanner, color: Colors.redAccent),
                      title: Text('Escanear Código QR'),
                      onTap: () {
                        Navigator.pushNamed(context, '/qr');
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.mic, color: Colors.redAccent),
                      title: Text('Grabar con Micrófono'),
                      onTap: () {
                        Navigator.pushNamed(context, '/micro');
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.sensors, color: Colors.redAccent),
                      title: Text('Ver Sensores'),
                      onTap: () {
                        Navigator.pushNamed(context, '/sensores');
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.record_voice_over, color: Colors.redAccent),
                      title: Text('Text to Speech'),
                      onTap: () {
                        Navigator.pushNamed(context, '/text_to_speech');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
