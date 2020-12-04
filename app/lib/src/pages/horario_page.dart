import 'package:app/src/templates/ContentTemplate.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HorarioPage extends StatefulWidget {
  const HorarioPage({Key key}) : super(key: key);

  @override
  _HorarioPageState createState() => _HorarioPageState();
}

class _HorarioPageState extends State<HorarioPage> {
  List<dynamic> dataSchedule;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ContentTemplate(
      Scaffold(
        backgroundColor: Colors.white54,
        body: _schedule(),
      ),
    );
  }

  createRow(dynamic value) {
    return DataRow(
      cells: [
        DataCell(Text(value['origin'])),
        DataCell(Text(value['destination'])),
        DataCell(Text(DateFormat.Hms().format(DateFormat('h:mm:ssa', 'en_US').parseLoose(value['departure'])))),
        DataCell(Text(DateFormat.Hms().format((DateFormat('h:mm:ssa', 'en_US').parseLoose(value['arrive']))))),
      ],
    );
  }

  Future<List<dynamic>> _getSchedule() async {
    http.Response response = await http.get('http://10.0.2.2:4000/api/schedule');
    dataSchedule = json.decode(response.body)['schedule'];
    print(dataSchedule);
    return dataSchedule;
  }

  _schedule() {
    return FutureBuilder(
      future: _getSchedule(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
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
              rows: snapshot.data.map<DataRow>((value) => createRow(value)).toList(),
            ),
          );
        } else if (snapshot.hasError) {
          return AlertDialog(
            title: Text(
              'An Error Occured!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.redAccent,
              ),
            ),
            content: Text(
              "${snapshot.error}",
              style: TextStyle(
                color: Colors.blueAccent,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Go Back',
                  style: TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[CircularProgressIndicator(), SizedBox(height: 20), Text('This may take some time..')],
          ),
        );
      },
    );
  }
}
