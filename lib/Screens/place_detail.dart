import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favourite_places/Models/place.dart';
import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/Screens/map.dart';

class PlaceDetailScreen extends ConsumerWidget {
  const PlaceDetailScreen(this.place, {super.key});

  final Place place;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Hero(
        tag: place,
        child: Stack(
          children: [
            Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              filterQuality: FilterQuality.high,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => MapScreen(
                            location: place.location,
                          ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 70,
                      foregroundImage: NetworkImage(
                        ref
                            .read(userPlacesProvider.notifier)
                            .getLocationImage(place),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black87,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 24,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      place.location.address,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
