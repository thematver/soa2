// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'musicband.models.swagger.dart';
import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:chopper/chopper.dart' as chopper;
import 'musicband.enums.swagger.dart' as enums;
export 'musicband.enums.swagger.dart';
export 'musicband.models.swagger.dart';

part 'musicband.swagger.chopper.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class Musicband extends ChopperService {
  static Musicband create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    Converter? converter,
    Uri? baseUrl,
    Iterable<dynamic>? interceptors,
  }) {
    if (client != null) {
      return _$Musicband(client);
    }

    final newClient = ChopperClient(
        services: [_$Musicband()],
        converter: converter ?? $JsonSerializableConverter(),
        interceptors: interceptors ?? [],
        client: httpClient,
        authenticator: authenticator,
        baseUrl: baseUrl ?? Uri.parse('https://'));
    return _$Musicband(newClient);
  }

  ///Создать группу.
  Future<chopper.Response<MusicBand>> musicbandsPost(
      {required MusicBandWithoutID? body}) {
    generatedMapping.putIfAbsent(MusicBand, () => MusicBand.fromJsonFactory);

    return _musicbandsPost(body: body);
  }

  ///Создать группу.
  @Post(
    path: '/musicbands',
    optionalBody: true,
  )
  Future<chopper.Response<MusicBand>> _musicbandsPost(
      {@Body() required MusicBandWithoutID? body});

  ///Получить список групп.
  ///@param sortBy Поле для сортировки
  ///@param order Направление сортировки (asc или desc)
  ///@param filterBy Поле для фильтрации
  ///@param filterValue Значение для фильтрации
  ///@param pageSize � азмер страницы для пагинации
  ///@param pageNumber Номер страницы для пагинации
  Future<chopper.Response<List<MusicBand>>> musicbandsGet({
    String? sortBy,
    enums.MusicbandsGetOrder? order,
    String? filterBy,
    String? filterValue,
    int? pageSize,
    int? pageNumber,
  }) {
    generatedMapping.putIfAbsent(MusicBand, () => MusicBand.fromJsonFactory);

    return _musicbandsGet(
        sortBy: sortBy,
        order: order?.value?.toString(),
        filterBy: filterBy,
        filterValue: filterValue,
        pageSize: pageSize,
        pageNumber: pageNumber);
  }

  ///Получить список групп.
  ///@param sortBy Поле для сортировки
  ///@param order Направление сортировки (asc или desc)
  ///@param filterBy Поле для фильтрации
  ///@param filterValue Значение для фильтрации
  ///@param pageSize � азмер страницы для пагинации
  ///@param pageNumber Номер страницы для пагинации
  @Get(path: '/musicbands')
  Future<chopper.Response<List<MusicBand>>> _musicbandsGet({
    @Query('sortBy') String? sortBy,
    @Query('order') String? order,
    @Query('filterBy') String? filterBy,
    @Query('filterValue') String? filterValue,
    @Query('pageSize') int? pageSize,
    @Query('pageNumber') int? pageNumber,
  });

  ///Получить группу.
  ///@param id
  Future<chopper.Response<MusicBand>> musicbandsIdGet({required int? id}) {
    generatedMapping.putIfAbsent(MusicBand, () => MusicBand.fromJsonFactory);

    return _musicbandsIdGet(id: id);
  }

  ///Получить группу.
  ///@param id
  @Get(path: '/musicbands/{id}')
  Future<chopper.Response<MusicBand>> _musicbandsIdGet(
      {@Path('id') required int? id});

  ///Обновить группу.
  ///@param id
  Future<chopper.Response<MusicBand>> musicbandsIdPut({
    required int? id,
    required MusicBandWithoutID? body,
  }) {
    generatedMapping.putIfAbsent(MusicBand, () => MusicBand.fromJsonFactory);

    return _musicbandsIdPut(id: id, body: body);
  }

  ///Обновить группу.
  ///@param id
  @Put(
    path: '/musicbands/{id}',
    optionalBody: true,
  )
  Future<chopper.Response<MusicBand>> _musicbandsIdPut({
    @Path('id') required int? id,
    @Body() required MusicBandWithoutID? body,
  });

  ///Удалить группу по айди.
  ///@param id
  Future<chopper.Response> musicbandsIdDelete({required int? id}) {
    return _musicbandsIdDelete(id: id);
  }

  ///Удалить группу по айди.
  ///@param id
  @Delete(path: '/musicbands/{id}')
  Future<chopper.Response> _musicbandsIdDelete({@Path('id') required int? id});

  ///Удалить все объекты с заданным значением numberOfParticipants.
  ///@param numberOfParticipants
  Future<chopper.Response> musicbandsFilterDelete(
      {required int? numberOfParticipants}) {
    return _musicbandsFilterDelete(numberOfParticipants: numberOfParticipants);
  }

  ///Удалить все объекты с заданным значением numberOfParticipants.
  ///@param numberOfParticipants
  @Delete(path: '/musicbands/filter')
  Future<chopper.Response> _musicbandsFilterDelete(
      {@Query('numberOfParticipants') required int? numberOfParticipants});

  ///Удалить один объект с заданным значением numberOfParticipants.
  ///@param numberOfParticipants
  Future<chopper.Response> musicbandsFilterFirstDelete(
      {required int? numberOfParticipants}) {
    return _musicbandsFilterFirstDelete(
        numberOfParticipants: numberOfParticipants);
  }

  ///Удалить один объект с заданным значением numberOfParticipants.
  ///@param numberOfParticipants
  @Delete(path: '/musicbands/filter/first')
  Future<chopper.Response> _musicbandsFilterFirstDelete(
      {@Query('numberOfParticipants') required int? numberOfParticipants});

  ///Получить количество объектов с заданным значением numberOfParticipants.
  ///@param numberOfParticipants
  Future<chopper.Response<MusicbandsCountGet$Response>> musicbandsCountGet(
      {required int? numberOfParticipants}) {
    generatedMapping.putIfAbsent(MusicbandsCountGet$Response,
        () => MusicbandsCountGet$Response.fromJsonFactory);

    return _musicbandsCountGet(numberOfParticipants: numberOfParticipants);
  }

  ///Получить количество объектов с заданным значением numberOfParticipants.
  ///@param numberOfParticipants
  @Get(path: '/musicbands/count')
  Future<chopper.Response<MusicbandsCountGet$Response>> _musicbandsCountGet(
      {@Query('numberOfParticipants') required int? numberOfParticipants});

  ///Получить список групп по жанру.
  ///@param genre
  Future<chopper.Response<List<MusicBand>>> grammyBandsGetByGenreGenreGet(
      {required enums.MusicGenre? genre}) {
    generatedMapping.putIfAbsent(MusicBand, () => MusicBand.fromJsonFactory);

    return _grammyBandsGetByGenreGenreGet(genre: genre?.value?.toString());
  }

  ///Получить список групп по жанру.
  ///@param genre
  @Get(path: '/grammy/bands/get-by-genre/{genre}')
  Future<chopper.Response<List<MusicBand>>> _grammyBandsGetByGenreGenreGet(
      {@Path('genre') required String? genre});

  ///Номинировать группу на премию.
  ///@param band-id
  ///@param genre
  Future<chopper.Response> grammyBandsBandIdNominateGenrePost({
    required int? bandId,
    required enums.MusicGenre? genre,
  }) {
    return _grammyBandsBandIdNominateGenrePost(
        bandId: bandId, genre: genre?.value?.toString());
  }

  ///Номинировать группу на премию.
  ///@param band-id
  ///@param genre
  @Post(
    path: '/grammy/bands/{band-id}/nominate/{genre}',
    optionalBody: true,
  )
  Future<chopper.Response> _grammyBandsBandIdNominateGenrePost({
    @Path('band-id') required int? bandId,
    @Path('genre') required String? genre,
  });
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
      chopper.Response response) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
          body: DateTime.parse((response.body as String).replaceAll('"', ''))
              as ResultType);
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);
