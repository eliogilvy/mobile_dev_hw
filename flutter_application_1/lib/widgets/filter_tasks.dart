import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/app_provider.dart';
import 'package:provider/provider.dart';
import 'styles/styles.dart';

class Filter extends StatelessWidget {
  const Filter({super.key, required this.callback});
  final Function callback;

  @override
  Widget build(BuildContext context) {
    var appInfo = Provider.of<AppProvider>(context);
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
                      appInfo.filterTasks("");
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
                for (String status in appInfo.status)
                  SimpleDialogOption(
                    onPressed: () {
                      appInfo.filterTasks(status);
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
