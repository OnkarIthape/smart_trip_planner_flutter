import 'package:flutter/material.dart';
import '../../data/local/isar_service.dart';
import '../../data/models/itinerary_model.dart';
import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ItineraryModel>> _tripsFuture;

  @override
  void initState() {
    super.initState();
    _tripsFuture = IsarService.getAllTrips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Smart Trip Planner")),
      body: Column(
        children: [
          const SizedBox(height: 20),
          ElevatedButton(
            child: const Text("Plan a New Trip"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChatScreen()),
              );
            },
          ),
          const SizedBox(height: 20),
          const Text("Saved Trips", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            child: FutureBuilder<List<ItineraryModel>>(
              future: _tripsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No saved trips"));
                }

                final trips = snapshot.data!;
                return ListView.builder(
                  itemCount: trips.length,
                  itemBuilder: (context, index) {
                    final trip = trips[index];
                    return ListTile(
                      title: Text(trip.title),
                      subtitle: Text("${trip.startDate} → ${trip.endDate}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await IsarService.deleteTrip(trip.id!);
                          setState(() {
                            _tripsFuture = IsarService.getAllTrips();
                          });
                        },
                      ),
                      onTap: () {
                        // TODO: Navigate to trip detail screen
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
