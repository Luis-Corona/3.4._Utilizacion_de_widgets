import 'package:flutter/material.dart';
import 'pokemon_screen.dart';

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
              child: Text(
                'Ver Pokémon desde API',
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
