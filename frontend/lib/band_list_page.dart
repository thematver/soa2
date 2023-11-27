import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:soa_frontend/generated/musicband.swagger.dart';
import 'item_page.dart';

class BandsListPage extends StatefulWidget {
  const BandsListPage({super.key, required this.title});
  final String title;



  @override
  State<BandsListPage> createState() => _BandsListPageState();
}

class _BandsListPageState extends State<BandsListPage> {
  int currentPage = 0;
  bool hasMoreData = true;
  MusicbandsGetOrder sortOrder = MusicbandsGetOrder.asc;

  final Logger log = Logger( printer: PrettyPrinter(
    methodCount: 0,
  ),);
  var client = Musicband.create(
      baseUrl: Uri.parse("https://localhost:8444/soa-first-0.0.1-SNAPSHOT"));
  final grammyClient = Musicband.create(baseUrl: Uri.parse("https://localhost:6367/Grammy_war"));
  Future<List<MusicBand>>? futureBands;
  TextEditingController numberOfParticipantsController = TextEditingController();
  MusicGenre? selectedGenre;
  bool isGrammyFiltered = false;


  @override
  void initState() {
    super.initState();
    _refreshBands();
  }

  // Refreshes the list of bands
  void _refreshBands() {
    setState(() {
      currentPage = 0;
      hasMoreData = true;
      futureBands = _fetchBands(pageNumber: currentPage, sortOrder: sortOrder);
    });
    log.i("Список групп обновлен");
  }

