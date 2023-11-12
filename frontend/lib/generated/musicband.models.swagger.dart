// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'musicband.enums.swagger.dart' as enums;

part 'musicband.models.swagger.g.dart';

@JsonSerializable(explicitToJson: true)
class MusicBand {
  const MusicBand({
    this.id,
    this.name,
    this.coordinates,
    this.creationDate,
    this.numberOfParticipants,
    this.genre,
    this.studio,
  });

  factory MusicBand.fromJson(Map<String, dynamic> json) =>
      _$MusicBandFromJson(json);

  static const toJsonFactory = _$MusicBandToJson;
  Map<String, dynamic> toJson() => _$MusicBandToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'coordinates')
  final Coordinates? coordinates;
  @JsonKey(name: 'creationDate', toJson: _dateToJson)
  final DateTime? creationDate;
  @JsonKey(name: 'numberOfParticipants')
  final int? numberOfParticipants;
  @JsonKey(
    name: 'genre',
    toJson: musicGenreNullableToJson,
    fromJson: musicGenreNullableFromJson,
  )
  final enums.MusicGenre? genre;
  @JsonKey(name: 'studio')
  final Studio? studio;
  static const fromJsonFactory = _$MusicBandFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MusicBand &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.coordinates, coordinates) ||
                const DeepCollectionEquality()
                    .equals(other.coordinates, coordinates)) &&
            (identical(other.creationDate, creationDate) ||
                const DeepCollectionEquality()
                    .equals(other.creationDate, creationDate)) &&
            (identical(other.numberOfParticipants, numberOfParticipants) ||
                const DeepCollectionEquality().equals(
                    other.numberOfParticipants, numberOfParticipants)) &&
            (identical(other.genre, genre) ||
                const DeepCollectionEquality().equals(other.genre, genre)) &&
            (identical(other.studio, studio) ||
                const DeepCollectionEquality().equals(other.studio, studio)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(coordinates) ^
      const DeepCollectionEquality().hash(creationDate) ^
      const DeepCollectionEquality().hash(numberOfParticipants) ^
      const DeepCollectionEquality().hash(genre) ^
      const DeepCollectionEquality().hash(studio) ^
      runtimeType.hashCode;
}

extension $MusicBandExtension on MusicBand {
  MusicBand copyWith(
      {int? id,
      String? name,
      Coordinates? coordinates,
      DateTime? creationDate,
      int? numberOfParticipants,
      enums.MusicGenre? genre,
      Studio? studio}) {
    return MusicBand(
        id: id ?? this.id,
        name: name ?? this.name,
        coordinates: coordinates ?? this.coordinates,
        creationDate: creationDate ?? this.creationDate,
        numberOfParticipants: numberOfParticipants ?? this.numberOfParticipants,
        genre: genre ?? this.genre,
        studio: studio ?? this.studio);
  }

  MusicBand copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<String?>? name,
      Wrapped<Coordinates?>? coordinates,
      Wrapped<DateTime?>? creationDate,
      Wrapped<int?>? numberOfParticipants,
      Wrapped<enums.MusicGenre?>? genre,
      Wrapped<Studio?>? studio}) {
    return MusicBand(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        coordinates:
            (coordinates != null ? coordinates.value : this.coordinates),
        creationDate:
            (creationDate != null ? creationDate.value : this.creationDate),
        numberOfParticipants: (numberOfParticipants != null
            ? numberOfParticipants.value
            : this.numberOfParticipants),
        genre: (genre != null ? genre.value : this.genre),
        studio: (studio != null ? studio.value : this.studio));
  }
}

@JsonSerializable(explicitToJson: true)
class MusicBandWithoutID {
  const MusicBandWithoutID({
    this.name,
    this.coordinates,
    this.numberOfParticipants,
    this.genre,
    this.studio,
  });

  factory MusicBandWithoutID.fromJson(Map<String, dynamic> json) =>
      _$MusicBandWithoutIDFromJson(json);

  static const toJsonFactory = _$MusicBandWithoutIDToJson;
  Map<String, dynamic> toJson() => _$MusicBandWithoutIDToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'coordinates')
  final Coordinates? coordinates;
  @JsonKey(name: 'numberOfParticipants')
  final int? numberOfParticipants;
  @JsonKey(
    name: 'genre',
    toJson: musicGenreNullableToJson,
    fromJson: musicGenreNullableFromJson,
  )
  final enums.MusicGenre? genre;
  @JsonKey(name: 'studio')
  final Studio? studio;
  static const fromJsonFactory = _$MusicBandWithoutIDFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MusicBandWithoutID &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.coordinates, coordinates) ||
                const DeepCollectionEquality()
                    .equals(other.coordinates, coordinates)) &&
            (identical(other.numberOfParticipants, numberOfParticipants) ||
                const DeepCollectionEquality().equals(
                    other.numberOfParticipants, numberOfParticipants)) &&
            (identical(other.genre, genre) ||
                const DeepCollectionEquality().equals(other.genre, genre)) &&
            (identical(other.studio, studio) ||
                const DeepCollectionEquality().equals(other.studio, studio)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(coordinates) ^
      const DeepCollectionEquality().hash(numberOfParticipants) ^
      const DeepCollectionEquality().hash(genre) ^
      const DeepCollectionEquality().hash(studio) ^
      runtimeType.hashCode;
}

