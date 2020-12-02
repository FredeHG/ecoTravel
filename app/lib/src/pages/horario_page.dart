import 'package:app/src/templates/ContentTemplate.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HorarioPage extends StatelessWidget {
  const HorarioPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentTemplate(
      Scaffold(
        backgroundColor: Colors.white54,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columnSpacing: 35,
            headingTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            dataTextStyle: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
            columns: [
              DataColumn(
                label: Text('Origen'),
              ),
              DataColumn(
                label: Text('Destino'),
              ),
              DataColumn(
                label: Text('Salida'),
              ),
              DataColumn(
                label: Text('Llegada'),
              ),
            ],
            rows: [
              createRow(
                "Estacion Ezeiza",
                "UTN Lugano",
                DateFormat('h:mm:ssa', 'en_US').parseLoose('7:20:00AM'),
                DateFormat('h:mm:ssa', 'en_US').parseLoose('8:10:00AM'),
              ),
              createRow(
                "UTN Lugano",
                "Obelisco",
                DateFormat('h:mm:ssa', 'en_US').parseLoose('8:10:00AM'),
                DateFormat('h:mm:ssa', 'en_US').parseLoose('8:50:00AM'),
              ),
              createRow(
                "Obelisco",
                "UTN Medrano",
                DateFormat('h:mm:ssa', 'en_US').parseLoose('8:55:00AM'),
                DateFormat('h:mm:ssa', 'en_US').parseLoose('9:20:00AM'),
              ),
              createRow(
                "UTN Medrano",
                "Aeropuerto",
                DateFormat('h:mm:ssa', 'en_US').parseLoose('9:20:00AM'),
                DateFormat('h:mm:ssa', 'en_US').parseLoose('10:00:00AM'),
              ),
              createRow(
                "Aeropuerto",
                "Obelisco",
                DateFormat('h:mm:ssa', 'en_US').parseLoose('10:10:00AM'),
                DateFormat('h:mm:ssa', 'en_US').parseLoose('10:45:00AM'),
              ),
              createRow(
                "Obelisco",
                "Estacion Ezeiza",
                DateFormat('h:mm:ssa', 'en_US').parseLoose('10:50:00AM'),
                DateFormat('h:mm:ssa', 'en_US').parseLoose('11:40:00AM'),
              ),
              createRow(
                "Estacion Ezeiza",
                "UTN Lugano",
                DateFormat('h:mm:ssa', 'en_US').parseLoose('12:00:00AM'),
                DateFormat('h:mm:ssa', 'en_US').parseLoose('12:25:00AM'),
              ),
              createRow(
                "UTN Lugano",
                "UTN Medrano",
                DateFormat('h:mm:ssa', 'en_US').parseLoose('12:30:00AM'),
                DateFormat('h:mm:ssa', 'en_US').parseLoose('12:55:00AM'),
              ),
              createRow(
                "UTN Medrano",
                "UTN Lugano",
                DateFormat('h:mm:ssa', 'en_US').parseLoose('1:00:00PM'),
                DateFormat('h:mm:ssa', 'en_US').parseLoose('1:25:00PM'),
              ),
              createRow(
                "UTN Lugano",
                "Estacion Ezeiza",
                DateFormat('h:mm:ssa', 'en_US').parseLoose('1:30:00PM'),
                DateFormat('h:mm:ssa', 'en_US').parseLoose('1:55:00PM'),
              ),
              createRow(
                "Estacion Ezeiza",
                "UTN Medrano",
                DateFormat('h:mm:ssa', 'en_US').parseLoose('4:30:00PM'),
                DateFormat('h:mm:ssa', 'en_US').parseLoose('5:20:00PM'),
              ),
              createRow(
                "UTN Medrano",
                "UTN Lugano",
                DateFormat('h:mm:ssa', 'en_US').parseLoose('5:25:00PM'),
                DateFormat('h:mm:ssa', 'en_US').parseLoose('5:50:00PM'),
              ),
              createRow(
                "UTN Lugano",
                "Estacion Ezeiza",
                DateFormat('h:mm:ssa', 'en_US').parseLoose('6:10:00PM'),
                DateFormat('h:mm:ssa', 'en_US').parseLoose('7:00:00PM'),
              ),
              createRow(
                "Estacion Ezeiza",
                "Aeropuerto",
                DateFormat('h:mm:ssa', 'en_US').parseLoose('7:05:00PM'),
                DateFormat('h:mm:ssa', 'en_US').parseLoose('7:45:00PM'),
              ),
              createRow(
                "Aeropuerto",
                "Obelisco",
                DateFormat('h:mm:ssa', 'en_US').parseLoose('7:45:00PM'),
                DateFormat('h:mm:ssa', 'en_US').parseLoose('8:55:00PM'),
              ),
              createRow(
                "Obelisco",
                "Aeropuerto",
                DateFormat('h:mm:ssa', 'en_US').parseLoose('9:05:00PM'),
                DateFormat('h:mm:ssa', 'en_US').parseLoose('9:40:00PM'),
              ),
              createRow(
                "Aeropuerto",
                "Obelisco",
                DateFormat('h:mm:ssa', 'en_US').parseLoose('9:50:00PM'),
                DateFormat('h:mm:ssa', 'en_US').parseLoose('10:15:00PM'),
              ),
              createRow(
                "Obelisco",
                "UTN Medrano",
                DateFormat('h:mm:ssa', 'en_US').parseLoose('10:20:00PM'),
                DateFormat('h:mm:ssa', 'en_US').parseLoose('10:35:00PM'),
              ),
              createRow(
                "UTN Medrano",
                "UTN Lugano",
                DateFormat('h:mm:ssa', 'en_US').parseLoose('10:35:00PM'),
                DateFormat('h:mm:ssa', 'en_US').parseLoose('11:00:00PM'),
              ),
              createRow(
                "UTN Lugano",
                "Estacion Ezeiza",
                DateFormat('h:mm:ssa', 'en_US').parseLoose('11:10:00PM'),
                DateFormat('h:mm:ssa', 'en_US').parseLoose('11:35:00PM'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  createRow(String origen, String destino, DateTime salida, DateTime llegada) {
    return DataRow(
      cells: [
        DataCell(Text(origen)),
        DataCell(Text(destino)),
        DataCell(Text(DateFormat.Hms().format(salida))),
        DataCell(Text(DateFormat.Hms().format(llegada))),
      ],
    );
  }
}
