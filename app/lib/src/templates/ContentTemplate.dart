import 'package:app/src/helper/gradiente.dart';
import 'package:flutter/material.dart';

class ContentTemplate extends StatefulWidget {
  final Widget contentWidget;

  ContentTemplate(this.contentWidget);

  @override
  _ContentTemplateState createState() => _ContentTemplateState();
}

class _ContentTemplateState extends State<ContentTemplate> {
  final EdgeInsets formScreenTopPadding = EdgeInsets.only(top: 46, left: 24, right: 24);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            getGradiente(),
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: formScreenTopPadding,
                  child: Container(
                    width: double.infinity,
                    child: widget.contentWidget,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
