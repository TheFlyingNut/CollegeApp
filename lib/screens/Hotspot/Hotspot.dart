import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(Hotspot());
}

class Hotspot extends StatelessWidget {
  static const platform = MethodChannel('hotspot_channel');
  static String routeName = 'HotspotScreen';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hotspot Manager'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  String hotspotInfo = await platform.invokeMethod("turnOnHotspot");
                  print('Hotspot started: $hotspotInfo');
                },
                child: Text('Turn On Hotspot'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String connectedDevices = await platform.invokeMethod('getConnectedDevices');
                  print('Connected devices: $connectedDevices');
                },
                child: Text('Get Connected Devices'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}