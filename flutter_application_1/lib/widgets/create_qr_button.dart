import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/state_info.dart';
import '../styles/styles.dart';

class CreateQRButton extends StatelessWidget {
  const CreateQRButton({super.key});

  @override
  Widget build(BuildContext context) {
    var stateInfo = Provider.of<StateInfo>(context);
    return IconButton(
      onPressed: () {
        print('tapped');
      },
      icon: Icon(
        Icons.qr_code,
        color: Styles.buttonBackground(),
      ),
    );
  }
}
