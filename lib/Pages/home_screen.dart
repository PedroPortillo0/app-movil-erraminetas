import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  final String repoUrl = 'https://github.com/PedroPortillo0/app-movil-herramientas'; // URL del repositorio

  void _launchURL() async {
    final Uri url = Uri.parse(repoUrl); // Usar el URL del repositorio
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication); // Abrir en navegador externo
      } else {
        throw 'No se pudo abrir el enlace $url';
      }
    } catch (e) {
      print('Error al intentar abrir la URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información del Alumno'),
        backgroundColor: Colors.blue,
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
                        'Pedro Portillo Rodriguez',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Matrícula: 221217',
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
                      SizedBox(height: 10),
                      // Añadir el enlace del repositorio dentro de la información del alumno como texto
                      GestureDetector(
                        onTap: _launchURL,
                        child: Text(
                          repoUrl,
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline, // Subrayado para indicar que es un enlace
                            fontSize: 16,
                          ),
                        ),
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
                      leading: Icon(Icons.gps_fixed, color: Colors.blue),
                      title: Text('Ver Ubicación Actual'),
                      onTap: () {
                        Navigator.pushNamed(context, '/gps');
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.qr_code_scanner, color: Colors.blue),
                      title: Text('Escanear Código QR'),
                      onTap: () {
                        Navigator.pushNamed(context, '/qr');
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.mic, color: Colors.blue),
                      title: Text('Grabar con Micrófono'),
                      onTap: () {
                        Navigator.pushNamed(context, '/micro');
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.sensors, color: Colors.blue),
                      title: Text('Ver Sensores'),
                      onTap: () {
                        Navigator.pushNamed(context, '/sensores');
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.record_voice_over, color: Colors.blue),
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
