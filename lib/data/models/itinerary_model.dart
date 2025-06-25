
import 'package:isar/isar.dart';

part 'itinerary_model.g.dart';

@collection
class ItineraryModel {
  Id id = Isar.autoIncrement;

  late String title;
  late String startDate;
  late String endDate;

  final List<ItineraryDay> days = [];

  ItineraryModel();
}

@embedded
class ItineraryDay {
  late String date;
  late String summary;
  final List<ItineraryItem> items = [];

  ItineraryDay();
}

@embedded
class ItineraryItem {
  late String time;
  late String activity;
  late String location;

  ItineraryItem();
}
