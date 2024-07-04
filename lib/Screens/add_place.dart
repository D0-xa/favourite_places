import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/Widgets/image_input.dart';
import 'package:favourite_places/Widgets/location_input.dart';
import 'package:favourite_places/Models/place.dart';

class AddPlaceScreen extends ConsumerWidget {
  const AddPlaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formkey = GlobalKey<FormState>();
    var enteredTitle = '';
    File? selectedImage;
    PlaceLocation? selectedLocation;

    return Hero(
      tag: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add new Place'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return 'Must be between 1 to 50 characters long';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    enteredTitle = newValue!.trim();
                  },
                ),
                ImageInput(
                  onPickImage: (image) {
                    selectedImage = image;
                  },
                ),
                LocationInput(
                  onSelectLocation: (location) {
                    selectedLocation = location;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (formkey.currentState!.validate() &&
                        selectedImage != null &&
                        selectedLocation != null) {
                      formkey.currentState!.save();
                      ref.read(userPlacesProvider.notifier).addPlace(
                            enteredTitle,
                            selectedImage!,
                            selectedLocation!,
                          );
                      Navigator.of(context).pop();
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Place'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