extension $MusicBandWithoutIDExtension on MusicBandWithoutID {
  MusicBandWithoutID copyWith(
      {String? name,
      Coordinates? coordinates,
      int? numberOfParticipants,
      enums.MusicGenre? genre,
      Studio? studio}) {
    return MusicBandWithoutID(
        name: name ?? this.name,
        coordinates: coordinates ?? this.coordinates,
        numberOfParticipants: numberOfParticipants ?? this.numberOfParticipants,
        genre: genre ?? this.genre,
        studio: studio ?? this.studio);
  }

  MusicBandWithoutID copyWithWrapped(
      {Wrapped<String?>? name,
      Wrapped<Coordinates?>? coordinates,
      Wrapped<int?>? numberOfParticipants,
      Wrapped<enums.MusicGenre?>? genre,
      Wrapped<Studio?>? studio}) {
    return MusicBandWithoutID(
        name: (name != null ? name.value : this.name),
        coordinates:
            (coordinates != null ? coordinates.value : this.coordinates),
        numberOfParticipants: (numberOfParticipants != null
            ? numberOfParticipants.value
            : this.numberOfParticipants),
        genre: (genre != null ? genre.value : this.genre),
        studio: (studio != null ? studio.value : this.studio));
  }
}

@JsonSerializable(explicitToJson: true)
class Coordinates {
  const Coordinates({
    this.x,
    this.y,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);

  static const toJsonFactory = _$CoordinatesToJson;
  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);

  @JsonKey(name: 'x')
  final double? x;
  @JsonKey(name: 'y')
  final double? y;
  static const fromJsonFactory = _$CoordinatesFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Coordinates &&
            (identical(other.x, x) ||
                const DeepCollectionEquality().equals(other.x, x)) &&
            (identical(other.y, y) ||
                const DeepCollectionEquality().equals(other.y, y)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(x) ^
      const DeepCollectionEquality().hash(y) ^
      runtimeType.hashCode;
}

extension $CoordinatesExtension on Coordinates {
  Coordinates copyWith({double? x, double? y}) {
    return Coordinates(x: x ?? this.x, y: y ?? this.y);
  }

  Coordinates copyWithWrapped({Wrapped<double?>? x, Wrapped<double?>? y}) {
    return Coordinates(
        x: (x != null ? x.value : this.x), y: (y != null ? y.value : this.y));
  }
}

@JsonSerializable(explicitToJson: true)
class Studio {
  const Studio({
    this.name,
  });

  factory Studio.fromJson(Map<String, dynamic> json) => _$StudioFromJson(json);

  static const toJsonFactory = _$StudioToJson;
  Map<String, dynamic> toJson() => _$StudioToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  static const fromJsonFactory = _$StudioFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Studio &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^ runtimeType.hashCode;
}

extension $StudioExtension on Studio {
  Studio copyWith({String? name}) {
    return Studio(name: name ?? this.name);
  }

