import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:map_application/models/place.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS
  List<Place> _places = <Place>[];


  void _add(Place place) {
      MarkerId markerId = new MarkerId(place.id);

      // creating a new MARKER  
      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
        double.parse(place.latitude), double.parse(place.longitude)
        ),
        infoWindow: InfoWindow(title: place.name, snippet: '*'),
      );

      setState(() {
        // adding a new marker to map
        markers[markerId] = marker;
      });
  }



  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );



   Future<List<Place>> _fetchPlaces() async {

    final placesListAPIUrl = '127.0.0.1:3000/places/list';
        final response = await http.get(placesListAPIUrl);

        if (response.statusCode == 200) {
          List jsonResponse = json.decode(response.body);
          return jsonResponse.map((place) => new Place.fromJson(place)).toList();
        } else {
          throw Exception('Failed to load places from API');
        }
  }

  void getPlaces() async{
    List<Place> places = await _fetchPlaces();
    places.forEach((place) => {
      _add(place),
    });
  }

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          getPlaces();
          _controller.complete(controller);
        },
        
        markers: Set<Marker>.of(markers.values),
      ),
    );
  }

}