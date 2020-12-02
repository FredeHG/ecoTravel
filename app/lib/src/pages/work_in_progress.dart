import 'package:app/src/templates/ContentTemplate.dart';
import 'package:flutter/material.dart';

class NotFoundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ContentTemplate(
      Center(
        child: Container(
          child: Text("widget not found"),
        ),
      ),
    );
  }
}
