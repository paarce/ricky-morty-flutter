import 'package:flutter/material.dart';
import 'package:ricky_morty/models/location_response.dart';
import 'package:ricky_morty/services/api_request.dart';


class LocationProvider extends ChangeNotifier {

  final APIRequest _service = APIRequest();
  final Map<String, Location> _cache = {};

  LocationProvider();

  Future<Location> getLocationBy(String id) async {

    if ( _cache[id] != null ) { return _cache[id]!; }

    final data = await _service.fetchData('/location/$id');
    final model = Location.fromRawJson(data);
    _cache[id] = model;
    return model;
  }
}