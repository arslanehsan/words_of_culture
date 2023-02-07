import 'package:flutter/material.dart';

showAlertDialog({
  required BuildContext context,
  required String label,
  required String title,
  required Function function,
}) {
  // set up the button
  Widget okButton = TextButton(
    onPressed: () {
      function();
      Navigator.pop(context);
    },
    child: const Text("Confirm"),
  );

  // set up the Cancel button
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(label),
    actions: [
      okButton,
      cancelButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
