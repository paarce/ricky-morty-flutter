import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';
import 'package:ricky_morty/models/episode_response.dart';

class CardSwiper extends StatelessWidget {
  final List<Episode> episodes;
  final Function(Episode) filterCharacters;

  const CardSwiper({
    Key? key,
    required this.episodes,
    required this.filterCharacters
    }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: episodes.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => filterCharacters(episodes[index]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                color: Colors.grey,
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Episodes: ${episodes[index].episode}"),
                    Text("${episodes[index].characters.length} characters"),
                    const SizedBox(height: 10,),
                    Text(episodes[index].name, style: const TextStyle(fontSize: 20, color: Colors.amber),),
                    const SizedBox(height: 10,),
                    Text(episodes[index].airDate, style: const TextStyle(fontSize: 8),)
                  ],
                ),
              )
            ),
          );
        },
      ),
    );
  }
}

// FadeInImage(
//                 placeholder:  AssetImage('assets/no-image.jpg'),
//                 image: NetworkImage('https://via.placeholder.com/300x400'),
//                 fit: BoxFit.cover,
//               ),