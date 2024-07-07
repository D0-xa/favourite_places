import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:favourite_places/Models/place.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.084,
      address: '',
    ),
  });

  final PlaceLocation location;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool _isSelected = false;
  late LatLng _pickedLocation;

  @override
  void initState() {
    super.initState();
    _pickedLocation = LatLng(
      widget.location.latitude,
      widget.location.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isSelecting = widget.location.address.isEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(isSelecting ? 'Pick your Location' : 'Your Location'),
        actions: [
          if (isSelecting)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: const Icon(Icons.save_as_outlined),
            ),
        ],
      ),
      body: GoogleMap(
        onTap: !isSelecting
            ? null
            : (position) {
                setState(() {
                  _pickedLocation = position;
                  _isSelected = true;
                });
              },
        initialCameraPosition: CameraPosition(
          target: _pickedLocation,
          zoom: 16,
        ),
        markers: (isSelecting && !_isSelected)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: _pickedLocation,
                ),
              },
      ),
    );
  }
}
