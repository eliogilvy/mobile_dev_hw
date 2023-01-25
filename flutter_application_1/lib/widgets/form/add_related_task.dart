import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/styles/styles.dart';
import 'package:flutter_application_1/widgets/form/form_components.dart';
import 'package:provider/provider.dart';

import '../../classes/state_info.dart';

class RelationshipSelect extends StatelessWidget {
  RelationshipSelect({super.key, required this.relatedId});
  final int relatedId;

  final GlobalKey<FormState> _relatedForm = GlobalKey<FormState>();
  String _selectedRelationship = "Subtask";

  void _updateRelationship(String rel) {
    _selectedRelationship = rel;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Styles.myBackground(),
      contentPadding: EdgeInsets.all(0),
      content: SizedBox(
        height: 150.0,
        child: Card(
          color: Styles.myBackground(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<StateInfo>(
              builder: (context, stateInfo, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FormComponents.buildDropdown(
                      context,
                      _selectedRelationship,
                      stateInfo.relatedTaskDropdown(),
                      "Select a relationship",
                      _updateRelationship,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Styles.buttonBackground(),
                        child: IconButton(
                          onPressed: () {
                            stateInfo.getTaskFromMap(relatedId).lastFilter =
                                _selectedRelationship;
                            Beamer.of(context).beamToNamed('/new',
                                data: [_selectedRelationship, relatedId]);
                          },
                          alignment: Alignment.center,
                          icon: Icon(
                            Icons.arrow_right_alt_rounded,
                            color: Styles.myBackground(),
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
