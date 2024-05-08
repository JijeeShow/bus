import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Testpage extends StatefulWidget {
  const Testpage({super.key});

  @override
  State<Testpage> createState() => _TestpageState();
}

class _TestpageState extends State<Testpage> {
  // ส่วนประกาศตัวแปร
  final _controller = NotchBottomBarController(index: 0);
  late Position userLocation;
  late GoogleMapController mapController;
  var ro2 = [
    [14.02739282591995, 99.97978041176576],
    [14.029403, 99.979444],
    [14.026832, 99.975103],
    [14.024800, 99.973774],
    [14.023663, 99.973770],
    [14.021494, 99.973744],
    [14.021125, 99.974654],
    [14.021609, 99.975968],
    [14.023497, 99.975990],
    [14.023687, 99.978449],
    [14.023909, 99.979168],
    [14.028886, 99.978775]
  ];
  var ro22 = [
    [14.02739282591995, 99.97978041176576],
    [14.029403, 99.979444],
    [14.026832, 99.975103],
    [14.024800, 99.973774],
    [14.023663, 99.973770],
    [14.021494, 99.973744],
    [14.021125, 99.974654],
    [14.021609, 99.975968],
    [14.023497, 99.975990],
   [14.023687, 99.978449],
    [14.023909, 99.979168],
    [14.028886, 99.978775]
  ];
  List<LatLng> polylineCoordinates = [];

 
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> getPolyline() async {
    String apiKey = 'AIzaSyBexf1oa8n6N-Q2RJPtMF8Ad-W6kzPxFBQ'; 
    PolylinePoints polylinePoints = PolylinePoints(); 
    for (int i = 0; i < ro22.length - 1; i++) {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        apiKey,
        PointLatLng(ro22[i][0], ro22[i][1]),
        PointLatLng(ro22[i + 1][0], ro22[i + 1][1]),
      );

      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }
      setState(() {});
    }
  }

  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    userLocation = await Geolocator.getCurrentPosition();
    return userLocation;
  }

  @override
  void initState() {
    super.initState();
    getPolyline();
  }


  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Flutter Google Maps'),
    ),
    body: FutureBuilder(
      future: _getLocation(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<Marker> markers = [];
          markers.add(
            Marker(
              markerId: MarkerId("value"),
              position: LatLng(
                14.021740645938928,
                99.98998486968063,
              ),
            ),
          );
          for (int i = 0; i < ro2.length; i++) {
            markers.add(
              Marker(
                markerId: MarkerId("Marker$i"),
                position: LatLng(ro2[i][0], ro2[i][1]),
              ),
            );
          }

          return Stack(
            children: [
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(14.023687, 99.978449),
                  zoom: 15,
                ),
                polylines: {
                  Polyline(
                    polylineId: PolylineId("value"),
                    points: polylineCoordinates,
                    color: Colors.blue,
                    width: 3,
                  ),
                },
                markers: Set<Marker>.from(markers),
              ),
             Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child:AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        color: Colors.white,
        showLabel: false,
        notchColor: Colors.black87,
        removeMargins: false,
        bottomBarWidth: 500,
        durationInMilliSeconds: 300,
        bottomBarItems: [
          const BottomBarItem(
            inActiveItem: Icon(
              Icons.home_filled,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.home_filled,
              color: Colors.blueAccent,
            ),
            itemLabel: 'Page 1',
          ),
          const BottomBarItem(
            inActiveItem: Icon(
              Icons.star,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.star,
              color: Colors.blueAccent,
            ),
            itemLabel: 'Page 2',
          ),

          ///svg example
          BottomBarItem(
            inActiveItem: SvgPicture.asset(
              'assets/search_icon.svg',
              color: Colors.blueGrey,
            ),
            activeItem: SvgPicture.asset(
              'assets/search_icon.svg',
              color: Colors.white,
            ),
            itemLabel: 'Page 3',
          ),
          const BottomBarItem(
            inActiveItem: Icon(
              Icons.settings,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.settings,
              color: Colors.pink,
            ),
            itemLabel: 'Page 4',
          ),
          const BottomBarItem(
            inActiveItem: Icon(
              Icons.person,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.person,
              color: Colors.yellow,
            ),
            itemLabel: 'Page 5',
          ),
        ],
        onTap: (index) {

        },
      ),
    ),
                  
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ),
  );
}
}