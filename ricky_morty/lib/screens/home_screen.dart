import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ricky_morty/helpers/models_helper.dart';
import 'package:ricky_morty/providers/character_provider.dart';
import 'package:ricky_morty/providers/episodes_provider.dart';
import 'package:ricky_morty/screens/search/search_home_delegate.dart';
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
        actions:  [
          IconButton(
            onPressed: () => showSearch(context: context, delegate: HomeSearchDelegate()), 
            icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: Column(
        children:  [
          CardSwiper(
            episodes: episodeProvider.onDisplayItems,
            filterCharacters: (episode) { // This should be in another place
              
              characterProvider.filterCharacter(episode.name, ModelHelper.getIdsFrom(episode.characters));
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