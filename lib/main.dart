import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:entrevista_pop/utils/app_routes.dart';
import 'package:entrevista_pop/providers/characters.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:entrevista_pop/screens/character_detail_screen.dart';
import 'package:entrevista_pop/screens/screen_navigate_bottom.dart';

import 'package:entrevista_pop/utils/functions.dart';
import 'package:entrevista_pop/utils/constants.dart';

import 'providers/character.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(CharacterAdapter());

  await Hive.openBox<Character>(Constants.favoritesBox);
  await Hive.openBox<Map<dynamic, dynamic>>(Constants.charactersListBox);
  await Hive.openBox<String>(Constants.favoritesApiRequestCountBox);
  await Hive.openBox<Character>(Constants.favoritesApiFaieldRequestsBox);

  runApp(
    ChangeNotifierProvider(
      create: (_) => Characters(),
      child: StarWarsWikiApp(),
    ),
  );

  resendFaieldRequests();
}

class StarWarsWikiApp extends StatefulWidget {
  @override
  _StarWarsWikiAppState createState() => _StarWarsWikiAppState();
}

class _StarWarsWikiAppState extends State<StarWarsWikiApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Hive.close();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Wars Wiki',
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.yellow[600],
      ),
      home: NavigateBottomScreen(),
      routes: {
        AppRoutes.CHARACTER_DETAIL: (ctx) => CharacterDetailScreen(),
      },
    );
  }
}
