// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itinerary_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItineraryDTO _$ItineraryDTOFromJson(Map<String, dynamic> json) => ItineraryDTO(
      title: json['title'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      days: (json['days'] as List<dynamic>)
          .map((e) => ItineraryDayDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItineraryDTOToJson(ItineraryDTO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'days': instance.days,
    };

ItineraryDayDTO _$ItineraryDayDTOFromJson(Map<String, dynamic> json) =>
    ItineraryDayDTO(
      date: json['date'] as String,
      summary: json['summary'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => ItineraryItemDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItineraryDayDTOToJson(ItineraryDayDTO instance) =>
    <String, dynamic>{
      'date': instance.date,
      'summary': instance.summary,
      'items': instance.items,
    };

ItineraryItemDTO _$ItineraryItemDTOFromJson(Map<String, dynamic> json) =>
    ItineraryItemDTO(
      time: json['time'] as String,
      activity: json['activity'] as String,
      location: json['location'] as String,
    );

Map<String, dynamic> _$ItineraryItemDTOToJson(ItineraryItemDTO instance) =>
    <String, dynamic>{
      'time': instance.time,
      'activity': instance.activity,
      'location': instance.location,
    };
