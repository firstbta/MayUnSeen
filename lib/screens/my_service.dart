import 'package:flutter/material.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
// Explict

// Method

  Widget menuFormPage() {
    return ListTile(
      leading: Icon(
        Icons.filter_1,
        size: 36.0,
        color: Colors.blue,
      ),
      title: Text('Form'),
      subtitle: Text('หน้ากรอกข้อมูล'),
    );
  }

  Widget menuListViewPage() {
    return ListTile(
      leading: Icon(
        Icons.filter_2,
        size: 36.0,
        color: Colors.blue,
      ),
      title: Text('ListView'),
      subtitle: Text('ข้อมูลท่องเที่ยว'),
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
          menuFormPage(),
          Divider(),
          menuListViewPage(),
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
      body: Text('body'),
      drawer: myDrawer(),
    );
  }
}
