import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favourite_places/Screens/add_place.dart';
import 'package:favourite_places/Widgets/places_list.dart';
import 'package:favourite_places/providers/user_places.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(userPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
      ),
      body: PlacesList(places: userPlaces),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          right: 20,
          bottom: 24,
        ),
        child: FloatingActionButton(
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
