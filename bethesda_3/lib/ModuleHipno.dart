import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:video_player/video_player.dart';

import 'home_page_model.dart';
export 'home_page_model.dart';




class ModuleHipno extends StatelessWidget {
  const ModuleHipno({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: const ModuleHipnoWidget(),
    );
  }
}



class ModuleHipnoWidget extends StatefulWidget {
  const ModuleHipnoWidget({super.key});

  @override
  State<ModuleHipnoWidget> createState() => _ModuleHipnotState();
}

class _ModuleHipnotState extends State<ModuleHipnoWidget> {
  late HomePageModel _model;

  late VideoPlayerController _controller;
  late AnimationController _animationController;
  late double _currentPointOnFunction = 0; // Az aktuális függvényérték
  late double _sliderValue = 0.0; // A csúszka értéke
  late bool toggle = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();

    _controller = _controller = VideoPlayerController.asset('assets/videos/animation.mp4')
      ..initialize().then((_) {
        setState(() {});
      });

    _controller.value.isPlaying
        ? _controller.pause()
        : _controller.play();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white70,
        drawer: Drawer(
          elevation: 16,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                  Row(
                    children: [
                      Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(230, 20, 0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.5,
                          child: Text(
                            'Üdvözöljük!',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: MediaQuery.of(context).size.width*0.025,),

                  Row(
                    children: [
                      Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(230, 0, 0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.5,
                          child: Text(
                          'A világszerte a gyermekek 10-15%-a szenved hasi fájdalomtól, ami elfogadhatatlanul sok! Kutatásaink ugyanakkor azt mutatják, hogy hipnózis felvételek hallgatása ezen gyermekek több mint 70%-ának segít. Az hipnózis gyakorlása csökkenti továbbá az orvoshoz és pszichológushoz fordulások számát, javítja az életminőséget, csökkenti az iskolai hiányzások számát és növeli az önbizalmat. Sőt, még a jobb és pihentetőbb alvásban is segít!',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFFE41B48),
                            fontSize: 18,
                          ),
                        ),
                        ),
                      ),
                    ],
                  ),

                SizedBox(height: MediaQuery.of(context).size.width*0.025,),

                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(230, 0, 0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.5,
                          child: Text(
                          'A hasi fájdalommal élni zavaró és nehéz. A hasi fájdalom a gyermekek életének számos területére hatással van, kihathat az iskolai az iskolai dolgokra, a barátokkal való találkozásra, a sporttal töltött időre. Ezt a folyamatos fájdalmat a túlérzékeny bélműködés okozza. A krónikus hasi fájdalom kialakulásában és fennmaradásában egyaránt szerepet játszhat a genetikai hajlam, a személyiségjegyek és az otthoni vagy az iskolai stressz is. A hipnózisfelvételek hallgatása azonban nagy segítség tud lenni ezeknek a gyermekeknek.',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFFE41B48),
                            fontSize: 18,
                          ),
                        ),
                        ),
                      ),
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
