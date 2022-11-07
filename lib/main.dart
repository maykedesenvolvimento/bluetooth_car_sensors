import 'package:bluetooth/adjust/adjust_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sensor/sensor_listing_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => AdjustProvider(),
    child: const Application(),
  ));
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const SensorListingPage(),
    );
  }
}
