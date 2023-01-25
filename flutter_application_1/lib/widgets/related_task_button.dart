import 'package:flutter/material.dart';
import 'package:flutter_application_1/styles/styles.dart';
import 'package:provider/provider.dart';
import '../classes/state_info.dart';

class RelatedTaskButton extends StatelessWidget {
  const RelatedTaskButton({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return Consumer<StateInfo>(
      builder: (context, stateInfo, child) {
        return Expanded(
          child: Align(
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                (i) {
                  return TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                        Styles.myBackground(),
                      ),
                    ),
                    onPressed: (() {
                      stateInfo.setFilter(id, stateInfo.relationships[i]);
                    }),
                    child: Text(
                      stateInfo
                          .getPluralRelationship(stateInfo.relationships[i])!,
                      style: Styles.formStyle(12),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
