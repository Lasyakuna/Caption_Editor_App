import "dart:io";
import 'package:editing_app/edit_image_viewmodel.dart';
import 'package:editing_app/image_text.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';



class EditImageScreen extends StatefulWidget {
  final String selectedImage;
  const EditImageScreen({super.key, required this.selectedImage});

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}


class _EditImageScreenState extends EditImageViewmodel {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Screenshot(
        controller: screenshotController,
        child: SafeArea(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,//size of the pic to be displayed on the screen
                child: Stack(
                  children: [
                    _selectedmage,
                    for (int i = 0; i < texts.length; i++)
                      Positioned( //to drag and drop the text anywhere on the screen
                        left: texts[i].left,
                        top: texts[i].top,
                        child: GestureDetector(
                          onLongPress: () {
                            CurrentIndex = i;
                            removeText(context);
                          },
                          onTap: () => setCurrentIndex(context, i),
                          onPanUpdate: (details) {
                            setState(() {
                              // Updating the position dynamically
                              texts[i].top += details.delta.dy;
                              texts[i].left += details.delta.dx;

                              // Ensure the text stays within the screen bounds
                              texts[i].top = texts[i].top.clamp(
                                  0.0, MediaQuery.of(context).size.height);
                              texts[i].left = texts[i].left.clamp(
                                  0.0, MediaQuery.of(context).size.width);
                            });
                          },
                          child: ImageText(textInfo: texts[i]),
                        ),
                      ),
                    creatorText.text.isNotEmpty//textbox where you can add the text to be displayed on the screen
                        ? Positioned(
                            left: 0,
                            bottom: 0,
                            child: Text(
                              creatorText.text,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(
                                    0.3,
                                  )),
                            ))
                        : const SizedBox.shrink(),
                  ],
                )
                )
                ),
      ),
      floatingActionButton: _addnewTextFab,
      
    );
  }

  Widget get _selectedmage => SizedBox(
        width: MediaQuery.of(context).size.width, // Fill the entire width
        height: MediaQuery.of(context).size.height, // Fill the entire height
        child: Image.file(
          File(widget.selectedImage),
          fit: BoxFit
              .fitWidth, 
        ),
      );

  Widget get _addnewTextFab => FloatingActionButton(
        onPressed: () => addNewDialog(context),
        backgroundColor: Colors.white,
        tooltip: "Add New Text",
        child: const Icon(
          Icons.edit,
          color: Colors.black,
        ),
      );
  AppBar get _appBar => AppBar(
      backgroundColor: Colors.black,
      automaticallyImplyLeading: false,
      title: SizedBox(
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            IconButton(
              icon: const Icon(
                Icons.save,
                color: Colors.white,
              ),
              onPressed: () => saveToGallery(context),
              tooltip: "Save Image",
            ),
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: increaseFontSize,
              tooltip: "Increase Font Size",
            ),
            IconButton(
              icon: const Icon(
                Icons.remove,
                color: Colors.white,
              ),
              onPressed: decreaseFontSize,
              tooltip: "Decrease Font Size",
            ),
            IconButton(
              icon: const Icon(
                Icons.format_align_left,
                color: Colors.white,
              ),
              onPressed: alignLeft,
              tooltip: "Align Left",
            ),
            IconButton(
              icon: const Icon(
                Icons.format_align_center,
                color: Colors.white,
              ),
              onPressed: alignCenter,
              tooltip: "Align Center",
            ),
            IconButton(
              icon: const Icon(
                Icons.format_align_right,
                color: Colors.white,
              ),
              onPressed: alignRight,
              tooltip: "Align Right",
            ),
            IconButton(
              icon: const Icon(
                Icons.format_bold,
                color: Colors.white,
              ),
              onPressed: boldText,
              tooltip: "Bold",
            ),
            IconButton(
              icon: const Icon(
                Icons.format_italic,
                color: Colors.white,
              ),
              onPressed: italicText,
              tooltip: "Italic",
            ),
            IconButton(
              icon: const Icon(
                Icons.space_bar,
                color: Colors.white,
              ),
              onPressed: addLinesToText,
              tooltip: "Add New Line",
            ),
            Tooltip(
              message: "White",
              child: GestureDetector(
                onTap: () => changeTextColor(Colors.white),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Tooltip(
              message: "Black",
              child: GestureDetector(
                onTap: () => changeTextColor(Colors.black),
                child: const CircleAvatar(
                  backgroundColor: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Tooltip(
              message: "Blue",
              child: GestureDetector(
                onTap: () => changeTextColor(Colors.blue),
                child: const CircleAvatar(
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Tooltip(
              message: "Green",
              child: GestureDetector(
                onTap: () => changeTextColor(Colors.green),
                child: const CircleAvatar(
                  backgroundColor: Colors.green,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Tooltip(
              message: "Red",
              child: GestureDetector(
                onTap: () => changeTextColor(Colors.red),
                child: const CircleAvatar(
                  backgroundColor: Colors.red,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Tooltip(
              message: "Purple",
              child: GestureDetector(
                onTap: () => changeTextColor(Colors.purple),
                child: const CircleAvatar(
                  backgroundColor: Colors.purple,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Tooltip(
              message: "Yellow",
              child: GestureDetector(
                onTap: () => changeTextColor(Colors.yellow),
                child: const CircleAvatar(
                  backgroundColor: Colors.yellow,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Tooltip(
              message: "Orange",
              child: GestureDetector(
                onTap: () => changeTextColor(Colors.orange),
                child: const CircleAvatar(
                  backgroundColor: Colors.orange,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      )
      );
     
}