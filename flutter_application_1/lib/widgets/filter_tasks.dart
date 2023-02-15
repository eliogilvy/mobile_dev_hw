import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/state_info.dart';
import '../styles/styles.dart';

class Filter extends StatelessWidget {
  const Filter({super.key, required this.callback});
  final Function callback;

  @override
  Widget build(BuildContext context) {
    var stateInfo = Provider.of<StateInfo>(context);
    return IconButton(
      icon: Icon(Icons.filter_list_alt),
      color: Styles.buttonBackground(),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filter tasks',
                  ),
                  IconButton(
                    onPressed: () {
                      stateInfo.filterTasks("");
                      callback();
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              children: <Widget>[
                for (String status in stateInfo.status)
                  SimpleDialogOption(
                    onPressed: () {
                      stateInfo.filterTasks(status);
                      callback();
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
                      callback();
                      Navigator.of(context).pop();
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
  }
}
