import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ricky_morty/providers/detail_list_provider.dart';

class EpisodesGrid extends StatelessWidget {
  
  final List<String> ids;
  final DetailListProvider provider;

  const EpisodesGrid(
    {
      Key? key, 
      required this.ids,
       required this.provider
    }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: provider.filterBy(ids),
      builder: (context, snapshot) {
        
        List<GridItemData>? espisodes = snapshot.data;

        if (espisodes == null) {
          return Container(
            height: 150,
            child: const CupertinoActivityIndicator(),
          );
        }

        return Container(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: espisodes.length,
            itemBuilder: (context, index) => _GridItemPoster(
              data: espisodes[index],
            ),
          ),
        );
      },
    );

  }
}

class _GridItemPoster extends StatelessWidget {
    final GridItemData data;

    const _GridItemPoster({
      Key? key, 
      required this.data
    }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return Container(
      width: 130,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              color: Colors.grey,
              padding: const EdgeInsets.all(24),
              height: 120,
              width: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.title,
                    maxLines: 3,
                  ),
                  SizedBox(height: 4,),
                  Text(
                    data.subtitle,
                    maxLines: 4,
                    style: const TextStyle(fontSize: 8),
                  ),
                ],
              ),
            )
          ),
        ]
      ),
    );
  }
}