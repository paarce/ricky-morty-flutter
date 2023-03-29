import 'package:http/http.dart' as http;

class APIRequest {

  final String _baseUrl = "rickandmortyapi.com";

  Future<String> fetchData(endpoint, {int? page}) async {
    
    Map<String, dynamic> params = {};
    
    if (page != null) {
      params['page'] = '$page';
    }

    var url = Uri.https(_baseUrl, "/api$endpoint", params);
  
    final res = await http.get(url);
    return res.body;
  }

}