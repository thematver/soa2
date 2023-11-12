// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'musicband.models.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicBand _$MusicBandFromJson(Map<String, dynamic> json) => MusicBand(
      id: json['id'] as int?,
      name: json['name'] as String?,
      coordinates: json['coordinates'] == null
          ? null
          : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
      creationDate: json['creationDate'] == null
          ? null
          : DateTime.parse(json['creationDate'] as String),
      numberOfParticipants: json['numberOfParticipants'] as int?,
      genre: musicGenreNullableFromJson(json['genre']),
      studio: json['studio'] == null
          ? null
          : Studio.fromJson(json['studio'] as Map<String, dynamic>),
      nominatedToGrammy: json['nominatedToGrammy'] as bool? ?? false,
    );

Map<String, dynamic> _$MusicBandToJson(MusicBand instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coordinates': instance.coordinates?.toJson(),
      'creationDate': _dateToJson(instance.creationDate),
      'numberOfParticipants': instance.numberOfParticipants,
      'genre': musicGenreNullableToJson(instance.genre),
      'studio': instance.studio?.toJson(),
      'nominatedToGrammy': instance.nominatedToGrammy,
    };

MusicBandWithoutID _$MusicBandWithoutIDFromJson(Map<String, dynamic> json) =>
    MusicBandWithoutID(
      name: json['name'] as String?,
      coordinates: json['coordinates'] == null
          ? null
          : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
      numberOfParticipants: json['numberOfParticipants'] as int?,
      genre: musicGenreNullableFromJson(json['genre']),
      studio: json['studio'] == null
          ? null
          : Studio.fromJson(json['studio'] as Map<String, dynamic>),
      nominatedToGrammy: json['nominatedToGrammy'] as bool? ?? false,
    );

Map<String, dynamic> _$MusicBandWithoutIDToJson(MusicBandWithoutID instance) =>
    <String, dynamic>{
      'name': instance.name,
      'coordinates': instance.coordinates?.toJson(),
      'numberOfParticipants': instance.numberOfParticipants,
      'genre': musicGenreNullableToJson(instance.genre),
      'studio': instance.studio?.toJson(),
      'nominatedToGrammy': instance.nominatedToGrammy,
    };

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) => Coordinates(
      x: (json['x'] as num?)?.toDouble(),
      y: (json['y'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CoordinatesToJson(Coordinates instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
    };

Studio _$StudioFromJson(Map<String, dynamic> json) => Studio(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$StudioToJson(Studio instance) => <String, dynamic>{
      'name': instance.name,
    };

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) =>
    ErrorResponse(
      errorCode: json['errorCode'] as String,
      errorMessage: json['errorMessage'] as String,
    );

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
      'errorMessage': instance.errorMessage,
    };

MusicbandsCountGet$Response _$MusicbandsCountGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    MusicbandsCountGet$Response(
      count: json['count'] as int?,
    );

Map<String, dynamic> _$MusicbandsCountGet$ResponseToJson(
        MusicbandsCountGet$Response instance) =>
    <String, dynamic>{
      'count': instance.count,
    };
