
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ricky_morty/models/episode_response.dart';
import 'package:ricky_morty/services/api_request.dart';
import 'package:ricky_morty/providers/detail_list_provider.dart';


class EpisodeProvider extends ChangeNotifier implements DetailListProvider {

  final APIRequest _service = APIRequest();

  List<Episode> onDisplayItems = [];
  List<Episode> searchedItems = [];
  final Map<String, List<Episode>> _cache = {};

  Timer? _timer;
  String? _keywords; 

  EpisodeProvider() {
    
    getEpisodes(); 
  }

  getEpisodes() async {

    final data = await _service.fetchData('/episode', page: 1);
    final model = APIResponseEpisode.fromEpisodeRawJson(data);
    
    onDisplayItems = [...model.results];
    notifyListeners();
  }

  void searchAsyncBy(String keywords) async {
    if (_keywords == keywords) { return; }
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 1), () {
        print(keywords);
      _updateSearchedItems(keywords);
    });
  }

  void _updateSearchedItems(keywords) async {
    if (_keywords == keywords) { return; }
    _keywords = keywords;

    final data = await _service.fetchData('/episode', keyboard: _keywords);
    print(data);
    //Handle errors
    final model = APIResponseEpisode.fromEpisodeRawJson(data);
    searchedItems = model.results;
    notifyListeners();
  }


  Future<List<Episode>> searchBy(String keywords) async {
    List<Episode> filter = [];
    filter.addAll(onDisplayItems);
    filter.retainWhere((element) => element.name.contains(keywords));

    return filter;
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