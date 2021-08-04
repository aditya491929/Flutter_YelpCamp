import 'dart:convert';

import 'package:http/http.dart' as http;

const ACCESS_TOKEN = 'xxxxx';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/light-v10/static/pin-s+555555($longitude,$latitude)/$longitude,$latitude,13,0,60/400x400?access_token=$ACCESS_TOKEN';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = Uri.parse(
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$lng,$lat.json?access_token=$ACCESS_TOKEN');

    final response = await http.get(url);
    return json.decode(response.body)['features'][0]['place_name'];
    // print(json.decode(response.body));
  }
}
