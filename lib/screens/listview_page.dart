import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mayunseen/models/unseen_model.dart';

class ListViewPage extends StatefulWidget {
  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
// Explict ตัวแปร

  List<UnseenModel> unseenModels =
      []; //สร้างตัวแปรArraylist ของ model UnseenModel

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
      List<DocumentSnapshot> snapshots =
          response.documents; //เอา Snapshot มาเปน array

      //วนค่าArrayออกมาก่อน
      for (var snapshot in snapshots) {
        // String name = snapshot.data['Name'];
        // print('name = $name');

        //ผูกกับ model
        UnseenModel unseenModel = UnseenModel(
            snapshot.data['Name'],
            snapshot.data['Detail'],
            snapshot.data['UrlPicture'],
            snapshot.data['Code'],
            snapshot.data['Lat'],
            snapshot.data['Lng']);

        setState(() {
          unseenModels.add(unseenModel);
        });
      }
    });
  }

//image
  Widget showPicture(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.4,
      child: Image.network(unseenModels[index].urlPicture),
    );
  }

//Text
  Widget showText(int index) {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            unseenModels[index].name,
            style: TextStyle(fontSize: 20.0, color: Colors.red),
          ),
          Text(
            unseenModels[index].detail,
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: unseenModels.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: <Widget>[showPicture(index), showText(index)],
        );
      },
    );
  }
}
