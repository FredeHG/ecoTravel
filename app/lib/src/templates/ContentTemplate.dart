import 'dart:math';

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

  final pelota = Container(
    height: 650.0,
    width: 650.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(236, 98, 188, 1.0),
          Color.fromRGBO(241, 142, 172, 1.0),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            getGradiente(),
            Positioned(left: -510.0, bottom: 100.0, child: pelota),
            Positioned(bottom: -500, child: pelota),
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
