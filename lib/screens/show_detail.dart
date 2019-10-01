import 'package:flutter/material.dart';
import 'package:mayunseen/models/unseen_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  double lat = 0, lng = 0;
  LatLng myLatLng;

  //Method
  @override
  void initState() {
    super.initState();
    myUnseenModel = widget.unseenModel; //ดึงโมเดลที่รับค่ามาใช้
    lat = myUnseenModel.lat;
    lng = myUnseenModel.lng;
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
          style: TextStyle(fontSize: 20.0, color: Colors.grey[600]),
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

  //googelmap
  Widget showMap() {
    myLatLng = LatLng(lat, lng);
    CameraPosition cameraPosition = CameraPosition(
      target: myLatLng,
      zoom: 16.0, //max20 min 1 ยิ่งมากยิ่งซูมเยอะ
    );
    return Container(
      height: 400.0,
      margin: EdgeInsets.all(20.0),
      child: GoogleMap(
        mapType: MapType.normal, //รูปแบบแสดงแมพ
        initialCameraPosition: cameraPosition, //ค่าเริ่มต้นพิกัด
        onMapCreated: (GoogleMapController googleMapController) {},
        markers: myMarker(),
      ),
    );
  }

  //marker
  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('Maker1'),
        position: myLatLng,
        infoWindow: InfoWindow(
          title: myUnseenModel.name,
          snippet: myUnseenModel.detail,
        ),
      ),
    ].toSet();
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
          showMap(),
        ],
      ),
    );
  }
}
