import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/itinerary_model.dart';

class IsarService {
  static late Isar _isar;

  /// Call this once in main()
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [ItineraryModelSchema],
      directory: dir.path,
    );
  }

  /// Save or update a trip
  static Future<void> saveTrip(ItineraryModel model) async {
    await _isar.writeTxn(() async {
      await _isar.itineraryModels.put(model); // upsert
    });
  }

  /// Load all saved trips
  static Future<List<ItineraryModel>> getAllTrips() async {
    return await _isar.itineraryModels.where().findAll();
  }

  /// Delete trip by ID
  static Future<void> deleteTrip(int id) async {
    await _isar.writeTxn(() async {
      await _isar.itineraryModels.delete(id);
    });
  }
}
