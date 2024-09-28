
import 'package:editing_app/edit_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min, // Aligns the column to the center
        children: [
          IconButton(
            icon: const Icon(
              Icons.upload_file,size:40.0,
            ),
            onPressed: () async {
              XFile? file = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );
              if (file != null) {
                // ignore: use_build_context_synchronously
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditImageScreen(
                    selectedImage: file.path,
                  ),
                ));
              }
            },
          ),
          const SizedBox(height: 8), // space between the icon and text
          const Text('Upload Image From Gallery'), // label
        ],
      ),
    ),
  );
}
}