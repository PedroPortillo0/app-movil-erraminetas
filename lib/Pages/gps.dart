import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class GpsScreen extends StatefulWidget {
  @override
  _GPSLocationScreenState createState() => _GPSLocationScreenState();
}

class _GPSLocationScreenState extends State<GpsScreen> {
  String locationMessage = "Ubicación no disponible";
  Position? currentPosition;

  // Método para obtener la ubicación actual
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar si los servicios de localización están habilitados
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationMessage = "Los servicios de localización están deshabilitados.";
      });
      return;
    }

    // Verificar si los permisos están concedidos
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          locationMessage = "Permiso de ubicación denegado.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationMessage = "Los permisos de ubicación están permanentemente denegados.";
      });
      return;
    }

    // Obtener la ubicación actual
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentPosition = position;
      locationMessage =
          "Latitud: ${position.latitude}, Longitud: ${position.longitude}";
    });
  }

  // Método para abrir Google Maps con las coordenadas actuales en el navegador
  Future<void> _openGoogleMaps() async {
    if (currentPosition != null) {
      String googleMapsUrl =
          "https://www.google.com/maps/search/?api=1&query=${currentPosition!.latitude},${currentPosition!.longitude}";
      final Uri url = Uri.parse(googleMapsUrl);

      // Intentar abrir directamente la URL sin canLaunchUrl
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      setState(() {
        locationMessage = "Ubicación no disponible. Obtén la ubicación primero.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Obtener Ubicación GPS'),
        backgroundColor: Colors.blueAccent, // Color del AppBar
      ),
      backgroundColor: Colors.lightBlue[100], // Fondo de pantalla azul claro
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(locationMessage),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.black, // Color del texto del botón
              ),
              child: Text("Obtener Ubicación Actual"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _openGoogleMaps,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue, // Color del botón
              ),
              child: Text("Abrir en Google Maps"),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GpsScreen(),
  ));
}
