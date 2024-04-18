import 'dart:js';

import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import 'ModuleHipno_page4.dart';
import 'ModuleHipnomp3_1.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class BulletList extends StatelessWidget {
  final List<String> strings;

  BulletList(this.strings);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(16, 15, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: strings.map((str) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\u2022',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.55,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    str,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.6),
                      height: 1.55,
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}



class ModuleHipno3 extends StatelessWidget {
  const ModuleHipno3({super.key});

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

  final Uri _url = Uri.parse('https://www.bethesda.hu/');

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();

    _controller = _controller = VideoPlayerController.asset('assets/videos/kronikus_hasi_fajdalom.mp4')
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
                            'Mi okozza a hasfájást?',
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
                          'Lehet, hogy az orvosod már beszélt erről veled. Ismételjünk át néhány dolgot annak érdekében, hogy te is és a szüleid is igazán jól megértsétek ezeket! Az irritábilis bélrendszerrel vagy krónikus hasi fájdalommal küzdő gyermekeknél a belek túlérzékennyé váltak. Mit is jelent ez? Mindannyian tudjuk, hogy ha például megégetjük a kezünket, akkor hirtelen erős fájdalmat érzünk. Ez a fájdalom egy riasztás, ami jelzi, hogy valami nincs rendben a szervezetünkkel. Ha nem éreznénk a fájdalmat, nem lenne okunk arra, hogy elhúzzuk a kezünket a tűztől. A fájdalom tehát egy fontos figyelmeztető jelzés. Azonban a hasadban ez a riasztórendszer túlérzékennyé vált. Olyan ez, mint egy házban a riasztó: akkor kellene bekapcsolnia, amikor betörő van a házban, de ez a rendszer olyan érzékeny, hogy például egy házon átrepülő kis rovar is beindítja. Valami hasonló történik a hasadban is. Fájdalmat érezhetsz, ha például ettél egy megromlott szendvicset, de akkor is érzel fájdalmat, ha egy egészséges és friss szendvicset eszel, vagy akkor is, ha egyáltalán nem is eszel semmit. Bármikor és bárhol fájhat a hasad. Tudjuk, hogy valójában nincsen semmi komoly baja a hasadnak. A pocakod egyszerűen túl érzékennyé vált.',
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

                SizedBox(height: MediaQuery.of(context).size.width*0.025,),

                Row(
                  children: [
                    Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(230, 20, 0, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.5,
                        child: Text(
                          'Az ördögi kör',
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
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(230, 0, 0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.5,
                          child: Text(
                          'Amikor fájdalmat érzel, akkor olyan gondolataid lehetnek, mint: „Remélem, hogy nem lesz rosszabb, mert iskolába akarok menni." vagy „El akarok menni arra a meccsre. Valószínűleg így nem fogok tudni.". Amikor így gondolkodsz, az izmaid megfeszülnek, bár lehet, hogy észre sem veszed. Ettől aggódhatsz és szomorú lehetsz, a szíved elkezdhet gyorsabban verni, és mindezek miatt a fájdalmat még rosszabbnak érezheted. Lehet, hogy másképp is kezdesz lélegezni: a nyugodt, laza és mély hasi légzés helyett talán szaporán kapkodod a levegőt. Mindezek miatt olyan érzésed lehet, hogy egy negatív körben jársz körbe-körbe, amit mi "ördögi körnek" hívunk. Úgy érezheted, hogy tehetetlen vagy.',
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
                         'Így néz ki ez az ördögi kör:',
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

                //Ide
                Image.asset("assets/images/ordogikor.png"),

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
                          'Az (ön)hipnózis gyakorlatok segítségével megtörheted ezt a kört és megtanulhatod, hogyan tudod megállítani a fájdalmat és a fájdalommal kapcsolatos nehéz gondolatokat. Olyan gyerekektől tudjuk ezt, akik a gyakorlás által egyre jobban és jobban érzik magukat. Az ördögi kör megszakad, majd fokozatosan eltűnik.',
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

                ElevatedButton(
                  onPressed: () {
                    print('Button pressed ...');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ModuleHipno4(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Text('Go To Second Module'),
                      Icon(
                        Icons.play_arrow,
                        size: 15,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.width*0.025,),
                SizedBox(height: MediaQuery.of(context).size.width*0.025,),

                TextButton(
                  onPressed: () {
                    navigateTo('https://www.bethesda.hu/');
                  },
                  child: Text(
                    'https://www.bethesda.hu/',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    navigateTo('https://www.bethesda.hu/');
                  },
                  child: Text(
                    'Tudjon meg többet a krónikus hasi fájdalomról!',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
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

  Future<void> _launchUrl1() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

}

// Ez a függvény navigál a megadott URL-re a webes alkalmazásban
void navigateTo(String url) {
  // A window.location.href tulajdonság beállítása a megadott URL-re
  // megnyitja az új URL-t az aktuális ablakban
  // A replaceAll kiküszöböli az esetleges szóközöket a URL-ből
  // Mivel a navigateTo függvény Flutter weben fut, ezért szükséges használni a window objektumot
  // A window objektumot nem lehet használni a Flutter mobilalkalmazásokban
  // Ebben az esetben kizárólag a mobilalkalmazásokban használatos url_launcher csomagot kellene használni
  // de mivel ez a kód a Flutter web verziójára vonatkozik, ezért itt a window objektumot használjuk
  // A window objektum a Dart SDK webes környezetében ismert
  // Szükséges lehet a dart:js csomagot importálni, ha a VS Code figyelmeztetést ad
  //import 'dart:js';
  //context['window'].callMethod('open', [url]);
  context['window'].location.href = url.replaceAll(' ', '');
}