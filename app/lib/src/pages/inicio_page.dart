import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
  const Inicio({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          _fondoApp(),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _titulos(),
                _botonesRedondeados(context),
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

    final cajaRosa = Transform.rotate(
      angle: -pi / 5.0,
      child: Container(
        height: 350.0,
        width: 350.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(236, 98, 188, 1.0),
              Color.fromRGBO(241, 142, 172, 1.0),
            ],
          ),
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        gradiente,
        Positioned(
          top: -100.0,
          left: -80.0,
          child: cajaRosa,
        ),
      ],
    );
  }

  Widget _titulos() {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'EcoTravel',
            style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Text(
            'Tus viajes mas económicos y comodos',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _botonesRedondeados(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.blue, Icons.bus_alert, 'Horarios', context, 'pages/buy_page'),
            _crearBotonRedondeado(Colors.purpleAccent, Icons.directions_bus, 'Recorridos', context, 'pages/maps'),
          ],
        ),
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.redAccent, Icons.payment, 'Comprar', context, 'pages/buy_page'),
            _crearBotonRedondeado(
                Colors.pinkAccent, Icons.monetization_on, 'Subscripciones', context, 'pages/buy_page'),
          ],
        ),
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.amberAccent, Icons.book, 'Mis viajes', context, 'pages/buy_page'),
            _crearBotonRedondeado(Colors.orangeAccent, Icons.settings, 'Configuración', context, 'pages/buy_page'),
          ],
        ),
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.blueGrey, Icons.warning, 'Alerta', context, 'pages/buy_page'),
            _crearBotonRedondeado(Colors.greenAccent, Icons.warning, 'Alerta', context, 'pages/buy_page'),
          ],
        ),
      ],
    );
  }

  Widget _crearBotonRedondeado(Color color, IconData icono, String texto, BuildContext context, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              height: 180.0,
              decoration: BoxDecoration(
                color: Color.fromRGBO(62, 66, 107, 0.7),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(
                    radius: 35.0,
                    backgroundColor: color,
                    child: Icon(icono, color: Colors.white, size: 30.0),
                  ),
                  Text(
                    texto,
                    style: TextStyle(fontSize: 18.0, color: Colors.pinkAccent),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
