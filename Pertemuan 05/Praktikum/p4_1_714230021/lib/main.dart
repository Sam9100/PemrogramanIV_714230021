import 'package:flutter/material.dart';
import 'package:p4_1_714230021/model/tourism_place.dart';
import 'main_screen.dart';
import 'detail_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tempat Wisata Bandung',
      theme: ThemeData(useMaterial3: false),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DetailScreen extends StatelessWidget {
  final TourismPlace place;

  const DetailScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(place.imageAsset),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: Text(
                  place.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'Staatliches',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Icon(
                          Icons.calendar_today,
                          color: Color.fromARGB(255, 34, 107, 0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          place.openDays, // <-- DIUBAH
                          style: iniFontCustom,
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          color: Color.fromARGB(255, 34, 107, 0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          place.openTime, // <-- DIUBAH
                          style: iniFontCustom,
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Icon(
                          Icons.monetization_on,
                          color: Color.fromARGB(255, 34, 107, 0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          place.ticketPrice, // <-- DIUBAH
                          style: iniFontCustom,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  // <-- 'const' dihilangkan dari sini
                  place.description, // <-- DIUBAH
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ), // 'const' dipindah ke sini
                ),
              ),

              SizedBox(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.network(
                        'https://www.rancaupas.id/wp-content/uploads/2022/09/DSC05254-2-1024x683.jpg',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.network(
                        'https://www.rancaupas.id/wp-content/uploads/2023/08/Ranca-Upas-Igloo-Camp-Ciwidey.jpg',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.network(
                        'https://awsimages.detik.net.id/community/media/visual/2020/11/11/ranca-upas_169.jpeg?w=1200',
                      ),
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
