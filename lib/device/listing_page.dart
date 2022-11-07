import 'package:bluetooth/device/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

class DeviceListingPage extends StatefulWidget {
  const DeviceListingPage({super.key});

  @override
  State<DeviceListingPage> createState() => _DeviceListingPageState();
}

class _DeviceListingPageState extends State<DeviceListingPage> {
  final flutterBlue = FlutterBlue.instance;

  List<ScanResult> scanResults = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    listenDevices();
  }

  Future<void> listenDevices() async {
    await Permission.bluetooth.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
    setState(() {
      loading = true;
    });
    flutterBlue.startScan(timeout: const Duration(seconds: 10));
    flutterBlue.scanResults.listen((results) {
      setState(() {
        scanResults = results;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Column(
            children: const [
              Text('Procurando por dispositivos...'),
              CircularProgressIndicator(),
            ],
          )
        : ListView(
            children: scanResults
                .map(
                  (result) => ListTile(
                    title: Text(
                      result.device.name.isEmpty
                          ? 'Dispositivo desconhecido ${scanResults.indexOf(result)}'
                          : result.device.name,
                    ),
                    subtitle: Text(result.device.id.toString()),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DeviceDetailsPage(
                          device: result.device,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          );
  }
}
