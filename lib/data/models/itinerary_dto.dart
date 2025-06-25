import 'package:json_annotation/json_annotation.dart';

part 'itinerary_dto.g.dart';

@JsonSerializable()
class ItineraryDTO {
  final String title;
  final String startDate;
  final String endDate;
  final List<ItineraryDayDTO> days;

  ItineraryDTO({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.days,
  });

  factory ItineraryDTO.fromJson(Map<String, dynamic> json) =>
      _$ItineraryDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ItineraryDTOToJson(this);
}

@JsonSerializable()
class ItineraryDayDTO {
  final String date;
  final String summary;
  final List<ItineraryItemDTO> items;

  ItineraryDayDTO({
    required this.date,
    required this.summary,
    required this.items,
  });

  factory ItineraryDayDTO.fromJson(Map<String, dynamic> json) =>
      _$ItineraryDayDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ItineraryDayDTOToJson(this);
}

@JsonSerializable()
class ItineraryItemDTO {
  final String time;
  final String activity;
  final String location;

  ItineraryItemDTO({
    required this.time,
    required this.activity,
    required this.location,
  });

  factory ItineraryItemDTO.fromJson(Map<String, dynamic> json) =>
      _$ItineraryItemDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ItineraryItemDTOToJson(this);
}
