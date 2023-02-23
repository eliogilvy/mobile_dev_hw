import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import '../../styles/styles.dart';

class QRButton extends StatelessWidget {
  const QRButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Scan a QR code',
      onPressed: () {
        Beamer.of(context).beamToNamed('/scan');
      },
      icon: Icon(
        Icons.qr_code,
        color: Styles.buttonBackground(),
      ),
    );
  }
}
