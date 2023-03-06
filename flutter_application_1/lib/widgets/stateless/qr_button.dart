import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../styles/styles.dart';

class QRButton extends StatelessWidget {
  const QRButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Scan a QR code',
      onPressed: () {
        context.goNamed('scan');
      },
      icon: Icon(
        Icons.qr_code,
        color: Styles.buttonBackground(),
      ),
    );
  }
}
