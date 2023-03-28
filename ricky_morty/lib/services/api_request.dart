import 'package:http/http.dart' as http;

class APIRequest {

  final String _baseUrl = "rickandmortyapi.com";

  Future<String> fetchData(endpoint, int page) async {
    
    var url = Uri.https(_baseUrl, "/api$endpoint", {
      'page': '$page'
    });
  
    final res = await http.get(url);
    return res.body;
  }
}