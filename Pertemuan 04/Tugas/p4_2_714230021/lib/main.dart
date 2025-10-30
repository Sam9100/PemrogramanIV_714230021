import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LayoutScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  Widget _buildBox({
    required String text,
    required Color color,
    required double width,
    required double height,
  }) {
    return Container(
      width: width,
      height: height,
      color: color,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tugas Pertemuan 4', style: TextStyle(fontWeight: FontWeight.bold))),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildBox(
              text: 'Box 1',
              color: Colors.blue,
              width: 300,
              height: 100,
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildBox(
                  text: 'Box 2',
                  color: Colors.red,
                  width: 100,
                  height: 200,
                ),

                const SizedBox(width: 20),

                _buildBox(
                  text: 'Box 3',
                  color: Colors.green,
                  width: 100,
                  height: 200,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
