import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:app/src/helper/Secrets.dart';
import 'package:app/src/templates/ContentTemplate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapsPage extends StatefulWidget {
  @override
  _MapsPage createState() => _MapsPage();
}

class _MapsPage extends State<MapsPage> {
  GoogleMapController mapController;
  CameraPosition _initialLocation = CameraPosition(
    target: LatLng(0.0, 0.0),
  );
  //marcadores:
  Marker ezeizaEstacion;
  Marker ezeizaAeropuerto;
  Marker utnLugano;
  Marker utnMedrano;
  Marker obelisco;
  Set<Marker> markers = new Set<Marker>();

  PolylinePoints polylinePoints;
  Position _currentPosition;

  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  List<dynamic> dataTravels;
  //icons
  BitmapDescriptor collegeBitmap;

  var _currentItem;

  Future<bool> updatePoly() async {
    polylineCoordinates = [];
    var travel;
    for (var item in dataTravels) {
      if (item['_id'] == _currentItem) {
        travel = item;
        await _createPolylines(getPosition(travel['origin']), getPosition(travel['destination']));
        break;
      }
    }
    setState(() {});
    return true;
  }

  _createPolylines(Position start, Position destination) async {
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Secrets.API_KEY,
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.driving,
    );

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    // Defining an ID
    PolylineId id = PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 3,
    );

    // Adding the polyline to the map
    polylines[id] = polyline;
  }

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) async {
      setState(() {
        // Store the position in the variable
        _currentPosition = position;

        // For moving the camera to current location
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 12.0,
            ),
          ),
        );
      });
    }).catchError((e) {
      print(e);
    });
  }

  listBotom() {
    return SafeArea(
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 22.0, top: 22.0),
          child: ClipOval(
            child: Material(
              color: Colors.lightGreen[100],
              child: PopupMenuButton<String>(
                itemBuilder: (BuildContext context) => dataTravels.map((value) {
                  return PopupMenuItem<String>(
                    child: Text(value['origin']['name'] + ' - ' + value['destination']['name']),
                    value: value['_id'],
                  );
                }).toList(),
                icon: Icon(Icons.arrow_downward),
                onSelected: (String newValue) {
                  setState(() {
                    _currentItem = newValue;
                    print(_currentItem);
                    updatePoly().then((isCalculated) {});
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  SafeArea zoomBotom() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipOval(
              child: Material(
                color: Colors.blue[100], // button color
                child: InkWell(
                  splashColor: Colors.blue, // inkwell color
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(Icons.add),
                  ),
                  onTap: () {
                    mapController.animateCamera(
                      CameraUpdate.zoomIn(),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            ClipOval(
              child: Material(
                color: Colors.blue[100], // button color
                child: InkWell(
                  splashColor: Colors.blue, // inkwell color
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(Icons.remove),
                  ),
                  onTap: () {
                    mapController.animateCamera(
                      CameraUpdate.zoomOut(),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  positionBotom() {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
          child: ClipOval(
            child: Material(
              color: Colors.orange[100], // button color
              child: InkWell(
                splashColor: Colors.orange, // inkwell color
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: Icon(Icons.my_location),
                ),
                onTap: () {
                  mapController.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: LatLng(
                          _currentPosition.latitude,
                          _currentPosition.longitude,
                        ),
                        zoom: 12.0,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getTravels();
    doMarker().then((value) {
      setState(() {
        loadMakers(markers);
      });
    });
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return ContentTemplate(
      Center(
        child: Container(
          height: double.infinity,
          child: Stack(
            children: [
              GoogleMap(
                polylines: Set<Polyline>.of(polylines.values),
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                markers: markers,
                initialCameraPosition: _initialLocation,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
              ),
              zoomBotom(),
              positionBotom(),
              listBotom(),
            ],
          ),
        ),
      ),
    );
  }

  void loadMakers(Set<Marker> markers) {
    markers.add(ezeizaEstacion);
    markers.add(ezeizaAeropuerto);
    markers.add(utnMedrano);
    markers.add(utnLugano);
    markers.add(obelisco);
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  Marker createMarker(point, BitmapDescriptor icon) {
    var coordinates = point['coordinates'];
    return Marker(
      markerId: MarkerId(coordinates['latitude'].toString() + coordinates['longitude'].toString()),
      position: LatLng(coordinates['latitude'], coordinates['longitude']),
      icon: icon,
    );
  }

  Position getPosition(dynamic point) {
    return Position(latitude: point['coordinates']['latitude'], longitude: point['coordinates']['longitude']);
  }

  Future<void> doMarker() async {
    var colegioByte = await getBytesFromAsset("assets/colegio.png", 100);
    var estacionByte = await getBytesFromAsset("assets/estacion.png", 100);
    var aeropuertoByte = await getBytesFromAsset("assets/aeropuerto.png", 100);
    var obeliscoByte = await getBytesFromAsset("assets/obelisco.png", 100);

    BitmapDescriptor utnMedranoBit = BitmapDescriptor.fromBytes(colegioByte);
    BitmapDescriptor utnLuganoBit = BitmapDescriptor.fromBytes(colegioByte);
    BitmapDescriptor estacionBit = BitmapDescriptor.fromBytes(estacionByte);
    BitmapDescriptor aeropuertoBit = BitmapDescriptor.fromBytes(aeropuertoByte);
    BitmapDescriptor obeliscoBit = BitmapDescriptor.fromBytes(obeliscoByte);

    http.Response response = await http.get('http://10.0.2.2:4000/api/points');
    var dataPoints = json.decode(response.body)['points'];
    ezeizaEstacion = createMarker(dataPoints[0], estacionBit);
    utnLugano = createMarker(dataPoints[1], utnLuganoBit);
    utnMedrano = createMarker(dataPoints[2], utnMedranoBit);
    obelisco = createMarker(dataPoints[3], obeliscoBit);
    ezeizaAeropuerto = createMarker(dataPoints[4], aeropuertoBit);
  }

  getTravels() async {
    http.Response response = await http.get('http://10.0.2.2:4000/api/travels');
    dataTravels = json.decode(response.body)['travels'];
    setState(() {});
  }
}
