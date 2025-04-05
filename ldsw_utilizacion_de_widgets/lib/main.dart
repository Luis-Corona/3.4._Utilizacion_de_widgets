import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diseño de aplicaciones móviles',
      home: Scaffold(
        appBar: AppBar(title: Text('CinePedia')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Bienvenido a CinePedia, tu portal para descubrir películas',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(20),
                color: const Color.fromARGB(255, 169, 113, 214),
                child: Text(
                  'En CinePedia, te ofrecemos una experiencia única para explorar, conocer y disfrutar del cine.',
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  Icon(Icons.star, color: Colors.amber),
                  Icon(Icons.star, color: Colors.amber),
                ],
              ),

              SizedBox(height: 20), // Espacio entre Row y Stack

              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    color: const Color.fromARGB(255, 195, 150, 229),
                  ),
                  Text('Categorias', style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
