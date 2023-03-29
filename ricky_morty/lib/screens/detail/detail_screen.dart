import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:ricky_morty/helpers/models_helper.dart';
import 'package:provider/provider.dart';

import 'package:ricky_morty/models/character_response.dart';
import 'package:ricky_morty/models/location_response.dart';

import 'package:ricky_morty/providers/episodes_provider.dart';
import 'package:ricky_morty/providers/location_provider.dart';

import 'package:ricky_morty/widgets/widgets.dart';
import 'package:ricky_morty/screens/detail/episodes_list_widget.dart';

class DetailScreen extends StatelessWidget {

  const DetailScreen(
    {
      Key? key, 
    }
  ) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final character = ModalRoute.of(context)?.settings.arguments as Character;
    final episodeProvider = Provider.of<EpisodeProvider>(context);
    return  Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(name: character.name, imageURL: character.image),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
                _BasicInformation(character: character),

                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Episodes', style: TextStyle(fontSize: 25),),
                    ]
                  ),
                ),

                EpisodesGrid(ids: ModelHelper.getIdsFrom(character.episode), provider: episodeProvider),
                const SizedBox(height: 24),
                if (character.location.url.isNotEmpty)
                  _LocationWidget(title: "Location", locationId: character.location.id(),),

                const SizedBox(height: 24),
                if (character.origin.url.isNotEmpty)
                  _LocationWidget(title: "Origin", locationId: character.origin.id(),),
                 
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
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Text(name)
        ),
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

class _LocationWidget extends StatelessWidget {
  
  final String title;
  final String locationId;
  const _LocationWidget(
    {
      Key? key,
      required this.title,
      required this.locationId
    }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final locationProvider = Provider.of<LocationProvider>(context);

    return Container(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(title, style: const TextStyle(fontSize: 25),),
          const SizedBox(height: 8),

          FutureBuilder(
            future: locationProvider.getLocationBy(locationId),
            builder: (context, snapshot) {
              
              Location? location = snapshot.data;

              if (location == null) {
                return Container(
                  height: 150,
                  child: const CupertinoActivityIndicator(),
                );
              }

              return Text('${location.name} - ${location.type}');
              
            },
          )
        ],
      ),
    );
  }
}