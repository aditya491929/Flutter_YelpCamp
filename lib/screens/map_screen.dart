import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map-page';

  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 37.422, longitude: -122.084),
      this.isSelecting = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  latLng.LatLng _pickedLocation;

  void _selectLocation(latLng.LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a Location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
              icon: Icon(Icons.check),
            ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          center: latLng.LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 13.0,
          onTap: widget.isSelecting ? _selectLocation : null,
        ),
        layers: [
          TileLayerOptions(urlTemplate: "xxxx", additionalOptions: {
            'accessToken': 'xxxx',
            'id': 'mapbox.mapbox-streets-v8',
          }),
          MarkerLayerOptions(
            markers: (_pickedLocation == null && widget.isSelecting)
                ? []
                : [
                    Marker(
                      width: 45.0,
                      height: 45.0,
                      point: _pickedLocation ??
                          latLng.LatLng(widget.initialLocation.latitude,
                              widget.initialLocation.longitude),
                      builder: (ctx) => Container(
                        child: IconButton(
                          onPressed: () {
                            print('Marker tapped');
                          },
                          icon: Icon(Icons.location_on),
                          color: Colors.red,
                          iconSize: 45.0,
                        ),
                      ),
                    ),
                  ],
          ),
        ],
      ),
    );
  }
}
