
import 'package:flutter/material.dart';
import 'package:ricky_morty/models/episode_response.dart';
import 'package:ricky_morty/services/api_request.dart';

class EpisodeProvider extends ChangeNotifier {

  APIRequest service = APIRequest();

  List<Episode> onDisplayItems = [];

  EpisodeProvider() {
    
    getEpisodes(); 
  }

  getEpisodes() async {

    final data = await service.fetchData('/episode', 1);
    final model = APIResponseEpisode.fromEpisodeRawJson(data);
    
    onDisplayItems = [...model.results];
    notifyListeners();
  }

}