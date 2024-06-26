import 'package:bethesda_2/styles.dart';
import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'ModuleHipno_page2.dart';

import 'ModuleHipno_page3.dart';
import 'ModuleHipnomp3_1.dart';
import 'ModuleHipno_page5.dart';
import 'ModuleHipno_page4.dart';
import 'ModuleHipno.dart';
export 'home_page_model.dart';
import 'package:bethesda_2/constants/colors.dart'; // Make sure this path is correct

class ModuleOpening2 extends StatelessWidget {
  const ModuleOpening2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fájdalomkezelés - hipnózis',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.bethesdacolor),
        useMaterial3: false,
      ),
      home: const ModuleOpening2Widget(),
    );
  }
}

class ModuleOpening2Widget extends StatefulWidget {
  const ModuleOpening2Widget({super.key});

  @override
  State<ModuleOpening2Widget> createState() => _ModuleOpening2WidgetState();
}

class _ModuleOpening2WidgetState extends State<ModuleOpening2Widget> {
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

    /*_controller =
        _controller = VideoPlayerController.asset('assets/videos/szia.mp4')
          ..initialize().then((_) {
            setState(() {});
          });
    _isPlaying = true;

    _controller.addListener(() {
      setState(() {});
    });

    _controller.value.isPlaying ? _controller.pause() : _controller.play();

     */
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
    return Scaffold(
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
      body:
      SingleChildScrollView( child:
      Column(
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
                          height: MediaQuery.of(context).size.width * 0.04),
                      Row(
                        children: [
                          Expanded(
                            // This will allow text to wrap within the row.
                            child: Text("Szia!",
                                style:
                                    MyTextStyles.bethesdagomb(context)),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02),
                      Row(
                        children: [
                          Expanded(
                            // This ensures the text fits within the available space and wraps.
                            child: Text(
                              "A legtöbb gyerek mostanra sokkal jobban érzi magát, akár újra teljesen egészséges a pocakja is. Nekik azt üzenjük, hogy szuper munkát végeztek és csak így tovább, folytassák a gyakorlást, hogy a hasuk továbbra is jól érezze magát!\nVannak gyerekek, akiknek viszont lehetnek még hasfájásai, akár egészen gyakran is. Ha a hasad még mindig fáj, akkor is jó ötlet folytatni a gyakorlást, mert a kutatásainkból tudjuk, hogy van, akinek valamivel több idő kell ahhoz, hogy újra jól és egészségesnek érezze magát.\nA következő héttől a kutatás új szakaszába lépsz. Erről szeretnénk mondani néhány gondolatot most.",
                              style: MyTextStyles.bekezdes(context),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),

                          ],
                        ),
                      ),

                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07),

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
                        color: AppColors.lightshade,
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
                          color: AppColors.lightshade,
                          // Use your specific color variable
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            // Adjust the radius as needed
                            bottomLeft: Radius.circular(20.0),
                          ),
                        ),
                        child: ListTile(
                          leading: Image.asset('assets/images/2icon.png'),
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
                                    ModuleOpening2(),
                              ),
                            );

                            print("gomb");
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
                              topRight: Radius.circular(
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
                          leading: Image.asset('assets/images/5icon.png'),
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
      // ide kell záró
    ],
    ),
    ),
    );
  }
}
