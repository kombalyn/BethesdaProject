import 'dart:js';

import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:gif/gif.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import 'ModuleHipno_page2.dart';
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
  //GifController _controller2 = GifController(vsync: this);
  final Uri _url = Uri.parse('https://www.bethesda.hu/');

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();

    /*
    _controller = _controller = VideoPlayerController.asset('assets/videos/szia.mp4')
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
                            'Mi az a hipnózis?!',
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
                          'Sokszor, amikor hipnózisról beszélünk, a gyerekek és a felnőttek is egy olyan embert képzelnek maguk elé, akinek ijesztő tekintetétől valamiféle önkívületi állapotba kerülünk vagy elalszunk. Azt hiszik, ennek az állapotnak a hatására nem fogunk emlékezni semmire. Sok gyerek még arról is meg van győződve, hogy ez az ijesztő, hipnotizáló ember átveheti a testük felett az irányítást és olyan dolgok megtételére kényszerítheti őket, amit nem is akarnak. Más gyermekek Ká-ra, a kígyóra gondolnak (A dzsungel könyvéből), aki a szemét használja, hogy a fiúcska, Maugli, valamiféle önkívületi állapotba essen és azután mozdulni se tudjon. ',
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


                Image.asset(
                  "assets/images/9tLs.gif",
                  //height: 125.0,
                  width: MediaQuery.of(context).size.width*0.4,
                ),
             /*
              Gif(
                    image: AssetImage("images/animate.gif"),
                    controller: _controller2, // if duration and fps is null, original gif fps will be used.
                    //fps: 30,
                    //duration: const Duration(seconds: 3),
                    autostart: Autostart.no,
                    placeholder: (context) => const Text('Loading...'),
                    onFetchCompleted: () {
                      _controller2.reset();
                      _controller2.forward();
                    },
                    ),
              */

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
                          'Valóban ilyesmi a színpadi hipnózis, de ennek semmi köze sincs az orvosi hipnózishoz. Az orvosi hipnózis sokkal inkább az álmodozáshoz hasonlít, álmodozni pedig a legtöbb gyerek szeret és elég jól is tud. Képzeld el, hogy épp az osztályteremben ülsz és valami érdekes dologra gondolsz. Mondjuk a kedvenc hobbidra, például a focira. A képzeletedben éppen focizol, látod a többi játékost, talán néhány barátodat is, odapasszolják neked a labdát, te pedig lőni készülsz…és akkor… A tanár hirtelen felszólít téged. Valószínűleg meglepődsz, mert fogalmad sincs, miről is beszélt a tanár mostanáig. Álmodoztál és ezért egészen másra figyeltél, máshol jártál a képzeletedben.',
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
                          'Az orvosi hipnózis valójában pont ilyen. Gyakorlatokat fogsz hallgatni és közben a gondolataidra figyelsz. Talán még azt is elfelejted majd, hogy a saját szobádban vagy. Ezeket a gyakorlatokat néha képzelet-gyakorlatoknak is nevezzük, mert ilyenkor képeket alkotsz a saját fejedben. Ezek szép és barátságos képek. Egy ilyen kép megmutathat téged egy különleges tengerparton vagy éppen megnézheted, hogy hogyan is néz ki a saját pocakod. Az önhipnózis során semmi olyan nem történhet, amit te nem szeretnél. A hipnózis során teljes mértékben te irányítod az eseményeket.',
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

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black, width: 4),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'A hipnózis:',
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.4,
                        //height: 327,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14)),
                        child: SingleChildScrollView(

                          child: BulletList([
                            'Álmodozás',
                            'Szép dolgokról',
                            'Amit te irányítasz',
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),


                SizedBox(height: MediaQuery.of(context).size.width*0.025,),

                ElevatedButton(
                  onPressed: () {
                    print('Button pressed ...');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ModuleHipno2(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Text('Kezdjük az első modult!'),
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