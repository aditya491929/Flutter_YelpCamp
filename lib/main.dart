import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/great_places.dart';
import './screens/places_list_screen.dart';
import './screens/add_place_screen.dart';
import './screens/map_screen.dart';
import './screens/place_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        title: 'YelpCamp',
        theme: ThemeData.dark().copyWith(
          accentColor: Colors.amber[300],
          colorScheme: ColorScheme.dark(secondary: Colors.amber[300]),
          textTheme: TextTheme(
            button: TextStyle(color: Colors.white),
          ),
        ),
        home: PlacesListScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
