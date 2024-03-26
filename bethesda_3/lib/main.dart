import 'package:bethesda_2/regisztracio.dart';
import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
//import 'package:video_player/video_player.dart';

import 'package:bethesda_2/constants/colors.dart'; // Adjust the import path as necessary

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
    return MaterialApp(
      title: 'Fájdalomkezelés bejelentkezés',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePageWidget(),
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
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "VAGY",
            style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
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
                    SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                    Container(
                        color: AppColors.lightaccentcolor,
                        width: MediaQuery.of(context).size.width*0.3,
                        height: MediaQuery.of(context).size.height,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 15.0), // Apply padding only on the left side
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20), // Adjust this value to change the roundness
                                  child: Image.asset(
                                    "assets/images/bethesda_gyermekkorhaz_logo.png",
                                    width: MediaQuery.of(context).size.width * 0.05,
                                  ),
                                ),
                              ),

                            ),
                            //Image.asset("assets/images/bethesda_gyermekkorhaz_logo.png",width: MediaQuery.of(context).size.width*0.1,),
                            SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                            Text("Üdvözöljük a Bethesda Gyermekkórház Online Fájdalomkezelő weboldalán!",
                              textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
                            SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                            Image.asset("assets/images/bear_nobackground.png"),
                          ],
                        ),
                        //SizedBox(width: MediaQuery.of(context).size.width*0.5,height: MediaQuery.of(context).size.height ,),
                      ),




                      Container(
                        width: MediaQuery.of(context).size.width*0.7,
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
                                    style: TextStyle(fontFamily: 'Montserrat',fontSize: 18),
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
                              width: MediaQuery.of(context).size.width*0.35,
                              child: Column(
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                                      child: Text(
                                        'E-mail cím:',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontFamily: 'Montserrat',fontSize: 18, color: AppColors.darkshade),
                                      ),
                                    ),
                                  ),


                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.lightshade, // Background color of the container
                                    border: Border.all(
                                      color: Colors.grey, // Outline color
                                      width: 0.5, // Outline thickness
                                    ),
                                    // If you also want to have rounded corners, add the borderRadius property
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                    child: TextFormField(
                                      controller: _model.textController1,
                                      focusNode: _model.textFieldFocusNode1,
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.zero, // <-- Set contentPadding to zero
                                        labelText: 'Label here...',
                                        labelStyle:
                                        TextStyle(fontFamily: 'Montserrat',fontSize: 15, color: AppColors.lightaccentcolor),
                                        //hintStyle: FlutterFlowTheme.of(context).labelMedium,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 0,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 0,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedErrorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      style: TextStyle(fontFamily: 'Montserrat',fontSize: 15),
                                      //validator: _model.textController1Validator.asValidator(context),
                                    ),
                                  ),
                                ),

                                ],
                              ),
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width*0.35,
                              child: Column(
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                                      child: Text(
                                        'Kutatási azonosító:',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontFamily: 'Montserrat',fontSize: 18, color: AppColors.darkshade),
                                      ),
                                    ),
                                  ),

                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.lightshade, // Background color of the container
                                      border: Border.all(
                                        color: Colors.grey, // Outline color
                                        width: 0.5, // Outline thickness
                                      ),
                                      // If you also want to have rounded corners, add the borderRadius property
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                    child: TextFormField(
                                      controller: _model.textController1,
                                      focusNode: _model.textFieldFocusNode1,
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.zero, // <-- Set contentPadding to zero
                                        labelText: 'Label here...',
                                        labelStyle:
                                        TextStyle(fontFamily: 'Montserrat',fontSize: 15, color: AppColors.lightaccentcolor),
                                        //hintStyle: FlutterFlowTheme.of(context).labelMedium,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white30,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 0,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedErrorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      style: TextStyle(fontFamily: 'Montserrat',fontSize: 15),
                                      //validator: _model.textController1Validator.asValidator(context),
                                    ),
                                  ),
                                  ),


                                  SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                                  ElevatedButton(onPressed: () async {

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => ModuleOpening(),
                                      ),
                                    );

                                    print("gomb");
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(AppColors.lightaccentcolor), // Change the color to your desired color
                                    ),
                                       child: Text("Bejelentkezés", textAlign: TextAlign.center,
                                      style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 20,
                                          color: AppColors.lightshade),),

        ),


                                  SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                                  orDivider(context),

                                  //Container(width: MediaQuery.of(context).size.width*0.4, height: MediaQuery.of(context).size.width*0.005, color: Colors.black),
                                  SizedBox(height: MediaQuery.of(context).size.height*0.02,),

                                  ElevatedButton(onPressed: () async {
                                    print("gomb");


                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => Regisztracio(),
                                      ),
                                    );


                                  }
                                      , child: Text("Regisztráció",  textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.lightaccentcolor),),
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
