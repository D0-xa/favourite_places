import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favourite_places/Screens/add_place.dart';
import 'package:favourite_places/Widgets/places_list.dart';
import 'package:favourite_places/providers/user_places.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(userPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
      ),
      body: FutureBuilder(
        future: _placesFuture,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : PlacesList(
                    places: userPlaces,
                  ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          right: 20,
          bottom: 24,
        ),
        child: FloatingActionButton(
          heroTag: 1,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddPlaceScreen(),
              ),
            );
          },
          tooltip: 'Add a place',
          child: const Icon(Icons.add_a_photo_outlined),
        ),
      ),
    );
  }
}
