import 'package:flutter/material.dart';
import 'package:mayunseen/models/unseen_model.dart';

class ShowDetail extends StatefulWidget {
  //สร้างตัวแปรGobalรับโมเดล
  final UnseenModel unseenModel; //โยนโมเดลมา
  ShowDetail({Key key, this.unseenModel}) : super(key: key);

  @override
  _ShowDetailState createState() => _ShowDetailState();
}

class _ShowDetailState extends State<ShowDetail> {
  //Explicit
  UnseenModel myUnseenModel;

  //Method
  @override
  void initState() {
    super.initState();
    myUnseenModel = widget.unseenModel; //ดึงโมเดลที่รับค่ามาใช้
  }

  Widget showName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          myUnseenModel.name,
          style: TextStyle(fontSize: 30.0, color: Colors.blue),
        ),
      ],
    );
  }

  Widget showDetail2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          myUnseenModel.detail,
          style: TextStyle(fontSize: 30.0, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget showImage() {
    return Container(
      height: 200.0,
      child: Image.network(myUnseenModel.urlPicture),
    );
  }

  /////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: ListView(
        children: <Widget>[
          showName(),
          showImage(),
          showDetail2(),
        ],
      ),
    );
  }
}
