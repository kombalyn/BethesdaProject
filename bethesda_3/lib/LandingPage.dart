import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:video_player/video_player.dart';

import 'ModuleHipno.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';




class ModuleOpening extends StatelessWidget {
  const ModuleOpening({super.key});

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
      home: const ModuleOpeningWidget(),
    );
  }
}



class ModuleOpeningWidget extends StatefulWidget {
  const ModuleOpeningWidget({super.key});

  @override
  State<ModuleOpeningWidget> createState() => _ModuleOpeningWidgetState();
}

class _ModuleOpeningWidgetState extends State<ModuleOpeningWidget> {
  late HomePageModel _model;

  late VideoPlayerController _controller;
  bool _isPlaying = false;

  late AnimationController _animationController;
  late double _currentPointOnFunction = 0; // Az aktuális függvényérték
  late double _sliderValue = 0.0; // A csúszka értéke
  late bool toggle = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();

    _controller = _controller = VideoPlayerController.asset('assets/videos/szia.mp4')
      ..initialize().then((_) {
        setState(() {});
      });

    _controller.addListener(() {
      setState(() {});
    });

    _controller.value.isPlaying
        ? _controller.pause()
        : _controller.play();
  }

  @override
  void dispose() {
    _model.dispose();

    _controller.dispose();
    super.dispose();
  }

  void _playPauseVideo() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
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
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 1303,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/images/bethesda_gyermekkorhaz_logo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                            child: Text(
                              'Home      ',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                color: Color(0xFFE41B48),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                            child: Text(
                              'Hello World',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                color: Color(0xFFE41B48),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                            child: Text(
                              'My Progress',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                color: Color(0xFFE41B48),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                            child: Text(
                              'Comunity  ',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                color: Color(0xFFE41B48),
                              ),
                            ),
                          ),
                          Text(
                            'English   ',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFFE41B48),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(550, 0, 0, 0),
                            child: Container(
                              width: 80,
                              height: 80,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                'https://picsum.photos/seed/423/600',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    //height: 779,
                    decoration: BoxDecoration(
                      color: Color(0x61FFFFFF),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.asset(
                          'assets/images/hatter.jpg',
                        ).image,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.black, width: 4),
                          ),
                          child: _controller.value.isInitialized
                              ?
                          toggle ? Container(
                            width: 500,
                            height: 300,
                            child: AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            ),
                          ) : Container(
                            color: Colors.black,
                            width: 500,
                            height: 300,
                          )

                              : Container(),
                        ),
                        // Vezérlők hozzáadása a videóhoz
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                _isPlaying ? Icons.pause : Icons.play_arrow,
                              ),
                              onPressed: _playPauseVideo,
                            ),
                            if (_controller.value.isInitialized)
                              Slider(
                                value: _controller.value.position.inSeconds.toDouble(),
                                min: 0.0,
                                max: _controller.value.duration.inSeconds.toDouble(),
                                onChanged: (double value) {
                                  _controller.seekTo(Duration(seconds: value.toInt()));
                                },
                              ),
                          ],
                        ),


                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(230, 20, 0, 0),
                              child: Text(
                                'How to Use',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(230, 0, 0, 0),
                              child: Text(
                                'Welcome to use BethesdaApp. Let\'s understand how to use this course and what you can\n get out of it.\n\n',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xFFE41B48),
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ],
                        ),



                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [

                            SizedBox(width: MediaQuery.of(context).size.width*0.15,),

                            Container(
                              width: MediaQuery.of(context).size.width*0.2,
                              child: Image.asset("assets/fox.png"),
                            ),


                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(50, 0, 0, 0),
                              child: Text(
                                'Szia Ádám! Örülünk, hogy újra itt vagy!',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xFFE41B48),
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height*0.05,),

                        ElevatedButton(
                            onPressed: () {
                              print('Button pressed ...');

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => ModuleHipno(),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Text('Begin First Module'),
                                Icon(
                                  Icons.play_arrow,
                                  size: 15,
                                ),
                              ],
                            ),
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height*0.05,),

                      ],
                    ),
                  ),
                ),
              ],
            ),

          ),
        ),
      ),
    );
  }
}
