import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MyMapScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<MyMapScreen> {
  LatLng _initialPosition = LatLng(32.03148, 35.43408);
  GoogleMapController _controller;
  Location _location = Location();
  Set<Marker> _markers = Set();
  String searchAddr;

  Future<void> _onMapCreated(GoogleMapController _cntrl) async {
    _controller = _cntrl;

    //_location.onLocationChanged.listen((event) {
    ShowMarkers();

    // _controller.animateCamera(
    //   CameraUpdate.newCameraPosition(
    //     CameraPosition(
    //       target: LatLng(32.036149, 35.729500),
    //       zoom: 15,
    //     ),
    //   ),
    // );
    // },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            padding: EdgeInsets.only(
              top: 300,
            ),
            onTap: (LatLng latLng) {
              setState(() {});
            },
            markers: Set<Marker>.of(_markers),
            initialCameraPosition:
                CameraPosition(target: _initialPosition, zoom: 10),
            mapType: MapType.satellite,
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            mapToolbarEnabled: true,
            compassEnabled: true,
          ),
          Positioned(
            top: 30,
            right: 15,
            left: 15,
            child: Container(
              height: 50.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Enter Address',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                    suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {},
                        iconSize: 30.0)),
                onChanged: (val) {
                  setState(() {
                    searchAddr = val;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void ShowMarkers() {
    _markers.add(Marker(
        markerId: MarkerId('mark2'),
        infoWindow: InfoWindow(title: "مطعم الغربال السياحي"),
        position: LatLng(32.039493, 35.729429)));

    _markers.add(Marker(
        markerId: MarkerId('mark1'),
        infoWindow: InfoWindow(title: "مطعم بيت عزيز"),
        position: LatLng(32.038464, 35.725337)));
    _markers.add(Marker(
        markerId: MarkerId('mark3'),
        infoWindow: InfoWindow(title: "متحف السلط"),
        position: LatLng(32.038289, 35.729274)));

    _markers.add(Marker(
        markerId: MarkerId('mark4'),
        infoWindow: InfoWindow(title: "مطعم العمد  "),
        position: LatLng(32.038218, 35.728013)));
  }

  /*searchandNavigate() {

     Geolocator().placemarkFromAddress(searchAddr).then((result) {
      _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target:
          LatLng(result[0].position.latitude, result[0].position.longitude),
          zoom: 50.0)));
    });
  }*/
}
