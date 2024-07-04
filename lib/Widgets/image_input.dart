import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({
    super.key,
    required this.onPickImage,
  });

  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _takePicture(String? tapped) async {
    final imagePicker = ImagePicker();
    if (tapped == 'camera') {
      final pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera,
        // maxWidth: 600,
      );

      if (pickedImage == null) {
        return;
      }

      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    } else {
      final pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery,
        // maxWidth: 600,
      );

      if (pickedImage == null) {
        return;
      }

      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }

    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton.icon(
          onPressed: () {
            _takePicture('camera');
          },
          label: const Text('Camera'),
          icon: const Icon(Icons.camera_alt_rounded),
        ),
        TextButton.icon(
          onPressed: () {
            _takePicture(null);
          },
          label: const Text('Choose Photo'),
          icon: const Icon(Icons.filter),
        ),
      ],
    );

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: () {
          _takePicture('camera');
        },
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          filterQuality: FilterQuality.medium,
        ),
      );
    }

    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(
        top: 8,
        bottom: 12,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}
