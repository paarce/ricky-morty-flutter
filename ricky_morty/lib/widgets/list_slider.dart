import 'package:flutter/material.dart';

import 'package:ricky_morty/models/character_response.dart';

class ListSlider extends StatefulWidget {
   
  final List<Character> characters;
  final String? title;

  final Function onNextPage;
  final Function clearFilter;

  const ListSlider({
    Key? key,
    required this.characters, 
    required this.onNextPage,
    required this.clearFilter,
    this.title
    }) : super(key: key);

  @override
  State<ListSlider> createState() => _ListSliderState();
}

class _ListSliderState extends State<ListSlider> {

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >= (scrollController.position.maxScrollExtent - 500)) {
       widget.onNextPage(); 
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    bool showClear =  widget.title != "Lista" ;

    return Container(
      width: double.infinity,
      height: 290,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          if (widget.title != null) 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title!, 
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  
                  if (showClear)
                    TextButton(
                      onPressed: () => widget.clearFilter(),
                      child: const Text('Clear')
                    )
                ],),
            ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.characters.length,
              itemBuilder: (context, index) => _ItemPoster(character: widget.characters[index],),
            ),
          )
        ],
      ),
    );
  }
}

class _ItemPoster extends StatelessWidget {
    final Character character;
    const _ItemPoster({Key? key, required this.character}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return Container(
      width: 130,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [

          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'detail', arguments: 'detail-instance'),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(character.image),
              fit: BoxFit.cover,
              width: 130,
              height: 170,
            ),
          ),
          const SizedBox(height: 5,),
          Text(
            '${character.name} (${character.type} - ${character.status})',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          )
        ]
      ),
    );
  }
}