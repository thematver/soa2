// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'musicband.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: type=lint
final class _$Musicband extends Musicband {
  _$Musicband([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = Musicband;

  @override
  Future<Response<MusicBand>> _musicbandsPost(
      {required MusicBandWithoutID? body}) {
    final Uri $url = Uri.parse('/musicbands');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<MusicBand, MusicBand>($request);
  }

  @override
  Future<Response<List<MusicBand>>> _musicbandsGet({
    String? sortBy,
    String? order,
    String? filterBy,
    String? filterValue,
    int? pageSize,
    int? pageNumber,
  }) {
    final Uri $url = Uri.parse('/musicbands');
    final Map<String, dynamic> $params = <String, dynamic>{
      'sortBy': sortBy,
      'order': order,
      'filterBy': filterBy,
      'filterValue': filterValue,
      'pageSize': pageSize,
      'pageNumber': pageNumber,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<MusicBand>, MusicBand>($request);
  }

  @override
  Future<Response<MusicBand>> _musicbandsIdGet({required int? id}) {
    final Uri $url = Uri.parse('/musicbands/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<MusicBand, MusicBand>($request);
  }

  @override
  Future<Response<MusicBand>> _musicbandsIdPut({
    required int? id,
    required MusicBandWithoutID? body,
  }) {
    final Uri $url = Uri.parse('/musicbands/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<MusicBand, MusicBand>($request);
  }

  @override
  Future<Response<dynamic>> _musicbandsIdDelete({required int? id}) {
    final Uri $url = Uri.parse('/musicbands/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _musicbandsFilterDelete(
      {required int? numberOfParticipants}) {
    final Uri $url = Uri.parse('/musicbands/filter');
    final Map<String, dynamic> $params = <String, dynamic>{
      'numberOfParticipants': numberOfParticipants
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _musicbandsFilterFirstDelete(
      {required int? numberOfParticipants}) {
    final Uri $url = Uri.parse('/musicbands/filter/first');
    final Map<String, dynamic> $params = <String, dynamic>{
      'numberOfParticipants': numberOfParticipants
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<MusicbandsCountGet$Response>> _musicbandsCountGet(
      {required int? numberOfParticipants}) {
    final Uri $url = Uri.parse('/musicbands/count');
    final Map<String, dynamic> $params = <String, dynamic>{
      'numberOfParticipants': numberOfParticipants
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<MusicbandsCountGet$Response,
        MusicbandsCountGet$Response>($request);
  }

  @override
  Future<Response<List<MusicBand>>> _grammyBandsGetByGenreGenreGet(
      {required String? genre}) {
    final Uri $url = Uri.parse('/grammy/bands/get-by-genre/${genre}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<MusicBand>, MusicBand>($request);
  }

  @override
  Future<Response<dynamic>> _grammyBandsBandIdNominateGenrePost({
    required int? bandId,
    required String? genre,
  }) {
    final Uri $url = Uri.parse('/grammy/bands/${bandId}/nominate/${genre}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
