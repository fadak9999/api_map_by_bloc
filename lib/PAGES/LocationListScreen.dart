
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:api_map_by_bloc/MODEL/model.dart';

class LocationListScreen extends StatelessWidget {
  final MyCategory category;

  const LocationListScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${category.name} Locations'),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(31.99330933, 44.3153606),
          zoom: 14.0,
        ),
        markers: _buildMarkers(),
      ),
    );
  }

  Set<Marker> _buildMarkers() {
    final Set<Marker> markers = {};
    for (var location in category.locations) {
      markers.add(
        Marker(
          markerId: MarkerId(location.id),
          position: LatLng(
            double.parse(location.googleLatitude),
            double.parse(location.googleLongitude),
          ),
          infoWindow: InfoWindow(
            title: location.name,
            snippet: location.description,
          ),
        ),
      );
    }
    return markers;
  }
}
