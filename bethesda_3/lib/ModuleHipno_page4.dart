import 'dart:js';
import 'package:bethesda_2/styles.dart';
import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:bethesda_2/constants/colors.dart'; // Make sure this path is correct
import 'ModuleHipno_page2.dart';
import 'ModuleHipno_page5.dart';
import 'ModuleHipno_page4.dart';
import 'ModuleHipno_page3.dart';
import 'ModuleHipno.dart';
import 'ModuleHipnomp3_1.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'ModuleOpening.dart';

import 'ModuleHipno.dart';
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



class ModuleHipno4 extends StatelessWidget {
  const ModuleHipno4({super.key});

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

    /*
    _controller = _controller = VideoPlayerController.asset('assets/videos/kronikus_hasi_fajdalom.mp4')
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
                    style: MyTextStyles.cim(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width *
                          0.05), // Add padding to the right of the text
                  child: Text(
                    "Kutatási fázis",
                    style: MyTextStyles.cim(context),
                  ),
                ),
              ],
            ),
          ),
          leadingWidth: MediaQuery.of(context)
              .size
              .width, // Ensure the leading area is wide enough
        ),
        body: SingleChildScrollView( child:
        Column(
          children: [
            Stack(
              children: [
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
                            height: MediaQuery.of(context).size.width * 0.03),
                        Row(
                          children: [
                            Expanded(
                              // This will allow text to wrap within the row.
                              child: Text("Szia!",
                                  style: MyTextStyles.bethesdagomb(context)),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              // Allocates 3 parts of the space to the text
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Máris eltelt hat hét. Itt az ideje egy újabb gyakorlatnak, aminek a címe: A Csúszda. Ez egy szuper felvétel, ami úgy segít a hasadnak ellazulni, hogy közben egyre jobban érzed magad. Minél többet gyakorlod ezt, annál boldogabb lesz a pocakod is.A következő két hét során mindennap hallgasd meg ezt a gyakorlatot legalább naponta egyszer. Továbbá arra kérünk, hogy az előző négy felvétel valamelyikét is hallgasd meg minden nap. Váltogathatod őket a különböző napokon, vagy hallgathatod mindennap ugyanazt. Ahogyan neked jobb.",
                                    style: MyTextStyles.bekezdes(context),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),


                            SizedBox(
                                width:
                                MediaQuery.of(context).size.width * 0.03),
                            Expanded(
                              flex: 1,
                              // Allocates 2 parts of the space to the image
                              child:
                              Container(
                                width: MediaQuery.of(context).size.width * 0.15, // 15% of the screen width
                                height: MediaQuery.of(context).size.width * 0.15, // Same as width to maintain aspect ratio
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.blueish, // Set border color here
                                    width: 3, // Set border width here
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    'assets/images/7-8.png',
                                    width: MediaQuery.of(context).size.width * 0.15,
                                    height: MediaQuery.of(context).size.width * 0.15,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),


                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.03),
                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Reméljük tetszeni fog!",
                                style: MyTextStyles.bekezdes(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10), // Adjust the corner radius
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.43, // Adjust the width as needed
                              height:  MediaQuery.of(context).size.width * 0.05, // Adjust the height to make it thin
                              child: HtmlWidget(
                                '<audio controls style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A csuszda.mp3" ></audio>',
                                // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Eddig ennyiszer hallgattad meg ezt a hanganyagot:",
                                style: MyTextStyles.bekezdes(context),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            SizedBox(
                                width:
                                MediaQuery.of(context).size.width * 0.03),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Maintain the same border radius
                              ),
                              color: AppColors.whitewhite,
                              // Background color of the card
                              child: InkWell(

                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  // Adjust padding to fit your design needs
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    // Use the minimum space required by the children
                                    children: [
                                      Text(
                                        'Szám!', // Your button text
                                        style:
                                        MyTextStyles.bluegomb(context),
                                      ),
                                      // Add more widgets if needed
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),



                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.2),

                        // You can add more rows as needed
                      ],
                    ),
                  ),
                ],
              ),


            // Front Layer with Clickable parts
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3, // Sidebar width
                color: Colors.white.withOpacity(1), // Slightly transparent
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.03,
                      left: MediaQuery.of(context).size.width * 0.04), // Set the desired top and left padding
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
                          style: MyTextStyles.huszonkettobekezdes(context),
                        ),
                        Container(
                          color: AppColors.whitewhite,
                          // Set a different background color for the outer container
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.03,
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
                            leading: Image.asset('assets/images/2icon_b.png'),
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
                            height: MediaQuery.of(context).size.width * 0.02,
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
                          color: AppColors.whitewhite,
                          // Set a different background color for the outer container
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.03,
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
                            leading: Image.asset('assets/images/5icon_b.png'),
                            // Replace 'your_image.png' with your image path
                            title: Text(
                              '1-2. hét',
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
                                      ModuleHipno(),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          color: AppColors.whitewhite,
                          // Set a different background color for the outer container
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.02,
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
                            leading: Image.asset('assets/images/4icon_b.png'),
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
                        ),

                        Container(
                          color: AppColors.whitewhite,
                          // Set a different background color for the outer container
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.02,
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
                            leading: Image.asset('assets/images/6icon_b.png'),
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
                        ),

                        Container(
                          color: AppColors.lightshade,
                          // Set a different background color for the outer container
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.02,
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
                            leading: Image.asset('assets/images/3icon_b.png'),
                            // Replace 'your_image.png' with your image path
                            title: Text(
                              '7-8. hét',
                              style: MyTextStyles.vastagblueish(context),
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
                                      ModuleHipno4(),
                                ),
                              );
                            },
                          ),
                        ),

                        Container(
                          color: AppColors.whitewhite,
                          // Set a different background color for the outer container
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.02,
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
                          leading: Image.asset('assets/images/7icon_b.png'),
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
                            height: MediaQuery.of(context).size.width * 0.02,
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
