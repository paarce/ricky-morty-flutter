import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ricky_morty/providers/episodes_provider.dart';
import 'package:ricky_morty/models/character_response.dart';
import 'package:ricky_morty/models/episode_response.dart';
import 'package:ricky_morty/widgets/widgets.dart';

class DetailScreen extends StatelessWidget {

  const DetailScreen(
    {
      Key? key, 
    }
  ) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final character = ModalRoute.of(context)?.settings.arguments as Character;

    return  Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(name: character.name, imageURL: character.image),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
                _BasicInformation(character: character),
                const SizedBox(height: 20),
                const Text('Episodes', style: TextStyle(fontSize: 25),),
                const _EpisodesGrid(),
                const SizedBox(height: 20),
                const Text('Location', style: TextStyle(fontSize: 25),),

                const SizedBox(height: 20),
                const Text('Origin', style: TextStyle(fontSize: 25),),

            ])
          )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
   
  final String name;
  final String imageURL;
  const _CustomAppBar(
    {
      Key? key,
      required this.name,
      required this.imageURL
    }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      pinned: true,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(name),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(imageURL),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _BasicInformation extends StatelessWidget {
   
  final Character character;
  const _BasicInformation(
    {
      Key? key,
      required this.character
    }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InfoItem(label: 'id', value: character.id.toString()),

              if (character.type.isNotEmpty)
                InfoItem(label: 'Type', value: character.type),

              InfoItem(label: 'Species', value: character.species.name),
              InfoItem(label: 'Gender', value: character.gender.name),
              InfoItem(label: 'Status', value: character.status.name),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InfoItem(label: 'Created', value: character.created.toString()),
            ]
          )
        ],
      ),
    );
  }
}

class _EpisodesGrid extends StatelessWidget {
   
  const _EpisodesGrid({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final episodeProvider = Provider.of<EpisodeProvider>(context);

    return Container(
      height: 150,
      color: Colors.red,
      child: ListView.builder(
        // controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: episodeProvider.onDisplayItems.length,
        itemBuilder: (context, index) => _EpisodePoster(name: episodeProvider.onDisplayItems[index].name),
      ),
    );
  }
}

class _EpisodePoster extends StatelessWidget {
    final String name;
    const _EpisodePoster({Key? key, required this.name}) : super(key: key);
  
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
                    name,
                    maxLines: 4,
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
