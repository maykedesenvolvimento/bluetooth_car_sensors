import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:localstorage/localstorage.dart';

class DeviceDetailsPage extends StatefulWidget {
  final BluetoothDevice device;
  final Map<String, String> deviceNames;
  final Function(String) onChangeDeviceName;

  const DeviceDetailsPage({
    Key? key,
    required this.device,
    required this.deviceNames,
    required this.onChangeDeviceName,
  }) : super(key: key);

  @override
  State<DeviceDetailsPage> createState() => _DeviceDetailsPageState();
}

class _DeviceDetailsPageState extends State<DeviceDetailsPage> {
  final LocalStorage storage = LocalStorage('bluetooth');

  late String? deviceName;
  late bool saved;
  bool connected = false;

  void saveDeviceName() async {
    await storage.ready;
    widget.onChangeDeviceName(deviceName!);
    setState(() => saved = true);
  }

  @override
  void initState() {
    super.initState();
    deviceName = widget.deviceNames[widget.device.id.id];
    saved = deviceName != null;
    widget.device.state.listen((state) {
      setState(() {
        connected = state == BluetoothDeviceState.connected;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(saved ? deviceName! : 'Dispositivo desconhecido'),
      ),
      floatingActionButton: connected
          ? FloatingActionButton(
              onPressed: widget.device.disconnect,
              child: const Icon(Icons.bluetooth_disabled),
            )
          : FloatingActionButton(
              onPressed: widget.device.connect,
              child: const Icon(Icons.bluetooth_connected),
            ),
      extendBody: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            saved
                ? Text('Nome: $deviceName')
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nome do dispositivo',
                            ),
                            onChanged: (value) {
                              setState(() {
                                deviceName = value;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 100,
                          margin: const EdgeInsets.only(left: 10),
                          height: 60,
                          child: ElevatedButton(
                            onPressed: saveDeviceName,
                            child: const Text('Salvar'),
                          ),
                        ),
                      ],
                    ),
                  ),
            Text(widget.device.id.toString()),
            Text(widget.device.type.name),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Conectado: '),
                Text(
                  connected ? 'Sim' : 'Não',
                  style: TextStyle(
                    color: connected ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
