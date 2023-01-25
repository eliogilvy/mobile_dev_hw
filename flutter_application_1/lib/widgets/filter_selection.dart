import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/state_info.dart';
import '../styles/styles.dart';

class DialogButton extends StatelessWidget {
  const DialogButton({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return Consumer<StateInfo>(
      builder: (context, stateInfo, child) {
        return IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  title: const Text('Update status'),
                  children: <Widget>[
                    for (String status in stateInfo.status)
                      SimpleDialogOption(
                        onPressed: () {
                          stateInfo.updateTasks(id, status);
                          Navigator.pop(context);
                        },
                        child: Text(
                          status,
                          style: Styles.taskStyle(18.0),
                        ),
                      ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
