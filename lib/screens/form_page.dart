import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; //import puglin กล้อง

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  
  // ประกาศตัวแปร
  File file;
  

  // Method

  //รูป
  Widget showImage() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      height: 200.0,
      child: file == null ? Image.asset('images/noimage.png') : Image.file(file) ,
    );
  }

// แถวแสดงปุ่ม
  Widget showButton() {
    return Container(
      width: 200.0,
      // color: Colors.yellow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          cameraButton(),
          galleryButton(),
        ],
      ),
    );
  }

  //ปุ่มCamera
  Widget cameraButton() {
    return IconButton(
      icon: Icon(
        Icons.add_a_photo,
        size: 48.0,
        color: Colors.greenAccent,
      ),
      onPressed: () {
        cametaThread();
      },
    );
  }


//Thread Camera
  Future<void> cametaThread() async{

    var imageObject = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      file = imageObject; 
    });

  }

  //ปุ่มGallery
  Widget galleryButton() {
    return IconButton(
      icon: Icon(
        Icons.add_photo_alternate,
        size: 48.0,
        color: Colors.red,
      ),
      onPressed: () {
        galleryThread();
      },
    );
  }

  //Thread Gallery
  Future<void> galleryThread() async{

    var imageObject = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      file = imageObject; 
    });

  }

//////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        showImage(),
        showButton(),
      ],
    );
  }
}
