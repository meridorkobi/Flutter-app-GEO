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
import 'dart:math';









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

  myLocITM _myLocITM = convertToITM(_myLoc);
  print ("_____________________");
  print (_myLocITM.east);
  print (_myLocITM.north);
  print ("_____________________");

//  String _url = 'https://www.govmap.gov.il/?c=195904,384801&z=8&b=0';
//  String _url = 'https://www.govmap.gov.il/?c=' +_myITM_Lat.toString() +',' + _myITM_Long.toString() +'&z=6&b=3&lay=SUB_GUSH_ALL';
  var _url = 'https://www.govmap.gov.il/?c=' +_myLocITM.east.toString() +',' + _myLocITM.north.toString() +'&z=10&b=3&lay=SUB_GUSH_ALL'+','+'PARCEL_ALL';
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
class myLocITM {
  int east;
  int north;
}
enum eDatum {
  eWGS84,
  eGRS80,
  eCLARK80M
}
class  DTM {
  double a;	// a  Equatorial earth radius
  double b;	// b  Polar earth radius
  double f;	// f= (a-b)/a  Flatenning
  double esq;	// esq = 1-(b*b)/(a*a)  Eccentricity Squared
  double e;	// sqrt(esq)  Eccentricity
  // deltas to WGS84
  double dX;
  double dY;
  double dZ;
}

enum gGrid {
gICS,
gITM
}

