
import 'package:flutter/material.dart';
import 'package:ricky_morty/models/episode_response.dart';
import 'package:ricky_morty/services/api_request.dart';
import 'package:ricky_morty/providers/detail_list_provider.dart';


class EpisodeProvider extends ChangeNotifier implements DetailListProvider {

  final APIRequest _service = APIRequest();

  List<Episode> onDisplayItems = [];
  final Map<String, List<Episode>> _cache = {};

  EpisodeProvider() {
    
    getEpisodes(); 
  }

  getEpisodes() async {

    final data = await _service.fetchData('/episode', page: 1);
    final model = APIResponseEpisode.fromEpisodeRawJson(data);
    
    onDisplayItems = [...model.results];
    notifyListeners();
  }

  @override
  Future<List<GridItemData>> filterBy(List<String> ids, {String? cacheID}) async {

    if(cacheID != null && _cache[cacheID] != null) {
      return _cache[cacheID]!.map((e) {
        return GridItemData(title: e.name, subtitle: e.airDate);
      })
      .toList();
    }


    String idsWithCommas = ids.join(',');
    final data = await _service.fetchData('/episode/$idsWithCommas');
    final model = APIResponseEpisode.fromEpisodeFilteredRawJson(data);
    if(cacheID != null) { _cache[cacheID] = model.results; }
    
    // Should it use a GridItemData constructor that recieves Episodes?
    return model.results.map((e) {
      return GridItemData(title: e.name, subtitle: e.airDate);
    })
    .toList();
  }

}