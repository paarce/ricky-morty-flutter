

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ricky_morty/providers/episodes_provider.dart';

class HomeSearchDelegate extends SearchDelegate {



  @override
  String? get searchFieldLabel => 'Buscar caracteres';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.ac_unit),
        onPressed: (){
          print("HOLAAAA");
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("buildResults");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if( query.isEmpty ) {
      return Container(
        child: const  Center(
          child: Icon(Icons.person, color: Colors.amberAccent, size: 130,)
        )
      );
    }

    final episodeProvider = Provider.of<EpisodeProvider>(context);
    episodeProvider.searchAsyncBy(query);
    return ListView.builder(
      itemCount: episodeProvider.searchedItems.length,
      itemBuilder: (context, index) => ListTile(title: Text(episodeProvider.searchedItems[index].name)),
    );

    // return FutureBuilder(
    //   future: episodeProvider.searchBy(query),
    //   builder: (context, snapshot) {
    //     var episodes = snapshot.data;

    //     if (episodes == null) {
    //       return Container(
    //         height: 150,
    //         child: const CupertinoActivityIndicator(),
    //       );
    //     }

    //     return ListView.builder(
    //       itemCount: episodes.length,
    //       itemBuilder: (context, index) => ListTile(title: Text(episodes[index].name)),
    //     );
    //   },
    // );
  }

}