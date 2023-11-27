import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:soa_frontend/generated/musicband.swagger.dart';
import 'package:logger/logger.dart';

class ItemPage extends StatefulWidget {
  final MusicBand? musicBand;

  const ItemPage({super.key, required this.musicBand});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final Logger log = Logger();
  final _formKey = GlobalKey<FormState>();
  final client = Musicband.create(baseUrl: Uri.parse("https://localhost:8444/soa-first-0.0.1-SNAPSHOT"));
  final grammyClient = Musicband.create(baseUrl: Uri.parse("https://localhost:6367/Grammy_war"));
  var isCreationForm = false;
  late MusicBand musicBand;

  @override
  void initState() {
    super.initState();
    musicBand = widget.musicBand ?? const MusicBand();
    isCreationForm = musicBand.id == null;
    log.i('Экран инициализирован группой: ${musicBand.toJson()}');
  }

  @override
  Widget build(BuildContext context) {

    log.d('Режим ${isCreationForm ? "создания" : "редактирования"} группы.');

    return _buildScaffold(isCreationForm);
  }

  Scaffold _buildScaffold(bool isCreationForm) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isCreationForm ? 'Добавить группу' : 'Редактировать группу'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: _buildNameField(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: _buildParticipantsField(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: _buildGenreDropdown(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: _buildStudioField(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: _buildCoordinatesFields(),
                  ),
                  const SizedBox(height: 20), // You may adjust or keep this SizedBox as is
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: _buildSubmitAndDeleteButtons(isCreationForm),
                  ),
                  _buildNominateButton(), // Assuming this button appears conditionally
                ],
              ),

            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildNameField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Название группы",
        border: OutlineInputBorder(),
      ),
      initialValue: musicBand.name,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Введите название группы';
        }
        return null;
      },
      onChanged: (newValue) {
        musicBand = musicBand.copyWith(name: newValue);
      },
    );
  }

  TextFormField _buildParticipantsField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Количество участников",
        border: OutlineInputBorder(),
      ),
      initialValue: musicBand.numberOfParticipants?.toString(),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Введите количество участников';
        }
        if (int.tryParse(value) == null) {
          return 'Введите корректное число';
        }
        return null;
      },
      onChanged: (newValue) {
        musicBand = musicBand.copyWith(
          numberOfParticipants: int.tryParse(newValue),
        );
      },
    );
  }

  DropdownButtonFormField<MusicGenre> _buildGenreDropdown() {
    return DropdownButtonFormField<MusicGenre>(
      decoration: const InputDecoration(
        labelText: "Жанр",
        border: OutlineInputBorder(),
      ),
      value: musicBand.genre,
      validator: (value) {
        if (value == null) {
          return 'Выберите жанр';
        }
        return null;
      },
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
    );
  }

  TextFormField _buildStudioField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Название студии",
        border: OutlineInputBorder(),
      ),
      initialValue: musicBand.studio?.name,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Введите название студии';
        }
        return null;
      },
      onChanged: (newValue) {
        musicBand = musicBand.copyWith(
          studio: Studio(name: newValue),
        );
      },
    );
  }

  Row _buildCoordinatesFields() {
    return Row(
      children: <Widget>[
        Expanded(
          child: _buildCoordinateField(
            labelText: "X координата",
            value: musicBand.coordinates?.x.toString(),
            isXCoordinate: true,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildCoordinateField(
            labelText: "Y координата",
            value: musicBand.coordinates?.y.toString(),
            isXCoordinate: false,
          ),
        ),
      ],
    );
  }

  TextFormField _buildCoordinateField({required String labelText, String? value, required bool isXCoordinate}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      initialValue: value,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Введите координату';
        }
        if (double.tryParse(value) == null) {
          return 'Введите корректное число';
        }
        return null;
      },
      onChanged: (newValue) {
        var coordinates = musicBand.coordinates ?? const Coordinates();
        coordinates = isXCoordinate
            ? coordinates.copyWith(x: double.tryParse(newValue))
            : coordinates.copyWith(y: double.tryParse(newValue));
        musicBand = musicBand.copyWith(coordinates: coordinates);
      },
    );
  }

  Row _buildSubmitAndDeleteButtons(bool isCreationForm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: onPressSubmit,
          child: Text(isCreationForm ? "Создать" : "Обновить"),
        ),
        if (!isCreationForm)
          ElevatedButton(
            onPressed: onPressDelete,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Удалить"),
          ),
      ],
    );
  }

  Widget _buildNominateButton() {
    return Visibility(
      visible: !isCreationForm && !(musicBand.nominatedToGrammy ?? false),
      child: ElevatedButton(
        onPressed: nominateToGrammy,
        child: const Text("Выдвинуть на Грэмми"),
      ),
    );
  }


Future<void> nominateToGrammy() async {
  if (musicBand.nominatedToGrammy ?? false) {
    showToast("Эта группа уже номинирована");
    return;
  }

  try {
   await grammyClient.grammyBandsBandIdNominateGenrePost(
        bandId: musicBand.id,
        genre: musicBand.genre
    );
   WidgetsBinding.instance.addPostFrameCallback((_) {
     showToast("Группа успешно номинирована");
   });

   log.i("Номинирована группа на Гремми: ${musicBand.name}");

   Navigator.of(context).pop(true);

  } catch (e) {
    showToast("Ошибка при номинации: $e", isError: true);
    log.e("Ошибка при номинации: $e");
  }
}

void onPressSubmit() async {
  if (!_formKey.currentState!.validate()) {
    showToast("Пожалуйста, заполните поля корректно", isError: true);
    return;
  }

  try {
    if (musicBand.id == null) {
      await createMusicBand();
    } else {
      await updateMusicBand();
    }

      Navigator.of(context).pop(true);
    log.i("Группа обновлена!");
  } catch (e) {
    showToast("Ошибка: $e", isError: true);
    log.e("Ошибка: $e");
  }
}

void onPressDelete() async {
  try {
    await client.musicbandsIdDelete(id: musicBand.id!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showToast("Группа успешно удалена.");
    });

    Navigator.of(context).pop(true);
    log.i("Группа успешно удалена.");
  } catch (e) {

    showToast("Ошибка: $e", isError: true);
    log.e("Ошибка: $e");
  }
}

Future<void> createMusicBand() async {
  try {
    await client.musicbandsPost(
        body: MusicBandWithoutID.fromJson(musicBand.toJson())
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showToast("Группа успешно создана.");
    });
    log.i("Группа успешно создана.");
  } catch (e) {
    showToast("Ошибка: $e", isError: true);
    log.e("Ошибка при создании группы: $e");
  }
}

Future<void> updateMusicBand() async {
  try {
    await client.musicbandsIdPut(
        id: musicBand.id,
        body: MusicBandWithoutID.fromJson(musicBand.toJson())
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showToast("Группа успешно обновлена.");
    });

    log.i("Группа успешно обновлена.");
  } catch (e) {
    showToast("Ошибка: $e", isError: true);
    log.e("Ошибка при удалении группы: $e");
  }
}

void showToast(String message, {bool isError = false}) {
  MotionToast toast = isError ?
  MotionToast.error(
    title: const Text("Ошибка"),
    description: Text(message),
  ) :
  MotionToast.success(
    description: Text(message),
  );

  toast.show(context);
  log.d("Показан тост: $message");
}
}