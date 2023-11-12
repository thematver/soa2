import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:soa_frontend/generated/musicband.swagger.dart';
import 'package:soa_frontend/item_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Bands',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BandsListPage(title: 'Music Bands'),
    );
  }
}

class BandsListPage extends StatefulWidget {
  const BandsListPage({super.key, required this.title});

  final String title;

  @override
  State<BandsListPage> createState() => _BandsListPageState();
}

class _BandsListPageState extends State<BandsListPage> {

  final client = Musicband.create(baseUrl: Uri.parse("http://0.0.0.0:8080"));

  void _addBand() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ItemPage(musicBand: null)),
    );
  }

  Future<List<MusicBand>> fetchBands() async {
    final response = await client.musicBandsGet();
    if (response.statusCode == 200) {
      return response.body ?? [];
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child:
          FutureBuilder<List<MusicBand>>(
            future: fetchBands(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _BandsListView(bands: snapshot.data ?? []);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          )
    ), floatingActionButton: FloatingActionButton(
      onPressed: _addBand,
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    )
    );
  }
}

class _BandsListView extends StatelessWidget {
  const _BandsListView({super.key, required this.bands});

  final List<MusicBand> bands;

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: bands
            .map((e) => ListTile(
            title: Text(e.name ?? "Безымянная группа"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemPage(musicBand: e)));
            })).toList());
  }
}


