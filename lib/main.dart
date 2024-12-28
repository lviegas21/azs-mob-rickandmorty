import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/rick_morty/presentation/bloc/characters/characters_bloc.dart';
import 'features/rick_morty/presentation/bloc/episodes/episodes_bloc.dart';
import 'features/rick_morty/presentation/pages/episodes/episodes_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<EpisodesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<CharactersBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Rick and Morty Episodes',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          cardTheme: const CardTheme(
            elevation: 2,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ),
        home: const EpisodesPage(),
      ),
    );
  }
}
