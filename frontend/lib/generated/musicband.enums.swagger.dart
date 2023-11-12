import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

enum MusicGenre {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('HIP_HOP')
  hipHop('Хип-хоп'),
  @JsonValue('BLUES')
  blues('Блюз'),
  @JsonValue('POST_ROCK')
  postRock('Пост-рок');

  final String? value;

  const MusicGenre(this.value);
}

enum MusicBandsGetOrder {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('asc')
  asc('asc'),
  @JsonValue('desc')
  desc('desc');

  final String? value;

  const MusicBandsGetOrder(this.value);
}
