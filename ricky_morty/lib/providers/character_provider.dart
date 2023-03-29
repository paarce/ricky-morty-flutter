import 'package:flutter/material.dart';
import 'package:ricky_morty/models/character_response.dart';
import 'package:ricky_morty/services/api_request.dart';

class CharacterProvider extends ChangeNotifier {

  final APIRequest _service = APIRequest();
  bool _isLoading = false;
  int _page = 1;

  List<Character> onDisplayItems = [];
  String? titleFiltered;

  CharacterProvider() {
    
    _getCharacter(); 
  }

  void refreshCharacters() async {
    _page = 1;
    onDisplayItems = [];
    _getCharacter();
  }


  void nextCharacterPage() async {
    _page++;
    _getCharacter();
  }

  void filterCharacter(String episodeName, List<String> ids) async {
    String idsWithCommas = ids.join(',');

    final data = await _service.fetchData('/character/$idsWithCommas', page: _page );
    final model = APIResponseCharacters.fromCharacterFilteredRawJson(data);
    
    onDisplayItems = model.results;
    titleFiltered = episodeName;

    notifyListeners();
  }


  void _getCharacter() async {
    if (_isLoading ) { return; }
    _isLoading = true;
    final data = await _service.fetchData('/character', page: _page );
    final model = APIResponseCharacters.fromCharacterRawJson(data);
    
    onDisplayItems = [...onDisplayItems, ...model.results];
    titleFiltered = null;

    notifyListeners();
    _isLoading = false;
  }
}