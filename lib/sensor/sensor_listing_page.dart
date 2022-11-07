import 'package:bluetooth/adjust/adjust_page.dart';
import 'package:bluetooth/adjust/adjust_provider.dart';
import 'package:bluetooth/device/listing_page.dart';
import 'package:bluetooth/sensor/rev_counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SensorListingPage extends StatefulWidget {
  const SensorListingPage({super.key});

  @override
  State<SensorListingPage> createState() => _SensorListingPageState();
}

class _SensorListingPageState extends State<SensorListingPage> {
  int _index = 0;

  final List<String> _titles = [
    'Informações do veículo',
    'Dispositivos disponíveis',
    'Configurações',
  ];

  final List<Widget> _children = [
    Consumer<AdjustProvider>(builder: (context, provider, _) {
      return RevCounterWidget(
        maxValue: provider.revCounterMaxValue,
        currentValue: provider.currentRevCounterValue,
      );
    }),
    const DeviceListingPage(),
    const AdjustsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_index]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Informações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.devices),
            label: 'Dispositivos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: _children[_index],
      ),
    );
  }
}
