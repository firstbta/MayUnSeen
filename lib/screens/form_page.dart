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

  //

  //รูป
  Widget showImage() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      height: 200.0,
      child:
          file == null ? Image.asset('images/noimage.png') : Image.file(file),
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
  Future<void> cametaThread() async {
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
  Future<void> galleryThread() async {
    var imageObject = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      file = imageObject;
    });
  }

//Input Name
  Widget nameText() {
    return Container(
      margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 50.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Name : ',
          // helperText: 'Type your Display Name',
          hintText: 'Type your Display Name',
          icon: Icon(Icons.face),
        ),
      ),
    );
  }

  //Input Detail
  Widget detailText() {
    return Container(
      margin: EdgeInsets.only(left: 50.0, right: 50.0),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: 2,
        decoration: InputDecoration(
          labelText: 'Detail : ',
          // helperText: 'Type your Detail',
          hintText: 'Type your Detail',
          icon: Icon(Icons.info),
        ),
      ),
    );
  }

//////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        showImage(),
        showButton(),
        nameText(),
        detailText(),
      ],
    );
  }
}
