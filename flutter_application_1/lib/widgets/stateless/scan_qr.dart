import 'dart:convert';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import '../../classes/db_provider.dart';
import '../../classes/task.dart';

class ScanQR extends StatelessWidget {
  ScanQR({super.key});
  bool scan = true;

  @override
  Widget build(BuildContext context) {
    var stateInfo = Provider.of<DBProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Scan a task!')),
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          child: MobileScanner(
            controller: MobileScannerController(
              facing: CameraFacing.back,
            ),
            onDetect: (capture) {
              if (scan) {
                final List<Barcode> barcodes = capture.barcodes;
                Map map = jsonDecode(barcodes.first.rawValue!);
                Task task = Task.fromMap(map);
                stateInfo.addTask([task, 'local']);
                Beamer.of(context).beamBack();
              }
              scan = false;
            },
          ),
        ),
      ),
    );
  }
}
