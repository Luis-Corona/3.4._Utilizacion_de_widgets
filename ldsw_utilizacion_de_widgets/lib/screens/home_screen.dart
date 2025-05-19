import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pokemon_screen.dart';

void addDummyData() {
  FirebaseFirestore.instance.collection('peliculas').add({
    'titulo': 'Ejemplo',
    'anio': 2025,
  });
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 107, 84, 147),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Favicon.png', width: 200, height: 200),
            SizedBox(height: 20),
            Text(
              '¡Bienvenido a CinePedia!',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Tu portal para descubrir películas',
              style: TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PokemonScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Fondo azul
                foregroundColor: Colors.white, // Color del texto
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 30,
                ), // Espaciado interno
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Bordes redondeados
                ),
              ),
              child: Text('Ver Pokémon desde API'),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                addDummyData(); // Llamar a la función para agregar datos a Firestore
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Fondo verde para el botón
                foregroundColor: Colors.white, // Color del texto
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 30,
                ), // Espaciado interno
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Bordes redondeados
                ),
              ),
              child: Text('Agregar datos a Firestore'),
            ),
          ],
        ),
      ),
    );
  }
}
