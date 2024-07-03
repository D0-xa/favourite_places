import 'package:favourite_places/provider/places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Places',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(places[index].title),
          titleTextStyle: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