  // Fetches bands with optional filters
  Future<List<MusicBand>> _fetchBands(
      {MusicbandsGetOrder? sortOrder = MusicbandsGetOrder
          .asc, String? sortBy = "name", int? pageNumber = 0, int? pageSize = 10, String? filterBy, String? filterValue}) async {
    try {
      var response = await client.musicbandsGet(filterBy: filterBy,
          filterValue: filterValue,
          sortBy: sortBy,
          order: sortOrder,
          pageNumber: pageNumber,
          pageSize: pageSize);


      if (response.statusCode == 200) {
        log.i("Загружено ${response.body?.length} групп");
        if (response.body != null && response.body!.length < pageSize!) {
          hasMoreData = false;
        } else {
          currentPage++;
        }
        return response.body ?? [];
      } else if (response.statusCode == 404 ) {
        _showToast("Ничего не найдено", isError: false);
        log.i("Ничего не найдено.");
        hasMoreData = false;
        return [];
      }
      else {
        hasMoreData = false;
        _showToast("Ошибка: ${response.statusCode}", isError: true);
        log.e("Ошибка при загрузке: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      hasMoreData = false;
      _showToast("Случилась ошибка", isError: true);
      log.e("Ошибка при загрузке групп: $e");
      return [];
    }
  }

  // Displays a toast message
  void _showToast(String message, {bool isError = false}) {

    if (isError) {
      MotionToast.error(
          title:  const Text("Ошибка"),
          description:  Text(message)
      ).show(context);
    } else {
      MotionToast.success(
        title:  const Text("Успех"),
        description:  Text(message),
      ).show(context);

    }

    log.d("Показан тост: $message");
  }
  void _toggleSortOrder() {

    setState(() {
      sortOrder = sortOrder == MusicbandsGetOrder.asc ? MusicbandsGetOrder.desc : MusicbandsGetOrder.asc;
      _refreshBands();
    });
    log.i("Порядок сортировки изменен: $sortOrder");
  }

  // Builds the main UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(sortOrder == MusicbandsGetOrder.asc ? Icons.arrow_downward : Icons.arrow_upward),
            onPressed: _toggleSortOrder,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterSection(),
          Expanded(child: _buildBandsList()),
        ],
      ),
      floatingActionButton: _buildAddBandButton(),
    );
  }

  Widget _buildSortOrderButton() {
    return IconButton(
      icon: Icon(sortOrder == MusicbandsGetOrder.asc ? Icons.arrow_upward : Icons.arrow_downward),
      onPressed: () {
        setState(() {
          sortOrder = sortOrder == MusicbandsGetOrder.asc ? MusicbandsGetOrder.desc : MusicbandsGetOrder.asc;
          _refreshBands();
        });
      },
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
                  decoration: const InputDecoration(
                      hintText: "Количество участников"),
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (_) => _applyFilter(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:8.0),
                    child: ElevatedButton(
                      onPressed: _deleteAll,
                      child: const Text("Удалить все"),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal:8.0),
                      child:ElevatedButton(
                        onPressed: _deleteFirst,
                        child: const Text("Удалить первую"),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal:8.0),
                      child:ElevatedButton(
                        onPressed: _count,
                        child: const Text("Показать количество"),
                      )),
                ],
              ),
            ],
          ),
          DropdownButtonFormField<MusicGenre>(
            value: selectedGenre,
            hint: const Text("Фильтр по жанру"),
            onChanged: (newValue) {
              setState(() {
                selectedGenre = newValue;
                _applyGenreFilter();
              });
            },
            items: MusicGenre.values.map((MusicGenre genre) {
              return DropdownMenuItem<MusicGenre>(
                value: genre,

                child: Text(genre.value ?? ""),
              );
            }).toList(),
          ),
          CheckboxListTile(
            title: const Text("С гремми"),
            value: isGrammyFiltered,
            onChanged: (bool? value) {
              setState(() {
                isGrammyFiltered = value ?? false;
                _applyGenreFilter();
              });
            },
          ),
        ],
      ),
    );
  }

  void _applyFilter() {
    String participantCount = numberOfParticipantsController.text;
    log.i("Фильтруем по количеству участников: $participantCount");

    if (!_validateParticipantCount(participantCount)) {
      log.w("Некорректное количество участников: $participantCount");
      _showToast("Некорректное количество участников", isError: true);
      return;
    }

    setState(() {
      futureBands = _fetchBands(filterBy: "numerOfParticipants", filterValue: participantCount);
    });
  }

  void _applyGenreFilter() {
    if (selectedGenre == null) {
      log.w("Жанр не выбран или некорректен");
      _showToast("Выберите корректный жанр", isError: true);
      return;
    }


    if (selectedGenre == MusicGenre.swaggerGeneratedUnknown) {
      _refreshBands();
      return;
    }

    log.i("Фильтруем группы по жанру: ${selectedGenre.toString()}");


    if (isGrammyFiltered) {
      _fetchGrammyBandsByGenre();
    } else {
      setState(() {
        futureBands =
            _fetchBands(filterBy: "genre", filterValue: selectedGenre!.value!);
      });
    }
  }

  Future<void> _fetchGrammyBandsByGenre() async {
    try {
      var response = await grammyClient.grammyBandsGetByGenreGenreGet(genre: selectedGenre);
      setState(() {
        futureBands = Future.value(response.body);
      });
      log.i("Загружено ${response.body?.length} групп с Грэмми");
    } catch (e) {
      log.e("Ошибка при загрузке групп с Грэмми: $e");
      _showToast("Ошибка при загрузке", isError: true);
    }
  }

  Future<void> _deleteAll() async {
    String participantCount = numberOfParticipantsController.text;
    log.i("Удаляем все группы с числом участников, равным $participantCount");

    if (!_validateParticipantCount(participantCount)) {
      log.w("Неправильное количество участников: $participantCount");
      _showToast("Некорректное количество участников", isError: true);
      return;
    }

    try {
      await client.musicbandsFilterDelete(numberOfParticipants: int.parse(participantCount));
      _refreshBands();
      log.i("Успешно удалены все группы с числом участников, равным $participantCount");
    } catch (e) {
      log.e("Ошибка при удалении всех групп: $e");
      _showToast("Случилась ошибка при удалении", isError: true);
    }
  }

  Future<void> _count() async {
    String participantCount = numberOfParticipantsController.text;
    log.i("Получаем количество всех групп с числом участников, равным $participantCount");

    if (!_validateParticipantCount(participantCount)) {
      log.w("Некорректное число участников: $participantCount");
      _showToast("Некорректное число участников", isError: true);
      return;
    }

    try {
      var response = await client.musicbandsCountGet(numberOfParticipants: int.parse(participantCount));
      var countResult = response.body!.count.toString();
      _showToast("Количество групп с таким числом участников: $countResult");
      log.i("Количество групп с числом участников $participantCount равно $countResult");
    } catch (e) {
      log.e("Ошибка при получении количества: $e");
      _showToast("Ошибка при получении количества", isError: true);
    }
  }


  // Builds the list of bands
  Widget _buildBandsList() {
    return FutureBuilder<List<MusicBand>>(
      future: futureBands,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          log.e("Ошибка в FutureBuilder: ${snapshot.error}");
          return Text('Ошибка: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return _BandsListView(
              bands: snapshot.data ?? [], refreshHandler: _refreshBands);
        } else {
          log.w("Нет данных в FutureBuilder");
          return const Text('No data found');
        }
      },
    );
  }

  // Builds the "Add Band" floating action button
  Widget _buildAddBandButton() {
    return FloatingActionButton(
      onPressed: () async {
        log.i("Переход на страницу создания новой группы");
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ItemPage(musicBand: null)),
        );
        if (result == true) {
          _refreshBands();
        }
      },
      tooltip: 'Добавить группу',
      child: const Icon(Icons.add),
    );
  }

  Future<void> _deleteFirst() async {
    String participantCount = numberOfParticipantsController.text;
    log.i("Попытка удалить первую группу с числом участников, равным $participantCount");

    if (!_validateParticipantCount(participantCount)) {
      log.w("Некорректное число участников: $participantCount");
      _showToast("Некорректное число участников", isError: true);
      return;
    }

    try {
      await client.musicbandsFilterFirstDelete(numberOfParticipants: int.parse(participantCount));
      _refreshBands();
      log.i("Успешно удалили все группы  с числом участников, равным $participantCount");
    } catch (e) {
      log.e("Ошибка при удалении первой группы: $e");
      _showToast("Случилась ошибка!", isError: true);
    }
  }


// Utility function to validate participant count
  bool _validateParticipantCount(String participantCount) {
    if (participantCount.isEmpty) return false;
    return int.tryParse(participantCount) != null;
  }
}

class _BandsListView extends StatelessWidget {
  final List<MusicBand> bands;
  final VoidCallback refreshHandler;
  final ScrollController scrollController = ScrollController();

  _BandsListView({required this.bands, required this.refreshHandler}) {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      refreshHandler();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: bands.length,
      itemBuilder: (context, index) {
        final band = bands[index];
        return ListTile(
          title: Text(band.name ?? "Группа без названия"),
          subtitle: Text("Участники: ${band.numberOfParticipants}, жанр: ${band.genre?.value ?? 'неизвестно'}"),
          trailing: Icon(
            band.nominatedToGrammy ?? false ? Icons.check_circle : null,
            color: band.nominatedToGrammy ?? false ? Colors.green : null,
          ),
          onTap: () async {
            Logger().i("Выбрана группа: ${band.name}");
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
