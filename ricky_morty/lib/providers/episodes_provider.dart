
import 'package:flutter/material.dart';
import 'package:ricky_morty/models/episode_response.dart';
import 'package:ricky_morty/services/api_request.dart';

class EpisodeProvider extends ChangeNotifier {

  APIRequest _service = APIRequest();

  List<Episode> onDisplayItems = [];

  EpisodeProvider() {
    
    getEpisodes(); 
  }

  getEpisodes() async {

    final data = await _service.fetchData('/episode', 1);
    final model = APIResponseEpisode.fromEpisodeRawJson(data);
    
    onDisplayItems = [...model.results];
    notifyListeners();
  }

  void filterCharacter(String episodeName, List<String> ids) async {
    String idsWithCommas = ids.join(',');

    final data = await _service.fetchData('/episode/$idsWithCommas', 1);
    final model = APIResponseEpisode.fromEpisodeFilteredRawJson(data);
    
    onDisplayItems = model.results;

    notifyListeners();
  }

}