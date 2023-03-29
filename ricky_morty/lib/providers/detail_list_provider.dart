
abstract class DetailListProvider {

  Future<List<GridItemData>> filterBy(List<String> ids, {String? cacheID});
} 

class GridItemData {
    final String title;
    final String subtitle;

    const GridItemData({
      required this.title,
      required this.subtitle
    });
}