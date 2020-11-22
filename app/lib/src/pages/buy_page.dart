import 'package:app/src/templates/ContentTemplate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';

class BuyPage extends StatefulWidget {
  @override
  _BuyPageState createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  List<String> _opt = [
    'UTN Medrano',
    'UTN Lugano',
    'Obelisco',
    'Estacion Ezeiza',
    'Aeropuerto',
  ];

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ContentTemplate(
      SingleChildScrollView(
        child: Column(
          children: [
            _titulos(),
            _form(),
            _calendar(),
            _boton(),
          ],
        ),
      ),
    );
  }

  Widget _titulos() {
    return ListTile(
      contentPadding: EdgeInsets.only(bottom: 100.0, left: 10),
      title: Text(
        '¿A donde vamos?',
        style: TextStyle(color: Colors.blueAccent, fontSize: 30.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _form() {
    return Center(
      child: FocusTraversalGroup(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          onChanged: () {
            Form.of(primaryFocus.context).save();
          },
          child: Wrap(
            children: [
              dropDown(_opt[0], 'Origen', Icon(Icons.gps_fixed)),
              dropDown(_opt[1], 'Destino', Icon(Icons.place)),
            ],
          ),
        ),
      ),
    );
  }

  Widget dropDown(String _currentItem, String hint, Icon icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
          child: Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.white),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                icon: icon,
                hintText: hint,
              ),
              items: _opt.map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  _currentItem = newValue;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context, initialDate: selectedDate, firstDate: DateTime.now(), lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Widget _calendar() {
    initializeDateFormatting("es");
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: TextFormField(
          enableInteractiveSelection: false,
          controller: TextEditingController()..text = DateFormat.yMMMEd().format(selectedDate),
          onTap: () {
            SystemSound.play(SystemSoundType.click);
            FocusScope.of(context).requestFocus(new FocusNode());
            _selectDate(context);
          },
          decoration: InputDecoration(
            icon: Icon(Icons.today),
          ),
        ),
      ),
    );
  }

  Widget _boton() {
    return RaisedButton(
      onPressed: () {
        MercadoPagoMobileCheckout.startCheckout(
            'TEST-aa0ed958-9b92-4167-85f8-2e8de98f1762', '137450911-da6b7350-00e5-47c3-9476-0f3fe0983ff9');
      },
    );
  }
}
