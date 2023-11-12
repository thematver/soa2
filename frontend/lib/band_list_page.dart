import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soa_frontend/generated/musicband.swagger.dart';
import 'item_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
class BandsListPage extends StatefulWidget {
  const BandsListPage({super.key, required this.title});

  final String title;

  @override
  State<BandsListPage> createState() => _BandsListPageState();
}

class _BandsListPageState extends State<BandsListPage> {
  final client = Musicband.create(baseUrl: Uri.parse("http://0.0.0.0:8080"));
  Future<List<MusicBand>>? futureBands;
  TextEditingController numberOfParticipantsController = TextEditingController();
  MusicGenre? selectedGenre;
  String countResult = '';

  @override
  void initState() {
    super.initState();
    refreshBands();
  }

  void refreshBands() {
    setState(() {
      futureBands = fetchBands();
    });
  }

  void showToast(String message, {bool isError = false}) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: isError ? Colors.red : Colors.green,
      textColor: Colors.white,
    );
  }

  Future<List<MusicBand>> fetchBands({MusicGenre? genre}) async {
    print("FETCH");
    var response;
    if (genre != null) {
      response =  await client.musicbandsGet(filterBy: "genre", filterValue: genre.value);

    } else {
      response = await client.musicbandsGet();
    }

    if (response.statusCode == 200) {
      showToast("Найдено: " + response.body.length.toString());
      print("TEST" + response.body.toString());
      return response.body ?? [];
    } else if (response.statusCode == 404) {
      showToast("Ничего не найдено", isError: false);
      return [];
    } else {
      showToast("Произошла ошибка", isError:  true);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          _buildFilterSection(),
          if (countResult.isNotEmpty) Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Count: $countResult"),
          ),
          Expanded(
            child: FutureBuilder<List<MusicBand>>(
              future: futureBands,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return _BandsListView(bands: snapshot.data ?? [], refreshHandler: refreshBands);
                } else {
                  return const Text('No data found');
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ItemPage(musicBand: null)),
          );
          if (result == true) {
            refreshBands();
          }
        },
        tooltip: 'Add Band',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: numberOfParticipantsController,
                  decoration: const InputDecoration(hintText: "Number of Participants"),
                  keyboardType: TextInputType.number,
                ),
              ),
              ElevatedButton(
                onPressed: _deleteAllWithGivenParticipants,
                child: const Text("Delete All"),
              ),
              ElevatedButton(
                onPressed: _deleteFirstWithGivenParticipants,
                child: const Text("Delete First"),
              ),
              ElevatedButton(
                onPressed: _getCountWithGivenParticipants,
                child: const Text("Get Count"),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<MusicGenre>(
                  value: selectedGenre,
                  onChanged: (newValue) {
                    setState(() {
                      selectedGenre = newValue;
                    });
                  },
                  items: MusicGenre.values.map((MusicGenre genre) {
                    return DropdownMenuItem<MusicGenre>(
                      value: genre,
                      child: Text(genre.value ?? ""),
                    );
                  }).toList(),
                ),
              ),
              ElevatedButton(
                onPressed: _filterByGenre,
                child: const Text("Filter"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _deleteAllWithGivenParticipants() async {
    // Dummy implementation for deletion
    // Replace with actual API call
    print("Delete all with number of participants: ${numberOfParticipantsController.text}");
    client.musicbandsFilterDelete(numberOfParticipants: int.parse(numberOfParticipantsController.text)).then((value) =>
        refreshBands()
    );
  }

  Future<void> _deleteFirstWithGivenParticipants() async {
    // Dummy implementation for deletion
    // Replace with actual API call
    print("Delete first with number of participants: ${numberOfParticipantsController.text}");
    client.musicbandsFilterFirstDelete(numberOfParticipants: int.parse(numberOfParticipantsController.text)).then((value) =>
        refreshBands()
    );

  }

  Future<void> _getCountWithGivenParticipants() async {
    // Dummy implementation for count
    // Replace with actual API call
    print("Get count with number of participants: ${numberOfParticipantsController.text}");
    client.musicbandsCountGet(numberOfParticipants: int.parse(numberOfParticipantsController.text)).then((value) =>
        setState(() {
          countResult = value.body!.count.toString(); // Dummy count result, replace with actual result
        }));

  }

  Future<void> _filterByGenre() async {
    // Dummy implementation for filtering
    // Replace with actual API call
    print("Filter bands by genre: ${selectedGenre.toString()}");

    setState(() {
      futureBands = fetchBands(genre: selectedGenre);
    });



  }
}

class _BandsListView extends StatelessWidget {
  const _BandsListView({super.key, required this.bands, required this.refreshHandler});

  final List<MusicBand> bands;
  final VoidCallback refreshHandler;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bands.length,
      itemBuilder: (context, index) {
        final band = bands[index];
        return ListTile(
          title: Text(band.name ?? "Unnamed Band"),
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ItemPage(musicBand: band)),
            );
            if (result == true) {
              refreshHandler();
            }
          },
        );
      },
    );
  }
}