class GRD {
double lon0;
double lat0;
double k0;
double false_e;
double false_n;
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





myLocITM convertToITM(myLoc _myLocI) {

// typedef  DTM (
// double a,	// a  Equatorial earth radius
// double b,	// b  Polar earth radius
// double f,	// f= (a-b)/a  Flatenning
// double esq,	// esq = 1-(b*b)/(a*a)  Eccentricity Squared
// double e,	// sqrt(esq)  Eccentricity
// // deltas to WGS84
// double dX,
// double dY,
// double dZ,
// );
// class  DTM {
//     double a;	// a  Equatorial earth radius
//     double b;	// b  Polar earth radius
//     double f;	// f= (a-b)/a  Flatenning
//     double esq;	// esq = 1-(b*b)/(a*a)  Eccentricity Squared
//     double e;	// sqrt(esq)  Eccentricity
// // deltas to WGS84
//     double dX;
//     double dY;
//     double dZ;
//     }
  double pi() {
    return 3.141592653589793;
  }
  double sin2(double x) {
    return sin(x) * sin(x);
  }
  double cos2(double x) {
    return cos(x) * cos(x);
  }
  double tan2(double x) {
    return tan(x) * tan(x);
  }
  double tan4(double x) {
    return tan2(x) * tan2(x);
  }
  var  Datum0 = new DTM();
  Datum0.a = 6378137.0; // a
  Datum0.b = 6356752.3142; // b
  Datum0.f = 0.00335281066474748; // f = 1/298.257223563
  Datum0.esq =0.006694380004260807; // esq
  Datum0.e =0.0818191909289062; // e
// deltas to WGS84
  Datum0.dX =0;
  Datum0.dY = 0;
  Datum0.dZ =0 ;

  var  Datum1 = new DTM();
  Datum1.a = 6378137.0; // a
  Datum1.b = 6356752.3141; // b
  Datum1.f = 0.0033528106811823; // f = 1/298.257223563
  Datum1.esq =0.00669438002290272; // esq
  Datum1.e =0.0818191910428276; // e
  // deltas to WGS84
  Datum1.dX =-48;
  Datum1.dY = 55;
  Datum1.dZ =52;

  var  Datum2 = new DTM();
  Datum2.a = 6378300.789; // a
  Datum2.b = 6356566.4116309; // b
  Datum2.f = 0.003407549767264; // f = 1/298.257223563
  Datum2.esq =0.006803488139112318; // esq
  Datum2.e =0.08248325975076590; // e
  // deltas to WGS84
  Datum2.dX =-235;
  Datum2.dY = -85;
  Datum2.dZ =265;

  List<DTM> Datum = new List(3);
  Datum[0] = Datum0;
  Datum[1] = Datum1;
  Datum[2] = Datum2;
//
//   Datum[0].a = 6378137.0; // a
//   Datum[0].b = 6356752.3142; // b
//   Datum[0].f = 0.00335281066474748; // f = 1/298.257223563
//   Datum[0].esq =0.006694380004260807; // esq
//   Datum[0].e =0.0818191909289062; // e
// // deltas to WGS84
//   Datum[0].dX =0;
//   Datum[0].dY = 0;
//   Datum[0].dZ =0 ;
//
//   Datum[1].a = 6378137.0; // a
//   Datum[1].b = 6356752.3141; // b
//   Datum[1].f = 0.0033528106811823; // f = 1/298.257223563
//   Datum[1].esq =0.00669438002290272; // esq
//   Datum[1].e =0.0818191910428276; // e
//   // deltas to WGS84
//   Datum[1].dX =-48;
//   Datum[1].dY = 55;
//   Datum[1].dZ =52;
//
//   Datum[2].a = 6378300.789; // a
//   Datum[2].b = 6356566.4116309; // b
//   Datum[2].f = 0.003407549767264; // f = 1/298.257223563
//   Datum[2].esq =0.006803488139112318; // esq
//   Datum[2].e =0.08248325975076590; // e
//   // deltas to WGS84
//   Datum[2].dX =-235;
//   Datum[2].dY = -85;
//   Datum[2].dZ =265;
//





//   var Datum = new List(3);
//   Datum [0] = // WGS84 data
//   {
//     6378137.0, // a
//     6356752.3142, // b
//     0.00335281066474748, // f = 1/298.257223563
//     0.006694380004260807, // esq
//     0.0818191909289062, // e
// // deltas to WGS84
//     0,
//     0,
//     0
//   };
//   Datum [1] = // GRS80 data
//   {
//     6378137.0, // a
//     6356752.3141, // b
//     0.0033528106811823, // f = 1/298.257222101
//     0.00669438002290272, // esq
//     0.0818191910428276, // e
// // deltas to WGS84
//     -48,
//     55,
//     52
//   };
//   Datum [2] = // Clark 1880 Modified data
//   {
//     6378300.789, // a
//     6356566.4116309, // b
//     0.003407549767264, // f = 1/293.466
//     0.006803488139112318, // esq
//     0.08248325975076590, // e
// // deltas to WGS84
//     -235,
//     -85,
//     264
//   };

//

  var  Grid0 = new GRD();
  Grid0.lon0 = 0.6145667421719;
  Grid0.lat0 = 0.55386447682762762;
  Grid0.k0 = 1.00000;
  Grid0.false_e = 170251.555;
  Grid0.false_n = 2385259.0;

  var  Grid1 = new GRD();
  Grid1.lon0 = 0.61443473225468920;
  Grid1.lat0 = 0.55386965463774187;
  Grid1.k0 = 1.0000067;
  Grid1.false_e = 219529.584;
  Grid1.false_n = 2885516.9488;

  List<GRD> Grid = new List(2);
  Grid[0] = Grid0;
  Grid[1] = Grid1;

//   var Grid = new List(2);
//   Grid[0] = // ICS data
//   {
//     0.6145667421719, // lon0 = central meridian in radians of 35.12'43.490"
//     0.55386447682762762, // lat0 = central latitude in radians of 31.44'02.749"
//     1.00000, // k0 = scale factor
//     170251.555, // false_easting
//     2385259.0 // false_northing
//   };
//   Grid[1] = // ITM data
//   {
//     0.61443473225468920, // lon0 = central meridian in radians 35.12'16.261"
//     0.55386965463774187, // lat0 = central latitude in radians 31.44'03.817"
//     1.0000067, // k0 = scale factor
//     219529.584, // false_easting
//     2885516.9488 // false_northing = 3512424.3388-626907.390
// // MAPI says the false northing is 626907.390, and in another place
// // that the meridional arc at the central latitude is 3512424.3388
//   };


  myLoc Molodensky(double _ilat, double _ilon, eDatum _from1, eDatum _to1) {
    int from = _from1.index;
    int to = _to1.index;
    // from->WGS84 - to->WGS84 = from->WGS84 + WGS84->to = from->to
    double dX = Datum[from].dX - Datum[to].dX;
    double dY = Datum[from].dY - Datum[to].dY;
    double dZ = Datum[from].dZ - Datum[to].dZ;

    double slat = sin(_ilat);
    double clat = cos(_ilat);
    double slon = sin(_ilon);
    double clon = cos(_ilon);
    double ssqlat = slat*slat;

    //dlat = ((-dx * slat * clon - dy * slat * slon + dz * clat)
    //        + (da * rn * from_esq * slat * clat / from_a)
    //        + (df * (rm * adb + rn / adb )* slat * clat))
    //       / (rm + from.h);

    double from_f = Datum[from].f;
    double df = Datum[to].f - from_f;
    double from_a = Datum[from].a;
    double da = Datum[to].a - from_a;
    double from_esq = Datum[from].esq;
    double adb = 1.0 / (1.0 - from_f);
    double rn = from_a / sqrt(1 - from_esq * ssqlat);
    double rm = from_a * (1 - from_esq) / pow((1 - from_esq * ssqlat),1.5);
    double from_h = 0.0; // we're flat!

    double dlat = (-dX*slat*clon - dY*slat*slon + dZ*clat
        + da*rn*from_esq*slat*clat/from_a
        + df*(rm*adb + rn/adb)*slat*clat) / (rm+from_h);

    // result lat (radians)
    double olat = _ilat+dlat;

    // dlon = (-dx * slon + dy * clon) / ((rn + from.h) * clat);
    double dlon = (-dX*slon + dY*clon) / ((rn+from_h)*clat);
    // result lon (radians)
    double olon = _ilon+dlon;


    var _myLocO = new  myLoc();
    _myLocO.lat=olat;
    _myLocO.long = olon;
    return _myLocO;
  }

  myLocITM LatLon2Grid(double _lat, double _lon, eDatum from1, gGrid to1) {
    int from = from1.index;
    int to = to1.index;

    // Datum data for Lat/Lon to TM conversion
    double a = Datum[from].a;
    double e = Datum[from].e; 	// sqrt(esq);
    double b = Datum[from].b;

    //===============
    // Lat/Lon -> TM
    //===============
    double slat1 = sin(_lat);
    double clat1 = cos(_lat);
    double clat1sq = clat1*clat1;
    double tanlat1sq = slat1*slat1 / clat1sq;
    double e2 = e*e;
    double e4 = e2*e2;
    double e6 = e4*e2;
    double eg = (e*a/b);
    double eg2 = eg*eg;

    double l1 = 1 - e2/4 - 3*e4/64 - 5*e6/256;
    double l2 = 3*e2/8 + 3*e4/32 + 45*e6/1024;
    double l3 = 15*e4/256 + 45*e6/1024;
    double l4 = 35*e6/3072;
    double M = a*(l1*_lat - l2*sin(2*_lat) + l3*sin(4*_lat) - l4*sin(6*_lat));
    //double rho = a*(1-e2) / pow((1-(e*slat1)*(e*slat1)),1.5);
    double nu = a / sqrt(1-(e*slat1)*(e*slat1));
    double p = _lon - Grid[to].lon0;
    double k0 = Grid[to].k0;
    // y = northing = K1 + K2p2 + K3p4, where
    double K1 = M*k0;
    double K2 = k0*nu*slat1*clat1/2;
    double K3 = (k0*nu*slat1*clat1*clat1sq/24)*(5 - tanlat1sq + 9*eg2*clat1sq + 4*eg2*eg2*clat1sq*clat1sq);
    // ING north
    double Y = K1 + K2*p*p + K3*p*p*p*p - Grid[to].false_n;

    // x = easting = K4p + K5p3, where
    double K4 = k0*nu*clat1;
    double K5 = (k0*nu*clat1*clat1sq/6)*(1 - tanlat1sq + eg2*clat1*clat1);
    // ING east
    double X = K4*p + K5*p*p*p + Grid[to].false_e;

    // final rounded results
    int E = (X+0.5).toInt();
    int N = (Y+0.5).toInt();

    var _myLocITM = new  myLocITM();
    _myLocITM.east =E;
    _myLocITM.north = N;
    return (_myLocITM);
  }


  // 1. Molodensky WGS84 -> GRS80
  myLoc _myLoc3 = Molodensky(
      _myLocI.lat * pi() / 180, _myLocI.long * pi() / 180, eDatum.eWGS84,
      eDatum.eGRS80);

  // 2. Lat/Lon (GRS80) -> Local Grid (ITM)
  myLocITM _myLocITM = LatLon2Grid(
      _myLoc3.lat, _myLoc3.long, eDatum.eGRS80, gGrid.gITM);
  return _myLocITM;
}


