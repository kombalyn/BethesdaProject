import 'package:bethesda_2/styles.dart';
import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'screens/quiz_screen1.dart';
import 'providers/quiz_provider1.dart';
import 'package:provider/provider.dart';
export 'home_page_model.dart';
import 'package:bethesda_2/constants/colors.dart'; // Make sure this path is correct
import 'package:flutter_svg/flutter_svg.dart';

class ModuleOpening_M3 extends StatelessWidget {
  const ModuleOpening_M3({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuizProvider1(),
      child: MaterialApp(
        title: 'Fájdalomkezelés - M3',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
          useMaterial3: false,
        ),
        initialRoute: '/module_opening',
        // Set the initial route to module opening screen
        routes: {
          '/quiz1': (context) => QuizScreen1(),
          '/module_opening': (context) => const ModuleOpening_M3_Widget(),
          // Adding the existing module screen as a route
        },
        home: const ModuleOpening_M3_Widget(), // Default home screen
      ),
    );
  }
}

class ModuleOpening_M3_Widget extends StatefulWidget {
  const ModuleOpening_M3_Widget({super.key});

  @override
  State<ModuleOpening_M3_Widget> createState() =>
      _ModuleOpening_M3_WidgetState();
}

class _ModuleOpening_M3_WidgetState extends State<ModuleOpening_M3_Widget> {
  late HomePageModel _model;
  // late VideoPlayerController _controller;
  bool _isPlaying = false;
  late AnimationController _animationController;
  late double _currentPointOnFunction = 0; // Az aktuális függvényérték
  late double _sliderValue = 0.0; // A csúszka értéke
  late bool toggle = true;
  final ScrollController _scrollController = ScrollController();

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
    // _controller.dispose();
    super.dispose();
    _scrollController.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  // void _playPauseVideo() {
  //   setState(() {
  //     if (_controller.value.isPlaying) {
  //       // _controller.pause();
  //       _isPlaying = false;
  //     } else {
  //       // _controller.play();
  //       _isPlaying = true;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightshade,
        scrolledUnderElevation: 3.0,
        elevation: 3,
        shadowColor: Colors.grey.shade300,
        leading: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.025),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => ModuleOpening_M3(),
                        ),
                      );
                      print("homegomb");
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        child: Image.asset(
                          "assets/images/bethesda_gyermekkorhaz_logo.png",
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.05),
                  child: Text(
                    "Kutatási fázis",
                    style: MyTextStyles.huszonkettobekezdes(context),
                  ),
                ),
              ),
            ],
          ),
        ),
        leadingWidth: MediaQuery.of(context).size.width,
      ),
      body:   SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // Background Layer
                Container(
                  color: AppColors.lightshade, // Your desired background color
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*1.2,
                ),
                // Image Layer
                Align(
                  alignment: Alignment.centerRight,
                  child: Opacity(
                    opacity: 0.6, // Adjust the opacity as needed
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4, // Set your desired width
                      height: MediaQuery.of(context).size.height*1.2,
                      child: SvgPicture.asset(
                        "assets/images/m3hatter.svg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),



                // Overlay content
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.27,
                        right: MediaQuery.of(context).size.width * 0.3,
                      ), // Indentation for the rows
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Szia!",
                                  style: MyTextStyles.bethesdagomb(context),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Ezen a honlapon találsz majd néhány kérdést és videót amivel személyre tudjuk szabni a kezelésed. Kérünk válaszolj majd ezekre figyelemmel. \nA kitöltés körülbelül x percet vesz igénybe. Lehetőleg ne zárd be az ablakot amíg nem végeztél a kitöltéssel.",
                                  style: MyTextStyles.bekezdes(context),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Reméljük élvezni fogod ezeket a gyakorlatokat és jól szórakozol majd!",
                                  style: MyTextStyles.bekezdes(context),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                            SizedBox(height: MediaQuery.of(context).size.width * 0.07),

                          ElevatedButton(
                            onPressed: () {
                              print('Button pressed ...');
                              Navigator.pushNamed(context, '/quiz1');
                            },
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(
                                AppColors.whitewhite,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              padding: MaterialStateProperty.all<
                                  EdgeInsetsGeometry>(
                                EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 24),
                              ),
                            ),
                            child: Text(
                              "Kezdjük!",
                              style: MyTextStyles.bethesdagomb(context),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                          // Container(
                          //   width: MediaQuery.of(context).size.width * 0.45,
                          //   height: MediaQuery.of(context).size.width * 0.2,
                          //   decoration: BoxDecoration(
                          //     border: Border.all(color: Colors.black, width: 1),
                          //   ),
                          //   child: Stack(
                          //     children: [
                          //       SvgPicture.asset(
                          //         "assets/images/m3hatter.svg",
                          //         fit: BoxFit.cover,
                          //       ),
                          //       Positioned(
                          //         bottom: 16, // Adjust the position as needed
                          //         left: 16, // Adjust the position as needed
                          //         child: ElevatedButton(
                          //           onPressed: () {
                          //             // Handle button press
                          //           },
                          //           child: Text('Click Me'),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Add more rows as needed
                        ],
                      ),
                    ),
                  ],
                ),

              Positioned(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    color: Colors.white.withOpacity(1),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.03,
                        left: MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        color: Colors.white.withOpacity(0.3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fájdalomkezelési kisokos',
                              textAlign: TextAlign.left,
                              style: MyTextStyles.huszonkettobekezdes(context),
                            ),
                            Container(
                              color: AppColors.lightshade,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.03,
                                decoration: BoxDecoration(
                                  color: AppColors.whitewhite,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20.0),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: AppColors.lightshade,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(20.0),
                                ),
                              ),
                              child: ListTile(
                                leading:
                                    Image.asset('assets/images/2icon_m.png'),
                                title: Text(
                                  'Kérdések',
                                  style: MyTextStyles.vastagyellow(context),
                                ),
                                onTap: () async {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ModuleOpening_M3(),
                                    ),
                                  );
                                  print("gomb");
                                },
                              ),
                            ),
                            Container(
                              color: AppColors.lightshade,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.02,
                                decoration: BoxDecoration(
                                  color: AppColors.whitewhite,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.0),
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
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.02,
                                decoration: BoxDecoration(
                                  color: AppColors.whitewhite,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.0),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(20.0),
                                ),
                              ),
                              child: ListTile(
                                leading:
                                    Image.asset('assets/images/5icon_m.png'),
                                title: Text(
                                  '1-2. hét',
                                  style: MyTextStyles.vastagbekezdes(context),
                                ),
                                subtitle: Text(
                                  'Zárolva',
                                  style: MyTextStyles.kicsibekezdes(context),
                                ),
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ModuleOpening_M3(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              color: AppColors.whitewhite,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.02,
                                decoration: BoxDecoration(
                                  color: AppColors.whitewhite,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.0),
                                  ),
                                ),
                              ),
                            ),
                            ListTile(
                              leading: Image.asset('assets/images/4icon_m.png'),
                              title: Text(
                                '3-4. hét',
                                style: MyTextStyles.vastagbekezdes(context),
                              ),
                              subtitle: Text(
                                'Zárolva',
                                style: MyTextStyles.kicsibekezdes(context),
                              ),
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ModuleOpening_M3(),
                                  ),
                                );
                              },
                            ),
                            Container(
                              color: AppColors.whitewhite,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.02,
                                decoration: BoxDecoration(
                                  color: AppColors.whitewhite,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.0),
                                  ),
                                ),
                              ),
                            ),
                            ListTile(
                              leading: Image.asset('assets/images/6icon_m.png'),
                              title: Text(
                                '5-6. hét',
                                style: MyTextStyles.vastagbekezdes(context),
                              ),
                              subtitle: Text(
                                'Zárolva',
                                style: MyTextStyles.kicsibekezdes(context),
                              ),
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ModuleOpening_M3(),
                                  ),
                                );
                              },
                            ),
                            Container(
                              color: AppColors.whitewhite,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.02,
                                decoration: BoxDecoration(
                                  color: AppColors.whitewhite,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20.0),
                                  ),
                                ),
                              ),
                            ),
                            ListTile(
                              leading: Image.asset('assets/images/3icon_m.png'),
                              title: Text(
                                '7-8. hét',
                                style: MyTextStyles.vastagbekezdes(context),
                              ),
                              subtitle: Text(
                                'Zárolva',
                                style: MyTextStyles.kicsibekezdes(context),
                              ),
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ModuleOpening_M3(),
                                  ),
                                );
                              },
                            ),
                            Container(
                              color: AppColors.whitewhite,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.02,
                                decoration: BoxDecoration(
                                  color: AppColors.whitewhite,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20.0),
                                  ),
                                ),
                              ),
                            ),
                            ListTile(
                              leading: Image.asset('assets/images/7icon_m.png'),
                              title: Text(
                                '9-12. hét',
                                style: MyTextStyles.vastagbekezdes(context),
                              ),
                              subtitle: Text(
                                'Zárolva',
                                style: MyTextStyles.kicsibekezdes(context),
                              ),
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ModuleOpening_M3(),
                                  ),
                                );
                              },
                            ),
                            Container(
                              color: AppColors.whitewhite,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.02,
                                decoration: BoxDecoration(
                                  color: AppColors.whitewhite,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20.0),
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
                Positioned(
                  top: MediaQuery.of(context).size.width * 0.029,
                  left: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.03,
                    height: MediaQuery.of(context).size.height * 0.05,
                    color: AppColors.yellow,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
