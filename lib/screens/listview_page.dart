import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListViewPage extends StatefulWidget {
  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
// Explict ตัวแปร

// Method

//intState
  @override
  void initState() {
    super.initState();
    readDataFireStore();
  }

//Thead read data
  Future<void> readDataFireStore() async {
    Firestore firestore = Firestore.instance; //สร้างตัวเชื่อมไม่firestore
    CollectionReference collectionReference = firestore.collection('UnSeen');
//snapshot -ข้อมูลเป็น Array listen เป็นการอ่านไม่ต้อวรอให้ข้อมูลครบ ถยอยมาแสดงก่อน
    await collectionReference.snapshots().listen((response) {

      List<DocumentSnapshot> snapshots = response.documents; //เอา Snapshot มาเปน array

      //วนค่าArrayออกมาก่อน
      for (var snapshot in snapshots) {
        String name = snapshot.data['Name'];
        print('name = $name');
        
      }

    });
  }

////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Text('This is ListView Page');
  }
}
