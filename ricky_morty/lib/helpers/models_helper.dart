
class ModelHelper {

  static List<String> getIdsFrom(List<String> modelsURLs) {
    return modelsURLs.map((url) {
      return ModelHelper.getIdFrom(url) ;
    })
    .toList();
  }

  static String getIdFrom(String url) {
    return Uri.parse(url).pathSegments.last;
  }
}