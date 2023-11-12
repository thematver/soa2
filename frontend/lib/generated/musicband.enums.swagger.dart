import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

enum MusicGenre {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('HIP_HOP')
  hipHop('HIP_HOP'),
  @JsonValue('BLUES')
  blues('BLUES'),
  @JsonValue('POST_ROCK')
  postRock('POST_ROCK');

  final String? value;

  const MusicGenre(this.value);
}

enum MusicbandsGetOrder {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('asc')
  asc('asc'),
  @JsonValue('desc')
  desc('desc');

  final String? value;

  const MusicbandsGetOrder(this.value);
}
