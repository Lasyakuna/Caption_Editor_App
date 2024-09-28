// ignore_for_file: library_private_types_in_public_api

import "dart:io";
import "dart:typed_data";
import "package:editing_app/default_button.dart";
import "package:editing_app/edit_image_screen.dart";
import "package:editing_app/text_info.dart";
import "package:editing_app/utils.dart";
import "package:flutter/material.dart";
import "package:image_gallery_saver/image_gallery_saver.dart";
import "package:permission_handler/permission_handler.dart";
import 'package:screenshot/screenshot.dart'; 
import 'package:image_picker/image_picker.dart';

abstract class EditImageViewmodel extends State<EditImageScreen>{
 TextEditingController textEditingController = TextEditingController();
 TextEditingController creatorText = TextEditingController();
 ScreenshotController screenshotController = ScreenshotController();


  List<TextInfo> texts = [];
  // ignore: non_constant_identifier_names
  int CurrentIndex = -1;



saveToGallery(BuildContext context) {
  if(texts.isNotEmpty){
    screenshotController.capture().then((Uint8List? image){
     saveImage(image!);
     // ignore: use_build_context_synchronously
     ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Image saved to gallery."
        ),
        ),
        );
    // ignore: invalid_return_type_for_catch_error, avoid_print
    }).catchError((err) => print(err));
  }
}

saveImage(Uint8List bytes) async {
  final time=DateTime.now().toIso8601String().replaceAll(".", "-").replaceAll(":", "-");
  final name = "screenshot_$time";
  await requestPermission(Permission.storage);
  await ImageGallerySaver.saveImage(bytes, name: name);
}

removeText(BuildContext context){
  setState(() {
    texts.removeAt(CurrentIndex);
  });
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(
        "Deleted",
        style: TextStyle(
          fontSize:16.0
           ),
          ),
    ),
    );
}



setCurrentIndex(BuildContext context,index){
  setState(() {
    CurrentIndex=index;
  });
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(
        "Selected For Styling",
        style: TextStyle(
          fontSize:16.0
           ),
          ),
    ),
    );
}

changeTextColor(Color color){
  setState(() {
    texts[CurrentIndex].color=color;
  });
}//this will change the color of the text 

increaseFontSize  ( ){
  setState(() {
    texts[CurrentIndex].fontSize+=2;
  });//this will increase the font size with increment of 2
}

decreaseFontSize  ( ){
  setState(() {
    texts[CurrentIndex].fontSize-=2;
  });//this will decrease the font size with decrement of 2
}
alignLeft ( ){
  setState(() {
    texts[CurrentIndex].textAlign=TextAlign.left;
  });
}
alignRight ( ){
  setState(() {
    texts[CurrentIndex].textAlign=TextAlign.right;
  });
}
alignCenter ( ){
  setState(() {
    texts[CurrentIndex].textAlign=TextAlign.center;
  });
}

boldText(){
  setState(() {//if its bold , it will change it to normal , iff not , it will change to bold 
    if(texts[CurrentIndex].fontWeight==FontWeight.bold){
      texts[CurrentIndex].fontWeight=FontWeight.normal;
    }
    else{
      texts[CurrentIndex].fontWeight=FontWeight.bold;
    }

  });
}

italicText(){// same as bold
  setState(() {
    if(texts[CurrentIndex].fontStyle==FontStyle.italic){
      texts[CurrentIndex].fontStyle=FontStyle.normal;
    }
    else{
      texts[CurrentIndex].fontStyle=FontStyle.italic;
    }

  });
}

addLinesToText() {// if it detects a space , the text will be placed in the next line 
  setState(() {
    if( texts[CurrentIndex].text.contains("\n")){
    texts[CurrentIndex].text=texts[CurrentIndex].text.replaceAll("\n", " ");  
    }else {
    texts[CurrentIndex].text=texts[CurrentIndex].text.replaceAll(" ", "\n");
    }
  });
}


 addNewText(BuildContext context){
  final screenSize = MediaQuery.of(context).size;
  setState(() {
    texts.add(
      TextInfo(
        text:textEditingController.text,
        left: 50, // the text will be added on the screen at this position 
        top: 50,
        color:Colors.black,
        fontWeight:FontWeight.normal,
        fontStyle: FontStyle.normal,
       fontSize:20,
        textAlign:TextAlign.left,
        ),
        );
        Navigator.of(context).pop();
  });
 }
  addNewDialog(context){
    showDialog(
      context: context,
       builder: (BuildContext context) => AlertDialog(
        title: const Text("Add New Text",),
        content:TextField(
          controller:textEditingController ,
          maxLines: 5,
          decoration:const InputDecoration(
            suffixIcon: Icon(Icons.edit,),
            filled: true,
            hintText: 'Your Text Here..',
          ),
        ) ,
        actions:<Widget> [
          DefaultButton(
          onPressed : () => addNewText(context), //text button
          // ignore: sort_child_properties_last
          child: const Text("Add Text",), 
          color: const Color.fromARGB(255, 184, 52, 207), 
          textColor: Colors.black
          )
        ],
       ));
  }
  
 
  
    
}

