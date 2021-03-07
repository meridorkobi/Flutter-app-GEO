import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:mime/mime.dart';
import 'package:map/map.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
int _counter = 0;
myLoc _myLoc;
double _myLat = 0.0;
double _myLong = 0.0;
CameraPosition _myPosition = CameraPosition(target: LatLng(_myLat, _myLong),zoom: 15,);
Completer<GoogleMapController> _controller = Completer();

//const _url = 'https://www.govmap.gov.il/?c=195904,384801&z=8&b=0';
const _url = 'https://www.govmap.gov.il/?c=32.1254193,32.8033479&z=10&b=0';
//const _url = 'https://www.govmap.gov.il/?c=179449,663927&z=8&b=0';
// https://www.govmap.gov.il/?c=32.1254193,32.8033479&z=8&b=0
//https://www.govmap.gov.il/?c=200000,700000&z=8&b=0
// 32.393809 34.997722
//
// 100000 370000    29.411810 33.973700
//
// 300000 810000     	33.382813 	36.070106

void main() => runApp(

const MaterialApp(
    home: Material(
      child: Center(
        child: RaisedButton(
          onPressed: _launchURL,
          child: Text('Show Map'),
        ),
      ),
    ),
  ),
);

void _launchURL() async  {
  print("START3");
  _myLoc = await myLocation1();
//  if (_myLoc.lat == 0) {_myLoc = await myLocation1();};
  while((_myLoc.lat == 0) || (_myLoc.long == 0)) {
  }
  double _myITM_Lat =(300000.0-100000.0)*(_myLoc.lat -29.411810)/(33.382813-29.411810)+100000.0;
  double _myITM_Long=(810000.0-370000.0)*(_myLoc.long-33.973700)/(36.070106-33.973700)+370000.0;
  print (_myLoc.lat.toString());
  print (_myLoc.long.toString());
  print (_myITM_Lat.toString());
  print (_myITM_Long.toString());


//  String _url = 'https://www.govmap.gov.il/?c=195904,384801&z=8&b=0';
  String _url = 'https://www.govmap.gov.il/?c=' +_myITM_Lat.toString() +',' + _myITM_Long.toString() +'&z=6&b=3&lay=SUB_GUSH_ALL';
  await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}






// void main() {
//   runApp(MyApp());
// }


/*  NEW VERSION
class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  myLoc _myLoc;
  static double _myLat = 0.0;
  static double _myLong = 0.0;
  static CameraPosition _myPosition = CameraPosition(target: LatLng(_myLat, _myLong),zoom: 15,);
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _defauldLocation = CameraPosition(
    target: LatLng(_myLat, _myLong),
    zoom: 15,
  );
  static final CameraPosition _kLake = CameraPosition(
      target: LatLng(32.1, 34.8),
      zoom: 13);



  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  @override
  void initState()  {
    super.initState;
    _myLocation3();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

  }
   void test () async {
     print ("YYYYYYYYYYY");
     var url = 'https://www.govmap.gov.il/?c=179449,663927&z=8&b=0';
     var response =  await http.post(url);
     print('Response status: ${response.statusCode}');
     print('Response body: ${response.body}');
     print(await http.read(url));    print ("YYYYYYYYYYY");
     print ("XXXXXXXXXXXX");
   }
  _launchURL() async {
    print (_myLat.toString());
    print ( _myLong.toString());
    String url = 'https://www.govmap.gov.il/?c=' + _myLat.toString() + ',' + _myLong.toString()+ '&z=8&b=0';
//    String url = 'https://www.govmap.gov.il/?c=179965.9,662477.31&z=8&b=0';
//
    //     const  url = 'https://www.govmap.gov.il/?c=32.1,34.8&z=8&b=0';
//                   https://www.govmap.gov.il/?c=32.1,34.8&z=8&b=0
// //    const  url = 'https://www.govmap.gov.il/?c=32.1254193,34.8033479&z=8&b=0';
    if (await canLaunch(url)) {
      print ("LUANCH TRUE");
      await launch(url);
    } else {
      print ("LUANCH FALSE");
      throw 'Could not launch $url';
    }
    print ("END LAUNCH");
  }
  @override
  Widget build(BuildContext context)   {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    if (_myLat == 0) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text('MAP'),
            backgroundColor: Color(0xffe5087e)
        ),
        body:
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Please Wait ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
            ],
          ),
        ),
      );
    }

    // print ("GGGGGGGGGG");
    // _launchURL();
    // print ("GGGGGGGGGG");



      return
        Text (_myLat.toString()+ _myLong.toString() );
       // WebView(
       //   initialUrl: 'https://www.govmap.gov.il/?c=179449,663927&z=8&b=0',
       // );
    }


//     new Scaffold(
//       body:
//       Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // Text(_myLat.toString()+ _myLong.toString(),
//             //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
//       WebView(
//           initialUrl: 'https://www.govmap.gov.il/?c=179449,663927&z=8&b=0'
// //          initialUrl: 'https://miznk.com'
//       ),
//       ]
//       ),
//       //Text (_myLat.toString()+ _myLong.toString() ),
//       // GoogleMap(
//       //   mapType: MapType.hybrid,
//       //   initialCameraPosition: _defauldLocation,
//       //   onMapCreated: (GoogleMapController controller) {
//       //     _controller.complete(controller);
//       //   },
//       // ),
//       ),
//     );
//   }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Future<void> _myLocation3() async {
    _myLoc = await myLocation1();
    if (_myLoc.lat == 0) {_myLoc = await myLocation1();};
    setState(() {
      // if ((globals.userData.loc.long==0.0 ) &(globals.userData.loc.lat==0.0)  )
      // {
      //   _myPosition = CameraPosition(target: LatLng(31.2, 34.8),zoom: 15,);
      // } else
      // {
      _myLat =_myLoc.lat;
      _myLong = _myLoc.long;

      // _myLat =179965.9;
      // _myLong = 662477.31;

      _myPosition = CameraPosition(target: LatLng(_myLat,  _myLong),zoom: 15,);
    });
  }


}


*///////////////////
class myLoc {
  double lat;
  double long;
}
Future<myLoc> myLocation1() async {
  bool serviceEnabled;
  LocationPermission permission;
  Position _locationData;
  var _myLoc = myLoc();
  int x=0;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    x=1;
//    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    x=2;
    // return Future.error(
    //     'Location permissions are permantly denied, we cannot request permissions.');
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      x=3;
      // return Future.error(
      //     'Location permissions are denied (actual value: $permission).');
    }
  }
  if (x==0) {
    _locationData = await Geolocator.getCurrentPosition();

    _myLoc.lat = _locationData.latitude;
    _myLoc.long = _locationData.longitude;
  } else {
    _myLoc.lat = 0;
    _myLoc.long = 0;
  }
  return(_myLoc);
}



