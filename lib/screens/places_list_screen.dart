import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/great_places.dart';
import './place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.network('https://img.icons8.com/color/50/camping-tent.png'),
            SizedBox(
              width: 2,
            ),
            Text('YelpCamp'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
        child: Center(
          child: FutureBuilder(
            future: Provider.of<GreatPlaces>(context, listen: false)
                .fetchAndSetPlaces(),
            builder: (ctx, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).accentColor,
                    ),
                  )
                : Consumer<GreatPlaces>(
                    child: Center(
                      child: const Text(
                        'Got no Campgrounds yet, start adding some!',
                      ),
                    ),
                    builder: (ctx, greatPlaces, ch) => greatPlaces
                                .items.length <=
                            0
                        ? ch
                        : ListView.builder(
                            itemCount: greatPlaces.items.length,
                            itemBuilder: (ctx, i) => Card(
                              elevation: 8,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 6),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        FileImage(greatPlaces.items[i].image),
                                  ),
                                  title: Text(
                                    greatPlaces.items[i].title,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                      greatPlaces.items[i].location.address),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        PlaceDetailScreen.routeName,
                                        arguments: greatPlaces.items[i].id);
                                  },
                                ),
                              ),
                            ),
                          ),
                  ),
          ),
        ),
      ),
    );
  }
}
