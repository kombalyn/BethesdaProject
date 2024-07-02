import 'package:bethesda_2/regisztracio.dart';
import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

//import 'package:video_player/video_player.dart';
import 'styles.dart'; // Make sure this path is correct based on where you placed the styles.dart file

import 'package:bethesda_2/constants/colors.dart'; // Adjust the import path as necessary
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'ModuleOpening_M3.dart';

import 'ModuleOpening.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1263, 551),
      // Set your design size based on your design prototype
      builder: (BuildContext context, Widget? child) => MaterialApp(
        title: 'Fájdalomkezelés bejelentkezés',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          useMaterial3: false,
        ),
        home:
            const HomePageWidget(), // Make sure this is the widget you want to start with
      ),
    );
  }
}

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  late WebSocketChannel _channel = WebSocketChannel.connect(
    //Uri.parse('ws://34.72.67.6:8089'),
    Uri.parse('ws://146.148.43.137:8089'),
  );


  //late VideoPlayerController _controller;
  late AnimationController _animationController;
  late double _currentPointOnFunction = 0; // Az aktuális függvényérték
  late double _sliderValue = 0.0; // A csúszka értéke
  late bool toggle = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();
    _model.textController1 = TextEditingController();
    _model.textController2 = TextEditingController();
    /*
    _controller = _controller = VideoPlayerController.asset('assets/videos/animation.mp4')
      ..initialize().then((_) {
        setState(() {});
      });

    _controller.value.isPlaying
        ? _controller.pause()
        : _controller.play();

     */
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Widget orDivider(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(color: Colors.grey),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.005),
          child: Text(
            "VAGY",
            style: MyTextStyles.nagybekezdes(context),
          ),
        ),
        Expanded(
          child: Divider(color: Colors.grey),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.lightshade,
        // backgroundColor: Colors.white70,
        drawer: Drawer(
          elevation: 16,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                    ),
                    Container(
                      color: AppColors.lightaccentcolor,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.02,
                                  top: MediaQuery.of(context).size.height *
                                      0.0001),
                              // Apply padding only on the left side
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                // Adjust this value to change the roundness
                                child: Image.asset(
                                  "assets/images/bethesda_gyermekkorhaz_logo.png",
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          //Image.asset("assets/images/bethesda_gyermekkorhaz_logo.png",width: MediaQuery.of(context).size.width*0.1,),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Text(
                              "Üdvözlünk a Bethesda Gyermekkórház Online Fájdalomkezelő weboldalán!",
                              textAlign: TextAlign.center,
                              style: MyTextStyles.feherkovercim(context)),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005,
                          ),
                          Spacer(),
                          Image.asset(
                            "assets/images/bear_nobackground.png",
                            //"assets/images/probaelsohatter.png",
                            fit: BoxFit.cover, // Cover the available space
                          ),
                        ],
                      ),
                      //SizedBox(width: MediaQuery.of(context).size.width*0.5,height: MediaQuery.of(context).size.height ,),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ListTile(
                            //title: Text(
                            //  'Bethesda Gyermekkórház Online Fájdalomkezelő',
                            // textAlign: TextAlign.center,
                            // style: TextStyle(fontFamily: 'Montserrat',fontSize: 20),
                            //),
                            subtitle: Text(
                              'A továbblépéshez kérjük jelentkezzen be az e-mail címének és a korábban megkapott kutatási azonosítójának megadásával.',
                              textAlign: TextAlign.center,
                              style: MyTextStyles.bekezdes(context),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 20,
                            ),
                            tileColor: Colors.white,
                            dense: false,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Column(
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0,
                                        MediaQuery.of(context).size.width *
                                            0.03,
                                        0,
                                        0),
                                    child: Text(
                                      'E-mail cím:',
                                      textAlign: TextAlign.center,
                                      style: MyTextStyles.nagybekezdes(context),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.lightshade,
                                    // Background color of the container
                                    border: Border.all(
                                      color: Colors.grey, // Outline color
                                      width: 0.5, // Outline thickness
                                    ),
                                    // If you also want to have rounded corners, add the borderRadius property
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        0,
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        0),
                                    child: TextFormField(
                                      controller: _model.textController1,
                                      focusNode: _model.textFieldFocusNode1,
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        // <-- Set contentPadding to zero
                                        labelText: 'Kattintson ide...',
                                        labelStyle:
                                            MyTextStyles.kicsiszinesbekezdes(
                                                context),
                                        //hintStyle: FlutterFlowTheme.of(context).labelMedium,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      style:
                                          MyTextStyles.kicsibekezdes(context),
                                      //validator: _model.textController1Validator.asValidator(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Column(
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0,
                                        MediaQuery.of(context).size.width *
                                            0.03,
                                        0,
                                        0),
                                    child: Text(
                                      'Kutatási azonosító:',
                                      textAlign: TextAlign.center,
                                      style: MyTextStyles.nagybekezdes(context),
                                    ),
                                  ),
                                ),

                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.lightshade,
                                    // Background color of the container
                                    border: Border.all(
                                      color: Colors.grey, // Outline color
                                      width: 0.5, // Outline thickness
                                    ),
                                    // If you also want to have rounded corners, add the borderRadius property
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        0,
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        0),
                                    child: TextFormField(
                                      controller: _model.textController2,
                                      focusNode: _model.textFieldFocusNode1,
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        // <-- Set contentPadding to zero
                                        labelText: 'Kattintson ide...',
                                        labelStyle:
                                            MyTextStyles.kicsiszinesbekezdes(
                                                context),
                                        //hintStyle: FlutterFlowTheme.of(context).labelMedium,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white30,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      style:
                                          MyTextStyles.kicsibekezdes(context),
                                      //validator: _model.textController1Validator.asValidator(context),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                ElevatedButton(
                                  onPressed: () async {

                                    _channel = WebSocketChannel.connect(
                                      //Uri.parse('ws://34.72.67.6:8089'),
                                      Uri.parse('ws://146.148.43.137:8089'),
                                    );

                                    //kerdes = "$_selectedLocaleId | $kerdes";
                                    String? szov = _model.textController1?.text;
                                    String? szov2 = _model.textController2?.text;
                                    print("bejelentkezes|$szov-$szov2");
                                    _channel.sink.add("bejelentkezes|$szov-$szov2");
                                    //_channel.sink.add("bejelentkezes|adam@ali.com");
                                    _channel.stream.listen(
                                            (message) {
                                          print('Received message: $message');


                                          if(message=="True"){
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (BuildContext context) =>
                                                    //TO DO AZONOSITO ES IDO ALAPJAN MELYIK NYILJON MEG
                                                    //ModuleOpening('Azonosito'),
                                                    ModuleOpening_M3(),
                                              ),
                                            );
                                          }else{
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) => AlertDialog(
                                                title: Text("Bejelentkezési Hiba"),
                                                content: Text("A bejelentkezési email cím vagy az azonosító hibás, nem ismert. Ha még nem regisztráltál, akkor kérlek kattints az \"Először jársz itt\" gombra."),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context, 'OK'),
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }

                                        });


                                    print("TODO: Küldes a szerverre");
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppColors.lightaccentcolor),
                                    // Change the color to your desired color
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // Adjust the value as needed
                                      ),
                                    ),
                                    padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                      EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal:
                                              24), // Adjust the padding as needed
                                    ),
                                  ),
                                  child: Text(
                                    "Bejelentkezés",
                                    textAlign: TextAlign.center,
                                    style: MyTextStyles.gomb(context),
                                  ),
                                ),

                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                orDivider(context),

                                //Container(width: MediaQuery.of(context).size.width*0.4, height: MediaQuery.of(context).size.width*0.005, color: Colors.black),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),

                                ElevatedButton(
                                  onPressed: () async {
                                    print("gomb");

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Regisztracio(),
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppColors.whitewhite),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // Adjust the value as needed
                                      ),
                                    ),
                                    padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                      EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal:
                                              24), // Adjust the padding as needed
                                    ), // Change the color to your desired color
                                  ),
                                  child: Text(
                                    "Először jársz itt?",
                                    textAlign: TextAlign.center,
                                    style: MyTextStyles.szinesgomb(context),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
