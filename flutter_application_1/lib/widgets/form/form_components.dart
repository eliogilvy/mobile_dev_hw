import 'package:flutter/material.dart';

import '../../styles/styles.dart';

class FormComponents {
  static String? _validate(value) {
    if (value == "") {
      return 'Please enter some text';
    }
    return null;
  }

  static Widget buildTitle(titleController) {
    return TextFormField(
      key: Key("title"),
      maxLength: 25,
      validator: (value) => _validate(value),
      autocorrect: true,
      textCapitalization: TextCapitalization.words,
      style: Styles.formStyle(Styles.formSize()),
      decoration: Styles.myFormStyle('Title'),
      controller: titleController,
    );
  }

  static Widget buildDesc(descController) {
    return TextFormField(
      key: Key("desc"),
      maxLength: 250,
      validator: ((value) => _validate(value)),
      autocorrect: true,
      textCapitalization: TextCapitalization.sentences,
      style: Styles.formStyle(Styles.formSize()),
      decoration: Styles.myFormStyle('Description'),
      keyboardType: TextInputType.multiline,
      controller: descController,
      maxLines: 5,
    );
  }

  static Widget buildDropdown(BuildContext context, selected,
      List<String> items, String hint, Function callback) {
    return DropdownButtonFormField(
      key: Key("dropdown"),
      style: Styles.formStyle(18),
      dropdownColor: Styles.myBackground(),
      hint: Text(
        hint,
        style: Styles.formStyle(Styles.formSize()),
      ),
      value: selected,
      onChanged: (value) {
        callback(value);
      },
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: Styles.formStyle(18.0),
          ),
        );
      }).toList(),
    );
  }
}
