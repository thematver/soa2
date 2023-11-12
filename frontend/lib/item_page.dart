import 'package:flutter/material.dart';
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

  MusicBand? musicBand;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.musicBand != null) {
      this.musicBand = widget.musicBand;
      print(musicBand);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Row(
            children: [
              const Spacer(flex: 1),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: "Название группы"),
                      initialValue: musicBand?.name,
                    ),
                    TextFormField(
                        initialValue:
                            musicBand?.numberOfParticipants?.toString(),
                        decoration: const InputDecoration(
                            hintText: "Количество участников")),
                    DropdownButtonFormField<MusicGenre>(
                      decoration: InputDecoration(
                        hintText: "Жанр"
                      ),
                        value: musicBand?.genre,

                        onChanged: (MusicGenre? newValue) {
                          setState(() {});
                          },
                        items: MusicGenre.values.map((MusicGenre genre) {
                          return DropdownMenuItem<MusicGenre>(
                              value: genre,
                              child: Text(genre.value ?? ""));
                        }).toList(),

                    ),
                    TextFormField(
                        initialValue: musicBand?.studio?.name,
                        decoration:
                            const InputDecoration(hintText: "Название студии")),
                    const SizedBox(height: 50),
                    Row(children: [
                      ElevatedButton(
                          onPressed: onPressSubmit,
                          child: musicBand == null
                              ? const Text("Создать")
                              : const Text("Обновить")),
                      musicBand != null
                          ? ElevatedButton(
                              onPressed: onPressSubmit,
                              child: const Text("Удалить"),
                            )
                          : const Spacer(),
                    ]),
                  ],
                ),
              ),
              const Spacer(flex: 1)
            ],
          )),
    );
  }

  void onChange(value) {}
  void onPressSubmit() {
    if (musicBand == null) {
      // client.musicbandsPost(body: )
    } else {
      client.musicbandsIdPut(
          id: musicBand!.id,
          body: MusicBandWithoutID.fromJson(musicBand!.toJson()));
    }
  }

  void onPressDelete() {
    client.musicbandsIdDelete(id: musicBand?.id!);
  }

  void nominate() {
    client.musicbandsIdDelete(id: musicBand?.id!);
  }
}
