import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; //import puglin กล้อง
import 'package:location/location.dart'; //import puglin location

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  // ประกาศตัวแปร
  File file;
  double lat = 0, lng = 0;
  bool imageBool = false; //ตัวแปรcheck รูปมีค่าไม
  final formKey = GlobalKey<FormState>(); //validate formไม่่ให้มีค่าว่าง
  String name, detail, code, urlPicture;

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
        cameraThread();
      },
    );
  }

//Thread Camera
  Future<void> cameraThread() async {
    var imageObject = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      file = imageObject;
      imageBool = false;
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
      imageBool = true;
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
        onSaved: (String value) {
          name = value.trim();
        },
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
        onSaved: (String value) {
          detail = value.trim();
        },
      ),
    );
  }

  //Call function
  @override
  void initState() {
    super.initState();
    findLatLng();
    createCode();
  }

  //Threat open service Locaiton
  Future<LocationData> findLocationData() async {
    var location = Location();

    try {
      return await location.getLocation();
    } catch (e) {
      print('Error= $e');
      return null;
    }
  }

  //Threat Lat Lon
  Future<void> findLatLng() async {
    var currentLocation = await findLocationData();

    if (currentLocation == null) {
      myAlert(
          'Permission Check Location', 'Please turn on loctionatio service');
    } else {
      setState(() {
        lat = currentLocation.latitude;
        lng = currentLocation.longitude;
      });
    }
  }

  // Lat
  Widget showLat() {
    return Column(
      children: <Widget>[
        Text(
          'Latitude',
          style: TextStyle(fontSize: 20.0),
        ),
        Text('$lat')
      ],
    );
  }

  // lng
  Widget showLng() {
    return Column(
      children: <Widget>[
        Text(
          'Longtitude',
          style: TextStyle(fontSize: 20.0),
        ),
        Text('$lng')
      ],
    );
  }

  //upload
  Widget uploadValueButton() {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.cloud_upload),
            onPressed: () {
              if (imageBool) {
                formKey.currentState.save(); // check validate ค่าจาก Form
                //validate
                if ((name.isEmpty) || (detail.isEmpty)) {
                  myAlert('No Input', 'Please input data every Blank');
                } else {
                  //print input
                  print(
                      'name = $name,detail = $detail,lat = $lat,lng = $lng,code = $code');

                  //upload image
                  //call Theard uploadFileToStorage
                  uploadFileToStorage();
                }
              } else {
                myAlert('Non Choose Image',
                    'Please Choose Image From Gallery or Take a photo');
              }
            },
          ),
        ],
      ),
    );
  }

//Thead uploadimage to Storage Firebase
  Future uploadFileToStorage() async {
    String namePicture = '$code.jpg'; //ชื่อรูปเอาค่าจาก RandomID ex. code1234

    FirebaseStorage firebaseStorage =
        FirebaseStorage.instance; //สร้างยามไปเชื่อมไปStorage Firebase
    StorageReference storageReference = firebaseStorage
        .ref()
        .child('Picture/$namePicture'); //เอาไฟล์ไปลง path pictureของ firebase
    StorageUploadTask storageUploadTask =
        storageReference.putFile(file); //push fileรูปที่ประกาสไว้ข้างบนมาใส่

    //uploadแล้วดึงเอาไฟล์รูป urlPicture เก็บลงฐานข้อมูล
    //uploadจนสำเร็จก่อน แล้วเอาค่า urlมา มาจาก response
    await (await storageUploadTask.onComplete)
        .ref
        .getDownloadURL()
        .then((response) {
      urlPicture = response;
      print('urlpic = $urlPicture');
    });
  }

// Alert
  void myAlert(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  //Create code

  void createCode() {
    int randInt = Random().nextInt(10000); //แรนด้อมไม่เกิน 10000
    code = 'code$randInt';
  }

//////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey, // warp with form : validate formไม่่ให้มีค่าว่าง
      child: ListView(
        padding: EdgeInsets.only(bottom: 50.0, right: 10.0),
        children: <Widget>[
          showImage(),
          showButton(),
          nameText(),
          detailText(),
          SizedBox(
            height: 20.0,
          ),
          showLat(),
          showLng(),
          uploadValueButton(),
        ],
      ),
    );
  }
}
