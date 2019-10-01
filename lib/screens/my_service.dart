import 'package:flutter/material.dart';
import 'package:mayunseen/screens/form_page.dart';

import 'listview_page.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
// Explict ตัวแปร

  Widget currentWidget = ListViewPage(); //หน้า Defaultลิ้งค์ไปหน้า Form page

// Method

  Widget menuFormPage() {
    return ListTile(
      leading: Icon(
        Icons.filter_2,
        size: 36.0,
        color: Colors.blue,
      ),
      title: Text('Form'),
      subtitle: Text('หน้ากรอกข้อมูล'),
       onTap: () {
        Navigator.of(context).pop();
        setState(() {
         currentWidget = FormPage(); 
        });
      },
    );
  }

  Widget menuListViewPage() {
    return ListTile(
      leading: Icon(
        Icons.filter_1,
        size: 36.0,
        color: Colors.blue,
      ),
      title: Text('ListView'),
      subtitle: Text('ข้อมูลท่องเที่ยว'),
      onTap: () {
        Navigator.of(context).pop();
        setState(() {
         currentWidget = ListViewPage(); 
        });
      },
    );
  }

  Widget showLogo() {
    //กล่องใส่รูปต้องใช้ Containner
    return Container(
      width: 80.0,
      height: 80.0,
      child: Image.asset('images/mylogo2.png'),
    );
  }

  Widget myHead() {
    return DrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/wallpaper.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          showLogo(),
          Text(
            'May Unseen',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.blue[600],
            ),
          ),
          Text('Share Ever thing from Thailand'),
        ],
      ),
    );
  }

  Widget myDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          myHead(),
          menuListViewPage(),
          Divider(),
          menuFormPage(),
          Divider(),
         
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My service'),
      ),
      body: currentWidget, //เอา widget currentWidget ที่ไปลิ้งค์กับ Formpage
      drawer: myDrawer(),
    );
  }
}
