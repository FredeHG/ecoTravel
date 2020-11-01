import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Boleto extends StatefulWidget {
  Boleto({Key key}) : super(key: key);

  @override
  _BoletoState createState() => _BoletoState();
}

class _BoletoState extends State<Boleto> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          _fondoApp(),
          Positioned(
            top: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _titulos(),
                SizedBox(height: 20.0),
                _boleto(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _fondoApp() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.6),
          end: FractionalOffset(0.0, 1.0),
          colors: [
            Color.fromRGBO(52, 54, 101, 1.0),
            Color.fromRGBO(35, 37, 57, 1.0),
          ],
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        gradiente,
      ],
    );
  }

  Widget _titulos() {
    return Container(
      padding: EdgeInsets.all(35.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Muestre el QR al conductor',
            style: TextStyle(
                color: Colors.pinkAccent,
                fontSize: 25.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _boleto() {
    return Container(
      child: Center(
        child: QrImage(
          data: "1234567890",
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
