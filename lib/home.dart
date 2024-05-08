import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:marquee/marquee.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'variables .dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Position userLocation;
  late GoogleMapController mapController;

  // List<dynamic> ro1 = [];
  int sta = 0;

  var statinline1 = [];
  var statinline2 = [];
  var detail1 = [];
  var detail2 = [];
  var ro11 = [];
  var ro22 = [];
  var sumcall = [];
  var positionpeople = [14.021088, 99.972237];
  List<LatLng> polylineCoordinates1 = [];
  List<LatLng> polylineCoordinates2 = [];
  List<Marker> markers = [];
  List<Marker> markers1 = [];
  List<Marker> markers2 = [];
  List<Marker> markersall = [];
  List<Marker> markersin = [];
  var position = [];
  BitmapDescriptor s = BitmapDescriptor.defaultMarker;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> getPolyline1() async {
    String apiKey = 'AIzaSyBexf1oa8n6N-Q2RJPtMF8Ad-W6kzPxFBQ';
    //AIzaSyBexf1oa8n6N-Q2RJPtMF8Ad-W6kzPxFBQ
    PolylinePoints polylinePoints = PolylinePoints();
    for (int i = 0; i < statinline1.length - 1; i++) {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        apiKey,
        PointLatLng(statinline1[i][0], statinline1[i][1]),
        PointLatLng(statinline1[i + 1][0], statinline1[i + 1][1]),
      );

      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates1.add(LatLng(point.latitude, point.longitude));
        });
      }
      setState(() {});
    }
  }

  void calculateDistance() {
    const double earthRadius = 6371;
    const double distance = 0.03;
    double d = distance / earthRadius;
    for (int i = 0; i < statinline1.length - 2; i++) {
      List<double> t = [];
      t.add(statinline1[i][0] - d);
      t.add(statinline1[i][1] - d);
      t.add(statinline1[i][0] + d);
      t.add(statinline1[i][1] + d);
      ro11.add(t);
    }
    for (int i = 0; i < statinline2.length - 3; i++) {
      List<double> t = [];
      t.add(statinline2[i][0] - d);
      t.add(statinline2[i][1] - d);
      t.add(statinline2[i][0] + d);
      t.add(statinline2[i][1] + d);
      ro22.add(t);
    }
  }

  Future<void> getPolyline2() async {
    String apiKey = 'AIzaSyBexf1oa8n6N-Q2RJPtMF8Ad-W6kzPxFBQ';
    //AIzaSyBexf1oa8n6N-Q2RJPtMF8Ad-W6kzPxFBQ
    PolylinePoints polylinePoints = PolylinePoints();
    for (int i = 0; i < statinline2.length - 1; i++) {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        apiKey,
        PointLatLng(statinline2[i][0], statinline2[i][1]),
        PointLatLng(statinline2[i + 1][0], statinline2[i + 1][1]),
      );

      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates2.add(LatLng(point.latitude, point.longitude));
        });
      }
      setState(() {});
    }
  }

  void marker1() async {
    for (int i = 0; i < statinline1.length - 1; i++) {
      if (sumcall[i + statinline1.length] == 0) {
        s = s111;
      } else {
        s = s222;
      }
      String title = detail1[i]["bus_stop"];
      String snippet = detail1[i]["station_name"] +
          "มีการกด CallBus " +
          sumcall[i + statinline1.length].toString() +
          " ครั้ง";
      markers1.add(
        Marker(
            icon: s,
            markerId: MarkerId("Marker$i"),
            position: LatLng(statinline1[i][0], statinline1[i][1]),
            infoWindow: InfoWindow(
              title: title,
              snippet: snippet,
            )),
      );
    }
  }

  void marker2() async {
    for (int i = 0; i < statinline2.length - 4; i++) {
      if (sumcall[i] == 0) {
        s = s111;
      } else {
        s = s222;
      }
      String title = detail2[i]["bus_stop"];
      String snippet = detail2[i]["station_name"] +
          "มีการกด CallBus " +
          sumcall[i].toString() +
          " ครั้ง";
      markers2.add(
        Marker(
            icon: s,
            markerId: MarkerId("Marker$i"),
            position: LatLng(statinline2[i][0], statinline2[i][1]),
            infoWindow: InfoWindow(
              title: title,
              snippet: snippet,
            )),
      );
    }
    markers2.add(
      Marker(
        icon: peopleicon,
        markerId: MarkerId("People"),
        position: LatLng(positionpeople[0], positionpeople[1]),
      ),
    );
  }

  void markerall() {
    markersall.addAll(markers1);
    markers1.add(
      Marker(
        icon: peopleicon,
        markerId: MarkerId("People"),
        position: LatLng(positionpeople[0], positionpeople[1]),
      ),
    );
    markers1.add(
      Marker(
        icon: s,
        markerId: MarkerId("Position"),
        position: LatLng(position[0], position[1]),
      ),
    );
    for (int i = 0; i < statinline2.length - 4; i++) {
      if (sumcall[i] == 0) {
        s = s111;
      } else {
        s = s222;
      }
      String title = detail2[i]["bus_stop"];
      String snippet = detail2[i]["station_name"] +
          "มีการกด CallBus " +
          sumcall[i].toString() +
          " ครั้ง";
      markersall.add(
        Marker(
            icon: s,
            markerId: MarkerId("Marker${i + statinline1.length - 1}"),
            position: LatLng(statinline2[i][0], statinline2[i][1]),
            infoWindow: InfoWindow(
              title: title,
              snippet: snippet,
            )),
      );
    }
    markersall.add(
      Marker(
        icon: peopleicon,
        markerId: MarkerId("People"),
        position: LatLng(positionpeople[0], positionpeople[1]),
      ),
    );
    markersall.add(
      Marker(
        icon: s,
        markerId: MarkerId("Position"),
        position: LatLng(position[0], position[1]),
      ),
    );
    startTimer();
  }

  bool isButton1Enabled = true;
  bool isButton2Enabled = true;

  void _handleButton1Press() {
    setState(() {
      isButton1Enabled = false;
      isButton2Enabled = true;
    });
  }

  void _handleButton2Press() {
    setState(() {
      isButton1Enabled = true;
      isButton2Enabled = false;
    });
  }

  Future<Position> _getLocation() async {
    try {
      userLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {}

    return userLocation;
  }

  String buscheck1 = "ไม่มี";

  String bustostation(int lid) {
    getPersentBusStation(lid);
    return buscheck1;
  }

  var buslocation = [14.029403, 99.979446]; //4
  void check(var buslocation) {
    if (isButton1Enabled == false && isButton2Enabled == true) {
      for (int i = 0; i < ro11.length; i++) {
        if (buslocation[0] >= ro11[i][0] &&
            buslocation[1] >= ro11[i][1] &&
            buslocation[0] <= ro11[i][2] &&
            buslocation[1] <= ro11[i][3]) {
          sta = ro22.length + i + 2;
          requestsrarion = sta;
          buscheck1 =
              detail1[i + 1]["bus_stop"] + " " + detail1[i + 1]["station_name"];
        }
      }
    }
    if (isButton1Enabled == true && isButton2Enabled == false) {
      for (int i = 0; i < ro22.length; i++) {
        if (buslocation[0] >= ro22[i][0] &&
            buslocation[1] >= ro22[i][1] &&
            buslocation[0] <= ro22[i][2] &&
            buslocation[1] <= ro22[i][3]) {
          sta = i + 3;
          requestsrarion = sta;
          detail2[i + 1]["bus_stop"] + " " + detail2[i + 1]["station_name"];
        }
      }
    }
  }

  String line11 = "";
  String line22 = "";
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      getpositiobbus(1);
      print(position);
      if (isButton1Enabled == false && isButton2Enabled == true) {
        markers1.removeLast();
        markers1.add(
          Marker(
            icon: iconbus,
            markerId: MarkerId("Position"),
            position: LatLng(position[0], position[1]),
          ),
        );
      } else {
        markersall.removeLast();
        markersall.add(
          Marker(
            icon: iconbus,
            markerId: MarkerId("Position"),
            position: LatLng(position[0], position[1]),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer?.cancel();
    }
    super.dispose();
  }

  @override
  void initState() {
    getpositiobbus(1);
    seticon();
    getStation();

    fetchDataAndSetState();
    super.initState();
  }

  void seticon() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/bus.png",
    ).then((icon) {
      setState(() {
        iconbus = icon;
      });
    });
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/people.png",
    ).then((icon) {
      setState(() {
        peopleicon = icon;
      });
    });
  }

  BitmapDescriptor peopleicon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor sss = BitmapDescriptor.defaultMarker;
  void sermarks() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/12.jpg")
        .then((icon) {
      sss = icon;
    });
  }

  BitmapDescriptor s111 =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
  BitmapDescriptor s222 =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
  BitmapDescriptor iconbus =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);

  Map<PolylineId, Polyline> _getPolylines() {
    Map<PolylineId, Polyline> polylines = {};

    if (isButton1Enabled && isButton2Enabled) {
      polylines[PolylineId("value1")] = Polyline(
        polylineId: PolylineId("value1"),
        points: polylineCoordinates1,
        color: Colors.blue,
        width: 3,
      );
      polylines[PolylineId("value2")] = Polyline(
        polylineId: PolylineId("value2"),
        points: polylineCoordinates2,
        color: const Color.fromARGB(255, 243, 75, 33),
        width: 3,
      );
      markersin = markersall;
    } else if (!isButton1Enabled) {
      polylines[PolylineId("value1")] = Polyline(
        polylineId: PolylineId("value1"),
        points: polylineCoordinates1,
        color: Colors.blue,
        width: 3,
      );
      markersin = markers1;
    } else if (!isButton2Enabled) {
      polylines[PolylineId("value2")] = Polyline(
        polylineId: PolylineId("value2"),
        points: polylineCoordinates2,
        color: const Color.fromARGB(255, 243, 75, 33),
        width: 3,
      );
      markersin = markers2;
    }
    return polylines;
  }

  @override
  Widget build(BuildContext context) {
    double sizebut = (MediaQuery.of(context).size.width / 2) - 17;
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _getLocation(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(14.0215, 99.9784),
                    zoom: 15,
                  ),
                  polylines: Set<Polyline>.from(_getPolylines().values),
                  markers: Set<Marker>.from(getmarke()),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Card(
                elevation: 100,
                margin: EdgeInsets.all(0),
                shadowColor: Colors.black,
                surfaceTintColor: Colors.white,
                child: Container(
                  width: double.infinity,
                  height: 300,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: isButton1Enabled
                                  ? () {
                                      _handleButton1Press();
                                      setState(() {
                                        check([14.029403, 99.979446]);
                                      });
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF3EA97B),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25))),
                                elevation: 5,
                                textStyle: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 111, 255, 116),
                                ),
                                fixedSize: ui.Size(sizebut, 55),
                              ),
                              child: Text(
                                'สาย1',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            ElevatedButton(
                              onPressed:
                                  isButton2Enabled ? _handleButton2Press : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF3EA97B),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25)),
                                ),
                                elevation: 5,
                                textStyle: const TextStyle(color: Colors.black),
                                fixedSize: ui.Size(sizebut, 55),
                              ),
                              child: Text(
                                'สาย2',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      if ((isButton1Enabled == false &&
                              isButton2Enabled == true) ||
                          (isButton1Enabled == true &&
                              isButton2Enabled == false))
                        Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Card(
                              margin: EdgeInsets.only(left: 15, right: 15),
                              surfaceTintColor: Colors.white,
                              elevation: 0,
                              child: SingleChildScrollView(
                                child: Container(
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    width: double.infinity - 200,
                                    height: 100,
                                    child: Row(
                                      children: [
                                        Text("สถานีต่อไป : ",
                                            style: TextStyle(fontSize: 25)),
                                        if (isButton1Enabled == false &&
                                            isButton2Enabled == true)
                                          Expanded(
                                            child: Marquee(
                                              text: bustostation(1),
                                              style: TextStyle(fontSize: 25),
                                              scrollAxis: Axis.horizontal,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              blankSpace: 40.0,
                                              velocity: 100.0,
                                              pauseAfterRound:
                                                  Duration(seconds: 3),
                                              startPadding: 10.0,
                                            ),
                                          )
                                        else if (isButton1Enabled == true &&
                                            isButton2Enabled == false)
                                          Expanded(
                                            child: Marquee(
                                              text: bustostation(2),
                                              style: TextStyle(fontSize: 25),
                                              scrollAxis: Axis.horizontal,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              blankSpace: 40.0,
                                              velocity: 100.0,
                                              pauseAfterRound:
                                                  Duration(seconds: 3),
                                              startPadding: 10.0,
                                            ),
                                          )
                                      ],
                                    )),
                              ),
                            )
                          ],
                        ),
                      if (isButton1Enabled == true && isButton2Enabled == true)
                        Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Card(
                              margin: EdgeInsets.only(left: 15, right: 15),
                              surfaceTintColor: Colors.white,
                              elevation: 0,
                              child: SingleChildScrollView(
                                child: Container(
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    width: double.infinity - 200,
                                    height: 100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            "สาย 1 :" +
                                                line11 +
                                                "  ||  สาย 2 :" +
                                                line22,
                                            style: TextStyle(fontSize: 25)),
                                      ],
                                    )),
                              ),
                            )
                          ],
                        ),
                    ],
                  ),
                )),
          ),
          !isButton1Enabled || !isButton2Enabled
              ? Positioned(
                  bottom: 320,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    width: 40,
                    height: 40,
                    child: FloatingActionButton(
                      onPressed: (isButton1Enabled == false &&
                                  isButton2Enabled == true &&
                                  l1 == true) ||
                              (isButton1Enabled == true &&
                                  isButton2Enabled == false &&
                                  l2 == true)
                          ? () async {
                              int result = await callBus();
                              if (result == 1) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Bus Alert'),
                                      content: Text('ร้องขอรถบัสสำเร็จแล้ว!'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('ปิด'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                                setState(() {
                                  if (isButton1Enabled == false &&
                                      isButton2Enabled == true) {
                                    l1 = false;
                                  }
                                  if (isButton1Enabled == true &&
                                      isButton2Enabled == false) {
                                    l2 = false;
                                  }
                                });
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Bus Alert'),
                                      content: Text('กรุณาอยู่ใกล้สถานี'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('ปิด'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          : null,
                      child: Icon(Icons.directions_bus_outlined),
                      backgroundColor: buttonColor(),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  getmarke() {
    if (isButton1Enabled && isButton2Enabled) {
      return markersall;
    } else if (!isButton1Enabled) {
      return markers1;
    } else if (!isButton2Enabled) {
      return markers2;
    }
  }

//http://192.168.0.100:8080/saveCallBus
  Future<int> callBus() async {
    check([14.021088, 99.972237]); //19
    if (sta != 0) {
      var uri = Uri.parse("http://10.0.2.2:8080/saveCallBus");
      Map<String, String> headers = {"Content-Type": "application/json"};
      Map data = {
        'station': {
          'station_id': sta,
        },
        'calling': 1
      };

      try {
        http.Response response = await http.post(
          uri,
          headers: headers,
          body: jsonEncode(data),
        );
        sta = 0;

        if (response.statusCode == 200) {
          print("Response data: ${response.body}");
          return 1;
        } else {
          print("Request failed with status: ${response.statusCode}");
          return 2;
        }
      } catch (exception) {
        print("Exception: $exception");
        return 3;
      }
    }
    return 0;
  }

  getCallBusInStation() async {
    var uri = Uri.parse("http://10.0.2.2:8080/request/getCallBusInStation");
    Map<String, String> headers = {"Content-Type": "application/json"};
    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );

      if (response.statusCode == 200) {
        print("Response data: ${response.body}");
        var responseBody = json.decode(response.body);

        sumcall = responseBody.map((station) {
          return station[1];
        }).toList();
      } else {
        print("Request failed with status: ${response.statusCode}");
      }
    } catch (exception) {
      print("Exception: $exception");
    }
    sermarks();
    calculateDistance();
    getPolyline1();
    getPolyline2();
    marker1();
    marker2();
    markerall();
  }

  Future<void> getStation() async {
    var uri = Uri.parse("http://10.0.2.2:8080/station/findByLineId");
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=utf-8"
    };
    int lineId = 1;
    try {
      Map<String, int> data = {"id": lineId};
      http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        String utf8Data = utf8.decode(response.bodyBytes);
        var responseBody = json.decode(utf8Data);

        setState(() {
          detail1 = responseBody.map((station) {
            return {
              "station_name": station["station_name"],
              "bus_stop": station["bus_stop"]
            };
          }).toList();

          statinline1 = responseBody.map((station) {
            return [station["latitude"], station["longitude"]];
          }).toList();
        });
        statinline1.add(statinline1[0]);
      } else {
        print("1: ${response.statusCode}");
      }
    } catch (exception) {
      print("Exception: $exception");
    }
    lineId = 2;
    try {
      Map<String, int> data = {"id": lineId};
      http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        String utf8Data = utf8.decode(response.bodyBytes);
        var responseBody = json.decode(utf8Data);

        setState(() {
          detail2 = responseBody.map((station) {
            return {
              "station_name": station["station_name"],
              "bus_stop": station["bus_stop"]
            };
          }).toList();
          statinline2 = responseBody.map((station) {
            return [station["latitude"], station["longitude"]];
          }).toList();

          statinline2.add(statinline2[3]);
          statinline2.add(statinline2[2]);
          statinline2.add(statinline2[1]);
          statinline2.add(statinline2[0]);
        });
      } else {
        print("Request failed with status: ${response.statusCode}");
      }
    } catch (exception) {
      print("Exception: $exception");
    }
    getCallBusInStation();
  }

  Future<void> getPersentBusStation(int lineId) async {
    var uri = Uri.parse("http://10.0.2.2:8080/line/getPersentBusStation");
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=utf-8"
    };

    try {
      Map<String, dynamic> data = {"id": lineId};
      http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        String utf8Data = utf8.decode(response.bodyBytes);
        setState(() {
          buscheck1 = utf8Data;
        });
      } else {
        print("sssss: ${response.statusCode}");
      }
    } catch (exception) {
      print("Exception: $exception");
    }
  }

  buttonColor() {
    if ((isButton1Enabled == false &&
            isButton2Enabled == true &&
            l1 == false) ||
        (isButton1Enabled == true &&
            isButton2Enabled == false &&
            l2 == false)) {
      return Colors.grey;
    } else {
      return Colors.white;
    }
  }

  Future<void> fetchDataAndSetState() async {
    var uri = Uri.parse("http://10.0.2.2:8080/line/getPersentBusStation");
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=utf-8"
    };
    int lineId = 1;
    try {
      Map<String, dynamic> data = {"id": lineId};
      http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        String utf8Data = utf8.decode(response.bodyBytes);
        setState(() {
          List<String> parts1 = utf8Data.split(' ');
          if (parts1.isNotEmpty) {
            line11 = parts1[0];
            print(parts1[0]);
          }
        });
        print(line11);
      } else {
        print("sssss: ${response.statusCode}");
      }
    } catch (exception) {
      print("Exception: $exception");
    }
    lineId = 2;
    try {
      Map<String, dynamic> data = {"id": lineId};
      http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        String utf8Data = utf8.decode(response.bodyBytes);
        setState(() {
          List<String> parts1 = utf8Data.split(' ');
          if (parts1.isNotEmpty) {
            line22 = parts1[0];
            print(parts1[0]);
          }
        });
        print(line22);
      } else {
        print("sssss: ${response.statusCode}");
      }
    } catch (exception) {
      print("Exception: $exception");
    }
  }

  Future<void> getpositiobbus(int lineId) async {
    var uri = Uri.parse("http://10.0.2.2:8080/line/getPositiosBus");
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=utf-8"
    };
    Map<String, dynamic> data = {"id": lineId};
    try {
      http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        setState(() {
          position = json.decode(response.body);
        });
      } else {
        print("sssss: ${response.statusCode}");
      }
    } catch (exception) {
      print("Exception: $exception");
    }
  }
}