  Studio copyWithWrapped({Wrapped<String?>? name}) {
    return Studio(name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class ErrorResponse {
  const ErrorResponse({
    required this.errorCode,
    required this.errorMessage,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  static const toJsonFactory = _$ErrorResponseToJson;
  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);

  @JsonKey(name: 'errorCode')
  final String errorCode;
  @JsonKey(name: 'errorMessage')
  final String errorMessage;
  static const fromJsonFactory = _$ErrorResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ErrorResponse &&
            (identical(other.errorCode, errorCode) ||
                const DeepCollectionEquality()
                    .equals(other.errorCode, errorCode)) &&
            (identical(other.errorMessage, errorMessage) ||
                const DeepCollectionEquality()
                    .equals(other.errorMessage, errorMessage)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(errorCode) ^
      const DeepCollectionEquality().hash(errorMessage) ^
      runtimeType.hashCode;
}

extension $ErrorResponseExtension on ErrorResponse {
  ErrorResponse copyWith({String? errorCode, String? errorMessage}) {
    return ErrorResponse(
        errorCode: errorCode ?? this.errorCode,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  ErrorResponse copyWithWrapped(
      {Wrapped<String>? errorCode, Wrapped<String>? errorMessage}) {
    return ErrorResponse(
        errorCode: (errorCode != null ? errorCode.value : this.errorCode),
        errorMessage:
            (errorMessage != null ? errorMessage.value : this.errorMessage));
  }
}

@JsonSerializable(explicitToJson: true)
class MusicbandsCountGet$Response {
  const MusicbandsCountGet$Response({
    this.count,
  });

  factory MusicbandsCountGet$Response.fromJson(Map<String, dynamic> json) =>
      _$MusicbandsCountGet$ResponseFromJson(json);

  static const toJsonFactory = _$MusicbandsCountGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$MusicbandsCountGet$ResponseToJson(this);

  @JsonKey(name: 'count')
  final int? count;
  static const fromJsonFactory = _$MusicbandsCountGet$ResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MusicbandsCountGet$Response &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(count) ^ runtimeType.hashCode;
}

extension $MusicbandsCountGet$ResponseExtension on MusicbandsCountGet$Response {
  MusicbandsCountGet$Response copyWith({int? count}) {
    return MusicbandsCountGet$Response(count: count ?? this.count);
  }

  MusicbandsCountGet$Response copyWithWrapped({Wrapped<int?>? count}) {
    return MusicbandsCountGet$Response(
        count: (count != null ? count.value : this.count));
  }
}

String? musicGenreNullableToJson(enums.MusicGenre? musicGenre) {
  return musicGenre?.value;
}

String? musicGenreToJson(enums.MusicGenre musicGenre) {
  return musicGenre.value;
}

enums.MusicGenre musicGenreFromJson(
  Object? musicGenre, [
  enums.MusicGenre? defaultValue,
]) {
  return enums.MusicGenre.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          musicGenre?.toString().toLowerCase()) ??
      defaultValue ??
      enums.MusicGenre.swaggerGeneratedUnknown;
}

enums.MusicGenre? musicGenreNullableFromJson(
  Object? musicGenre, [
  enums.MusicGenre? defaultValue,
]) {
  if (musicGenre == null) {
    return null;
  }
  return enums.MusicGenre.values
          .firstWhereOrNull((e) => e.value == musicGenre) ??
      defaultValue;
}

List<String> musicGenreListToJson(List<enums.MusicGenre>? musicGenre) {
  if (musicGenre == null) {
    return [];
  }

  return musicGenre.map((e) => e.value!).toList();
}

List<enums.MusicGenre> musicGenreListFromJson(
  List? musicGenre, [
  List<enums.MusicGenre>? defaultValue,
]) {
  if (musicGenre == null) {
    return defaultValue ?? [];
  }

  return musicGenre.map((e) => musicGenreFromJson(e.toString())).toList();
}

List<enums.MusicGenre>? musicGenreNullableListFromJson(
  List? musicGenre, [
  List<enums.MusicGenre>? defaultValue,
]) {
  if (musicGenre == null) {
    return defaultValue;
  }

  return musicGenre.map((e) => musicGenreFromJson(e.toString())).toList();
}

String? musicBandsGetOrderNullableToJson(
    enums.MusicBandsGetOrder? musicBandsGetOrder) {
  return musicBandsGetOrder?.value;
}

String? musicBandsGetOrderToJson(enums.MusicBandsGetOrder musicBandsGetOrder) {
  return musicBandsGetOrder.value;
}

enums.MusicBandsGetOrder musicBandsGetOrderFromJson(
  Object? musicBandsGetOrder, [
  enums.MusicBandsGetOrder? defaultValue,
]) {
  return enums.MusicBandsGetOrder.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          musicBandsGetOrder?.toString().toLowerCase()) ??
      defaultValue ??
      enums.MusicBandsGetOrder.swaggerGeneratedUnknown;
}

enums.MusicBandsGetOrder? musicBandsGetOrderNullableFromJson(
  Object? musicBandsGetOrder, [
  enums.MusicBandsGetOrder? defaultValue,
]) {
  if (musicBandsGetOrder == null) {
    return null;
  }
  return enums.MusicBandsGetOrder.values
          .firstWhereOrNull((e) => e.value == musicBandsGetOrder) ??
      defaultValue;
}

List<String> musicBandsGetOrderListToJson(
    List<enums.MusicBandsGetOrder>? musicBandsGetOrder) {
  if (musicBandsGetOrder == null) {
    return [];
  }

  return musicBandsGetOrder.map((e) => e.value!).toList();
}

List<enums.MusicBandsGetOrder> musicBandsGetOrderListFromJson(
  List? musicBandsGetOrder, [
  List<enums.MusicBandsGetOrder>? defaultValue,
]) {
  if (musicBandsGetOrder == null) {
    return defaultValue ?? [];
  }

  return musicBandsGetOrder
      .map((e) => musicBandsGetOrderFromJson(e.toString()))
      .toList();
}

List<enums.MusicBandsGetOrder>? musicBandsGetOrderNullableListFromJson(
  List? musicBandsGetOrder, [
  List<enums.MusicBandsGetOrder>? defaultValue,
]) {
  if (musicBandsGetOrder == null) {
    return defaultValue;
  }

  return musicBandsGetOrder
      .map((e) => musicBandsGetOrderFromJson(e.toString()))
      .toList();
}

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}
