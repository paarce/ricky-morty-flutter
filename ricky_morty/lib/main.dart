import 'package:flutter/material.dart';
import 'package:ricky_morty/providers/character_provider.dart';
import 'package:ricky_morty/providers/episodes_provider.dart';
import 'package:ricky_morty/screens/screens.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
   
  const AppState({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EpisodeProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => CharacterProvider(), lazy: false),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ricky & Morty',
      initialRoute:  'home',
      routes: {
        'home': (_) => const HomeScreen(),
        'detail': (_) => const DetailScreen(),
      },
    );
  }
}
