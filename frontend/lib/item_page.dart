import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soa_frontend/generated/musicband.swagger.dart';

class ItemPage extends StatefulWidget {
  final MusicBand? musicBand;

  const ItemPage({super.key, required this.musicBand});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final _formKey = GlobalKey<FormState>();
  final client = Musicband.create(baseUrl: Uri.parse("http://0.0.0.0:8080"));
  final grammyClient = Musicband.create(baseUrl: Uri.parse("http://localhost:8081/Grammy-1.0-SNAPSHOT"));

  late MusicBand musicBand;

  @override
  void initState() {
    super.initState();
    musicBand = widget.musicBand ?? MusicBand();
    print(musicBand.nominatedToGrammy);
  }

  @override
  Widget build(BuildContext context) {
    bool isCreationForm = musicBand.id == null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isCreationForm ? 'Add Band' : 'Edit Band'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Text Form Fields for band details
                  TextFormField(
                    decoration: const InputDecoration(hintText: "Название группы"),
                    initialValue: musicBand.name,
                    onChanged: (newValue) {
                      musicBand = musicBand.copyWith(name: newValue);
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: "Количество участников"),
                    initialValue: musicBand.numberOfParticipants?.toString(),
                    onChanged: (newValue) {
                      musicBand = musicBand.copyWith(
                        numberOfParticipants: int.tryParse(newValue),
                      );
                    },
                  ),
                  DropdownButtonFormField<MusicGenre>(
                    decoration: const InputDecoration(hintText: "Жанр"),
                    value: musicBand.genre,
                    onChanged: (MusicGenre? newValue) {
                      setState(() {
                        musicBand = musicBand.copyWith(genre: newValue);
                      });
                    },
                    items: MusicGenre.values.map((MusicGenre genre) {
                      return DropdownMenuItem<MusicGenre>(
                        value: genre,
                        child: Text(genre.value ?? ""),
                      );
                    }).toList(),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: "Название студии"),
                    initialValue: musicBand.studio?.name,
                    onChanged: (newValue) {
                      musicBand = musicBand.copyWith(
                        studio: Studio(name: newValue),
                      );
                    },
                  ),

                  // Text Form Fields for coordinates
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(hintText: "X"),
                          initialValue: musicBand.coordinates?.x.toString(),
                          onChanged: (newValue) {
                            var coordinates = musicBand.coordinates ?? Coordinates();
                            coordinates = coordinates.copyWith(x: double.tryParse(newValue));
                            musicBand = musicBand.copyWith(coordinates: coordinates);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(hintText: "Y"),
                          initialValue: musicBand.coordinates?.y.toString(),
                          onChanged: (newValue) {
                            var coordinates = musicBand.coordinates ?? Coordinates();
                            coordinates = coordinates.copyWith(y: double.tryParse(newValue));
                            musicBand = musicBand.copyWith(coordinates: coordinates);
                          },
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    // Buttons for submit and delete
                    ElevatedButton(
                      onPressed: onPressSubmit,
                      child: Text(isCreationForm ? "Создать" : "Обновить"),
                    ),
                    if (!isCreationForm)
                      ElevatedButton(
                        onPressed: onPressDelete,
                        child: const Text("Удалить"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                      ),
                  ],),
                  SizedBox(height: 20),
                  // Nominate to Grammy button
                  if (!isCreationForm && !(musicBand.nominatedToGrammy ?? false))
                  ElevatedButton(
                    onPressed: nominateToGrammy,
                    child: const Text("Nominate to Grammy"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> nominateToGrammy() async {
    if (musicBand.nominatedToGrammy ?? false) {
      showToast("This band is already nominated for a Grammy");
      return;
    }

    try {
      var result = await grammyClient.grammyBandBandIdNominateGenrePost(bandId: musicBand.id, genre: musicBand.genre);
      print(result.error);
      showToast("Nominated to Grammy successfully");
      setState(() {
        musicBand = musicBand.copyWith(nominatedToGrammy: true);
      });
    } catch (e) {
      showToast("Error nominating to Grammy: $e", isError: true);
    }
  }


  void onPressSubmit() async {
    try {
      if (musicBand.id == null) {
        await createMusicBand();
      } else {
        await updateMusicBand();
      }
      showToast("Operation successful");
      Navigator.of(context).pop(true);
    } catch (e) {
      showToast("Error: $e", isError: true);
    }
  }

  void onPressDelete() async {
    try {
      await client.musicbandsIdDelete(id: musicBand.id!);
      showToast("Music Band deleted successfully");
    } catch (e) {
      showToast("Error: $e", isError: true);
    }
  }

  Future<void> createMusicBand() async {
    try {
      await client.musicbandsPost(body: MusicBandWithoutID.fromJson(musicBand.toJson()));
      showToast("Music Band created successfully");
    } catch (e) {
      showToast("Error: $e", isError: true);
    }
  }

  Future<void> updateMusicBand() async {
    try {
      await client.musicbandsIdPut(id: musicBand.id, body: MusicBandWithoutID.fromJson(musicBand.toJson()));
      showToast("Music Band updated successfully");
    } catch (e) {
      showToast("Error: $e", isError: true);
    }
  }

  void showToast(String message, {bool isError = false}) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: isError ? Colors.red : Colors.green,
      textColor: Colors.white,
    );
  }
}
