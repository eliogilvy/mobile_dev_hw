import 'package:flutter/material.dart';
import 'package:flutter_application_1/styles/styles.dart';
import 'package:provider/provider.dart';
import '../../classes/db_provider.dart';

class FilterTasksButton extends StatelessWidget {
  const FilterTasksButton({super.key, required this.callback});
  final Function callback;

  @override
  Widget build(BuildContext context) {
    final stateInfo = Provider.of<DBProvider>(context, listen: false);
    return Expanded(
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            stateInfo.pluralRelationships.length,
            (i) {
              return TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                    Styles.myBackground(),
                  ),
                ),
                onPressed: (() {
                  callback(relationship: stateInfo.relationshipsShortened[i]);
                }),
                child: Text(
                  stateInfo.pluralRelationships[i],
                  style: Styles.formStyle(12),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
