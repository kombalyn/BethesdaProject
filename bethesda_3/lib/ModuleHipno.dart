import 'dart:js';
import 'package:bethesda_2/styles.dart';
import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:bethesda_2/constants/colors.dart'; // Make sure this path is correct
import 'ModuleHipno_page2.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'ModuleHipno_page5.dart';
import 'ModuleHipno_page4.dart';
import 'ModuleHipno_page3.dart';
import 'ModuleHipnomp3_1.dart';
import 'ModuleOpening.dart';

import 'ModuleHipno.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.bethesdacolor),
        useMaterial3: false,
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
        appBar: AppBar(
          backgroundColor: AppColors.whitewhite,
          scrolledUnderElevation: 3.0,
          elevation: 3,
          shadowColor: Colors.grey,
          // Custom shadow color

          leading: SizedBox(
            width: MediaQuery.of(context)
                .size
                .width, // Wide enough to fit image and title
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03), // Spacer
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/images/bethesda_gyermekkorhaz_logo.png",
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Bethesda Gyermekkórház Fájdalomkezelő Centrum",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      color: AppColors.bethesdacolor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width *
                          0.05), // Add padding to the right of the text
                  child: Text(
                    "Kutatási fázis",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      color: AppColors.bethesdacolor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          leadingWidth: MediaQuery.of(context)
              .size
              .width, // Ensure the leading area is wide enough
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  // Background Layer

                  Column(
                    children: [
                      Container(
                        color: AppColors.lightshade,
                        // Use your desired background color
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.33,
                            right: MediaQuery.of(context).size.width * 0.05),
                        // Indentation for the rows
                        child: Column(
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.03),
                            Row(
                              children: [
                                Expanded(
                                  // This will allow text to wrap within the row.
                                  child: Text("Mi az a hipnózis?",
                                      style: MyTextStyles.vastagnagybekezdes(
                                          context)),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            Row(
                              children: [
                                Expanded(
                                  // This ensures the text fits within the available space and wraps.
                                  child: Text(
                                    "Sokszor, amikor hipnózisról beszélünk, a gyerekek és a felnőttek is egy olyan embert képzelnek maguk elé, akinek ijesztő tekintetétől valamiféle önkívületi állapotba kerülünk vagy elalszunk. Azt hiszik, ennek az állapotnak a hatására nem fogunk emlékezni semmire. Sok gyerek még arról is meg van győződve, hogy ez az ijesztő, hipnotizáló ember átveheti a testük felett az irányítást és olyan dolgok megtételére kényszerítheti őket, amit nem is akarnak. Más gyermekek Ká-ra, a kígyóra gondolnak (A dzsungel könyvéből), aki a szemét használja, hogy a fiúcska, Maugli, valamiféle önkívületi állapotba essen és azután mozdulni se tudjon.",
                                    style: MyTextStyles.bekezdes(context),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3, // Higher flex value for more space
                                  child: RichText(
                                    textAlign: TextAlign.justify,
                                    text: TextSpan(
                                      style: TextStyle(
                                        color:
                                            Colors.black, // Default text color
                                        fontSize: 16,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "Valóban ilyesmi a ",
                                          style: MyTextStyles.bekezdes(context),
                                        ),
                                        TextSpan(
                                          text: 'színpadi hipnózis',
                                          style: MyTextStyles.vastagbekezdes(
                                              context),
                                        ),
                                        TextSpan(
                                            text:
                                                ', de ennek semmi köze sincs az ',
                                            style:
                                                MyTextStyles.bekezdes(context)),
                                        TextSpan(
                                            text: "orvosi hipnózishoz.",
                                            style: MyTextStyles.vastagbekezdes(
                                                context)),
                                        TextSpan(
                                            text:
                                                " Az orvosi hipnózis sokkal inkább az álmodozáshoz hasonlít, álmodozni pedig a legtöbb gyerek szeret és elég jól is tud. Képzeld el, hogy épp az osztályteremben ülsz és valami érdekes dologra gondolsz. Mondjuk a kedvenc hobbidra, például a focira. A képzeletedben éppen focizol, látod a többi játékost, talán néhány barátodat is, odapasszolják neked a labdát, te pedig lőni készülsz…és akkor… A tanár hirtelen felszólít téged. Valószínűleg meglepődsz, mert fogalmad sincs, miről is beszélt a tanár mostanáig. Álmodoztál és ezért egészen másra figyeltél, máshol jártál a képzeletedben.",
                                            style:
                                                MyTextStyles.bekezdes(context)),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01),
                                // Space between the text and image
                                Expanded(
                                  flex: 1, // Lower flex value for less space
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.blueish, // Color of the border
                                        width: 3, // Width of the border
                                      ),
                                      borderRadius: BorderRadius.circular(10), // Rounded corners
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(7), // Make sure this matches the container's border radius
                                      child: Image.asset(
                                        'assets/images/ka.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),

                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            Row(
                              children: [
                                Expanded(
                                  // This ensures the text fits within the available space and wraps.
                                  child: Text(
                                    "Az orvosi hipnózis valójában pont ilyen. Gyakorlatokat fogsz hallgatni és közben a gondolataidra figyelsz. Talán még azt is elfelejted majd, hogy a saját szobádban vagy. Ezeket a gyakorlatokat néha képzelet-gyakorlatoknak is nevezzük, mert ilyenkor képeket alkotsz a saját fejedben. Ezek szép és barátságos képek. Egy ilyen kép megmutathat téged egy különleges tengerparton vagy éppen megnézheted, hogy hogyan is néz ki a saját pocakod. Az önhipnózis során semmi olyan nem történhet, amit te nem szeretnél. A hipnózis során teljes mértékben te irányítod az eseményeket.",
                                    style: MyTextStyles.bekezdes(context),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),

                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.blueish,
                                border: Border.all(
                                    color: AppColors.whitewhite, width: 4),
                              ),
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Padding(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.01),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  // This will justify the text according to textAlign
                                  children: [
                                    Text(
                                      "A hipnózis:",
                                      style: MyTextStyles.feherkicsikovercim(
                                          context),
                                      textAlign: TextAlign.justify,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01),
                                      child: Column(
                                        children: [
                                          Text(
                                            "\n• Álmodozás \n• Szép dolgokról \n• Amit te irányítasz",
                                            style:
                                                MyTextStyles.feherkicsikovercim(
                                                    context),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ],
                                      ),
                                    )

                                    // Additional widgets here if needed
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.07),

                            Row(
                              children: [
                                Expanded(
                                  // This will allow text to wrap within the row.
                                  child: Text("A hipnózis hatása a hasfájásra",
                                      style: MyTextStyles.vastagnagybekezdes(
                                          context)),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            Row(
                              children: [
                                Expanded(
                                  // This ensures the text fits within the available space and wraps.
                                  child: Text(
                                    "Bebizonyítottuk, hogy hipnózissal befolyásolható a hasfájás. Két vizsgálatban több mint 300, hozzád hasonlóan hasi problémákkal küzdő gyereknél figyeltük meg, hogy ezek a gyakorlatok sokat segítenek abban, hogy a pocakjuk jobban érezze magát. Fontos, hogy ezeket a gyakorlatokat mindennap hallgasd meg, hogy a módszer tényleg működhessen. Minél többet gyakorolsz, annál jobban működik. Olyan ez, mint amikor úszni vagy focizni tanulsz: minél többet gyakorolsz, annál ügyesebb leszel. Ebben a videóban Doktor Major János elmagyarázza, miért segít olyan sokat a hipnózis a hasfájás enyhítésében.",
                                    style: MyTextStyles.bekezdes(context),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.43,
                                // Adjust the width as needed
                                height: MediaQuery.of(context).size.width *
                                    0.43 *
                                    (9 / 16),
                                // Maintain a 16:9 aspect ratio
                                child: HtmlWidget(
                                  '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/mi%C3%A9rt%20j%C3%B3%20a%20hipn%C3%B3zis%20hasi%20f%C3%A1jdalomra.mp4" ></video>',
                                  // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                                ),
                              ),
                            ),

                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.03),
                            Row(
                              children: [
                                Expanded(
                                  // This ensures the text fits within the available space and wraps.
                                  child: Text(
                                    "Mint már tudod, öt hipnózis gyakorlatot rögzítettünk neked. Arra kérünk, hogy naponta legalább egyszer hallgasd meg ezeket a gyakorlatokat, de akár többször is meghallgathatod őket. Fontos, hogy senki ne zavarjon meg téged közben. Ezért az a legjobb, ha a gyakorlatokat a saját szobádban hallgatod. Mindenképpen szólj a többieknek, akik otthon vannak veled, hogy éppen gyakorlatot végzel, nehogy véletlenül besétáljanak a szobádba. A legtöbb gyereknek az működik a legjobban, ha minden nap ugyanabban az időpontban végzi a gyakorlatokat. Például közvetlenül mielőtt lefekszik aludni, vagy amikor hazaért az iskolából. Meg fogod tapasztalni, hogy neked mi válik be a legjobban. ",
                                    style: MyTextStyles.bekezdes(context),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.03),
                            Row(
                              children: [
                                Expanded(
                                  // This ensures the text fits within the available space and wraps.
                                  child: Text(
                                    "A honlap segítségével nyomon követheted, hogy hányszor hallgattad a gyakorlatokat. Ez segít abban, hogy egészségesebbé és erősebbé válj. Naponta emlékeztetni fogod magadat arra, hogy te vagy a tested ura, és a gyakorlatokat minden egyes gyakorlással egyre ismerősebbnek és természetesebbnek fogod találni.",
                                    style: MyTextStyles.bekezdes(context),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.03),
                            Row(
                              children: [
                                Expanded(
                                  // This ensures the text fits within the available space and wraps.
                                  child: Text(
                                    "Készen állsz? Akkor kezdjünk hozzá!",
                                    style: MyTextStyles.bethesdagomb(
                                        context),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.03),

                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.blueish,
                                border: Border.all(
                                    color: AppColors.whitewhite, width: 4),
                              ),
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Padding(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.01),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  // This will justify the text according to textAlign
                                  children: [
                                    Text(
                                      "Tippek a gyakorlatok meghallgatásához:",
                                      style: MyTextStyles.feherkicsikovercim(
                                          context),
                                      textAlign: TextAlign.justify,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01),
                                      child: Column(
                                        children: [
                                          Text(
                                            "\n• Gyakorolj minden nap \n• Csendes helyen \n• Azonos időben",
                                            style:
                                                MyTextStyles.feherkicsikovercim(
                                                    context),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ],
                                      ),
                                    )
                                    // Additional widgets here if needed
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.03),

                            Row(
                              children: [
                                Expanded(
                                  // This will allow text to wrap within the row.
                                  child: Text("Mi okozza a hasfájást?",
                                      style: MyTextStyles.vastagnagybekezdes(
                                          context)),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            Row(
                              children: [
                                Expanded(
                                  // This ensures the text fits within the available space and wraps.
                                  child: Text(
                                    "Lehet, hogy az orvosod már beszélt erről veled. Ismételjünk át néhány dolgot annak érdekében, hogy te is és a szüleid is igazán jól megértsétek ezeket! Az irritábilis bélrendszerrel vagy krónikus hasi fájdalommal küzdő gyermekeknél a belek túlérzékennyé váltak. Mit is jelent ez?\nMindannyian tudjuk, hogy ha például megégetjük a kezünket, akkor hirtelen erős fájdalmat érzünk. Ez a fájdalom egy riasztás, ami jelzi, hogy valami nincs rendben a szervezetünkkel. Ha nem éreznénk a fájdalmat, nem lenne okunk arra, hogy elhúzzuk a kezünket a tűztől. A fájdalom tehát egy fontos figyelmeztető jelzés. Azonban a hasadban ez a riasztórendszer túlérzékennyé vált. Olyan ez, mint egy házban a riasztó: akkor kellene bekapcsolnia, amikor betörő van a házban, de ez a rendszer olyan érzékeny, hogy például egy házon átrepülő kis rovar is beindítja. Valami hasonló történik a hasadban is. Fájdalmat érezhetsz, ha például ettél egy megromlott szendvicset, de akkor is érzel fájdalmat, ha egy egészséges és friss szendvicset eszel, vagy akkor is, ha egyáltalán nem is eszel semmit. Bármikor és bárhol fájhat a hasad. Tudjuk, hogy valójában nincsen semmi komoly baja a hasadnak. A pocakod egyszerűen túl érzékennyé vált.",
                                    style: MyTextStyles.bekezdes(context),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            Row(
                              children: [
                                Expanded(
                                  // This ensures the text fits within the available space and wraps.
                                  child: Text(
                                    "Nézd meg ezt a videót a túlérzékeny bélműködésről.",
                                    style: MyTextStyles.bekezdes(context),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.43,
                                // Adjust the width as needed
                                height: MediaQuery.of(context).size.width *
                                    0.43 *
                                    (9 / 16),
                                // Maintain a 16:9 aspect ratio
                                child: HtmlWidget(
                                  '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/hogyan%20alakul%20ki%20a%20%C3%BAl%C3%A9rz%C3%A9keny%20b%C3%A9lm%C5%B1k%C3%B6d%C3%A9s.mp4" ></video>',

                                ),
                              ),
                            ),

                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05),
                            Row(
                              children: [
                                Expanded(
                                  // This will allow text to wrap within the row.
                                  child: Text("Az ördögi kör",
                                      style: MyTextStyles.vastagnagybekezdes(
                                          context)),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            Row(
                              children: [
                                Expanded(
                                  // This ensures the text fits within the available space and wraps.
                                  child: Text(
                                    "Amikor fájdalmat érzel, akkor olyan gondolataid lehetnek, mint: 'Remélem, hogy nem lesz rosszabb, mert iskolába akarok menni.' vagy 'El akarok menni arra a meccsre. Valószínűleg így nem fogok tudni.'. \nAmikor így gondolkodsz, az izmaid megfeszülnek, bár lehet, hogy észre sem veszed.",
                                    style: MyTextStyles.bekezdes(context),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            // You can add more rows as needed
                            Row(
                              children: [
                                Expanded(
                                  // This ensures the text fits within the available space and wraps.
                                  child: Text(
                                    "Ettől aggódhatsz és szomorú lehetsz, a szíved elkezdhet gyorsabban verni, és mindezek miatt a fájdalmat még rosszabbnak érezheted. Lehet, hogy másképp is kezdesz lélegezni: a nyugodt, laza és mély hasi légzés helyett talán szaporán kapkodod a levegőt.",
                                    style: MyTextStyles.bekezdes(context),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            // You can add more rows as needed
                            Row(
                              children: [
                                Expanded(
                                  // This ensures the text fits within the available space and wraps.
                                  child: Text(
                                    "Mindezek miatt olyan érzésed lehet, hogy egy negatív körben jársz körbe-körbe, amit mi 'ördögi körnek' hívunk. Úgy érezheted, hogy tehetetlen vagy. ",
                                    style: MyTextStyles.bekezdes(context),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            // You can add more rows as needed
                            Row(
                              children: [
                                Expanded(
                                  // This ensures the text fits within the available space and wraps.
                                  child: Text(
                                    "Így néz ki ez az ördögi kör:",
                                    style: MyTextStyles.bekezdes(context),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                // First column for text
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    child: Image.asset(
                                      'assets/images/ordogikor.png',
                                    ),
                                  ),
                                ),
                                // Second column for image
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.blueish, // Your desired color of the border
                                          width: 2, // The thickness of the border
                                        ),
                                        borderRadius: BorderRadius.circular(5), // Optional: if you want rounded corners
                                        color:AppColors.whitewhite, // Set the background color for the surrounding area
                                      ),
                                      child: Text(
                                        "Az (ön)hipnózis gyakorlatok segítségével megtörheted ezt a kört és megtanulhatod, hogyan tudod megállítani a fájdalmat és a fájdalommal kapcsolatos nehéz gondolatokat. \nOlyan gyerekektől tudjuk ezt, akik a gyakorlás által egyre jobban és jobban érzik magukat. Az ördögi kör megszakad, majd fokozatosan eltűnik.",
                                        style: MyTextStyles.bekezdes(context),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // itt volt scroll

                  // Front Layer with Clickable parts
                  Positioned(
                    top: 0,
                    left: 0,
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          0.3, // Sidebar width
                      color:
                          Colors.white.withOpacity(1), // Slightly transparent
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.03,
                            left: MediaQuery.of(context).size.width * 0.04),
                        // Set the desired top and left padding
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          // Sidebar width
                          color: Colors.white.withOpacity(0.3),
                          // Fully opaque white
                          child: Column(
                            children: [
                              Text(
                                'Fájdalomkezelési kisokos',
                                textAlign: TextAlign.left,
                                style:
                                    MyTextStyles.huszonkettobekezdes(context),
                              ),
                              Container(
                                color: AppColors.whitewhite,
                                // Set a different background color for the outer container
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.03,
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    // Inner container color
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(
                                          20.0), // Rounded corner for inner container
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.whitewhite,
                                  // Use your specific color variable
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    // Adjust the radius as needed
                                    bottomLeft: Radius.circular(20.0),
                                  ),
                                ),
                                child: ListTile(
                                  leading:
                                      Image.asset('assets/images/2icon.png'),
                                  // Replace 'your_image.png' with your image path
                                  title: Text(
                                    'Üdvözlő',
                                    style: MyTextStyles.vastagbekezdes(context),
                                  ),
                                  onTap: () async {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ModuleOpening(),
                                      ),
                                    );

                                    print("gomb");
                                  },
                                ),
                              ),
                              Container(
                                color: AppColors.whitewhite,
                                // Set a different background color for the outer container
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.02,
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    // Inner container color
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(
                                          20.0), // Rounded corner for inner container
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                'Anyagok',
                                textAlign: TextAlign.left,
                                style: MyTextStyles.huszonegybekezdes(context),
                              ),
                              Container(
                                color: AppColors.lightshade,
                                // Set a different background color for the outer container
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.03,
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    // Inner container color
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(
                                          20.0), // Rounded corner for inner container
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.lightshade,
                                  // Use your specific color variable
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    // Adjust the radius as needed
                                    bottomLeft: Radius.circular(20.0),
                                  ),
                                ),
                                child: ListTile(
                                  leading:
                                      Image.asset('assets/images/5icon.png'),
                                  // Replace 'your_image.png' with your image path
                                  title: Text(
                                    '1-2. hét',
                                    style: MyTextStyles.vastagbekezdes(context),
                                  ),
                                  subtitle: Text(
                                    'Elérhető',
                                    // Replace this text with what you want as a subtitle
                                    style: MyTextStyles.kicsibekezdes(context),
                                  ),
                                  onTap: () {
                                    print('Button pressed ...');
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ModuleHipno(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                color: AppColors.lightshade,
                                // Set a different background color for the outer container
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.02,
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    // Inner container color
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(
                                          20.0), // Rounded corner for inner container
                                    ),
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Image.asset('assets/images/4icon.png'),
                                // Replace 'your_image.png' with your image path
                                title: Text(
                                  '3-4. hét',
                                  style: MyTextStyles.vastagbekezdes(context),
                                ),
                                subtitle: Text(
                                  'Zárolva',
                                  // Replace this text with what you want as a subtitle
                                  style: MyTextStyles.kicsibekezdes(context),
                                ),
                                onTap: () {
                                  print('Button pressed ...');
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ModuleHipno2(),
                                    ),
                                  );
                                },
                              ),
                              Container(
                                color: AppColors.whitewhite,
                                // Set a different background color for the outer container
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.02,
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    // Inner container color
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(
                                          20.0), // Rounded corner for inner container
                                    ),
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Image.asset('assets/images/6icon.png'),
                                // Replace 'your_image.png' with your image path
                                title: Text(
                                  '5-6. hét',
                                  style: MyTextStyles.vastagbekezdes(context),
                                ),
                                subtitle: Text(
                                  'Zárolva',
                                  // Replace this text with what you want as a subtitle
                                  style: MyTextStyles.kicsibekezdes(context),
                                ),
                                onTap: () {
                                  print('Button pressed ...');
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ModuleHipno3(),
                                    ),
                                  );
                                },
                              ),
                              Container(
                                color: AppColors.whitewhite,
                                // Set a different background color for the outer container
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.02,
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    // Inner container color
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(
                                          20.0), // Rounded corner for inner container
                                    ),
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Image.asset('assets/images/3icon.png'),
                                // Replace 'your_image.png' with your image path
                                title: Text(
                                  '7-8. hét',
                                  style: MyTextStyles.vastagbekezdes(context),
                                ),
                                subtitle: Text(
                                  'Zárolva',
                                  // Replace this text with what you want as a subtitle
                                  style: MyTextStyles.kicsibekezdes(context),
                                ),
                                onTap: () {
                                  print('Button pressed ...');
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ModuleHipno4(),
                                    ),
                                  );
                                },
                              ),
                              Container(
                                color: AppColors.whitewhite,
                                // Set a different background color for the outer container
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.02,
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    // Inner container color
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(
                                          20.0), // Rounded corner for inner container
                                    ),
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Image.asset('assets/images/7icon.png'),
                                // Replace 'your_image.png' with your image path
                                title: Text(
                                  '9-12. hét',
                                  style: MyTextStyles.vastagbekezdes(context),
                                ),
                                subtitle: Text(
                                  'Zárolva',
                                  // Replace this text with what you want as a subtitle
                                  style: MyTextStyles.kicsibekezdes(context),
                                ),
                                onTap: () {
                                  print('Button pressed ...');
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ModuleHipno5(),
                                    ),
                                  );
                                },
                              ),
                              Container(
                                color: AppColors.whitewhite,
                                // Set a different background color for the outer container
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.02,
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    // Inner container color
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(
                                          20.0), // Rounded corner for inner container
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //ide kell záró
            ],
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
