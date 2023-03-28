import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ricky_morty/providers/character_provider.dart';
import 'package:ricky_morty/providers/episodes_provider.dart';
import 'package:ricky_morty/widgets/card_swiper.dart';
import 'package:ricky_morty/widgets/list_slider.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final characterProvider = Provider.of<CharacterProvider>(context);
    final episodeProvider = Provider.of<EpisodeProvider>(context);

    return  Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.search_outlined))
        ],
      ),
      body: Column(
        children:  [
          CardSwiper(
            episodes: episodeProvider.onDisplayItems,
            filterCharacters: (episode) { // This should be in another place
              var ids = episode.characters.map((e) {
                var uri = Uri.parse(e);
                return uri.pathSegments.last;
              });
              characterProvider.filterCharacter(episode.name, ids.toList());
            },
          ),
          ListSlider(
            characters: characterProvider.onDisplayItems,
            title: characterProvider.titleFiltered ?? "Lista",
            onNextPage: () => characterProvider.nextCharacterPage(),
            clearFilter: () => characterProvider.refreshCharacters(),
          )
        ],
      ),
    );
  }
}