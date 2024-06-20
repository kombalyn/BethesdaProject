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

class ModuleOpening extends StatelessWidget {
  String Azonosito = '';
  ModuleOpening(String s, {super.key}){Azonosito=s;}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fájdalomkezelés - hipnózis',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.bethesdacolor),
        useMaterial3: false,
      ),
      home:  ModuleOpeningWidget(Azonosito),
    );
  }
}

class ModuleOpeningWidget extends StatefulWidget {
  String Azonosito = '';
  ModuleOpeningWidget(String azonosito, {super.key}){Azonosito=azonosito;}

  @override
  State<ModuleOpeningWidget> createState() => _ModuleOpeningWidgetState(Azonosito);
}

class _ModuleOpeningWidgetState extends State<ModuleOpeningWidget> {
  late HomePageModel _model;
  bool _isPlaying = false;
  late AnimationController _animationController;
  late double _currentPointOnFunction = 0; // Az aktuális függvényérték
  late double _sliderValue = 0.0; // A csúszka értéke
  late bool toggle = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  String Azonosito = '';
  _ModuleOpeningWidgetState(String azonosito){Azonosito=azonosito;}

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();



  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar:  AppBar(
        backgroundColor: AppColors.whitewhite,
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
                          builder: (BuildContext context) => ModuleOpening('Azonosito'),
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

              // Expanded(
              //   child: Text(
              //     "Bethesda Gyermekkórház Fájdalomkezelő Centrum",
              //     style: MyTextStyles.bekezdes(context),
              //     overflow: TextOverflow.ellipsis,
              //   ),
              // ),
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
                          height: MediaQuery.of(context).size.width * 0.05),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.73, // 73% of the screen width
                          height: MediaQuery.of(context).size.width * 0.4,  // Increase height proportionately
                          child: HtmlWidget(
                            '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/szia.mp4" ></video>',
                          ),
                        ),
                      ),
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
                              "Ezen a honlapon tudod meghallgatni a hipnózis gyakorlatokhat és segít abban is, hogy hol és mikor végezd őket. A legtöbb gyerek nagyon szereti hallgatni ezeket a gyakorlatokat és azt tapasztalja, hogy jót tesznek a pocakjának is.",
                              style: MyTextStyles.bekezdes(context),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Row(
                        children: [
                          Expanded(
                            // This ensures the text fits within the available space and wraps.
                            child: Text(
                              "Öt olyan hipnózis gyakorlatot találsz itt a hetek során, melyek hasfájással küzdő általános iskolás és gimnazista tizenévesek számára készültek. Ez a honlap segít abban, hogy milyen sorrendben, mikor és hogyan használd őket.",
                              style: MyTextStyles.bekezdes(context),
                              textAlign: TextAlign.justify,
                            ),
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
                              "Reméljük élvezni fogod ezeket a gyakorlatokat és jól szórakozol majd!",
                              style: MyTextStyles.bekezdes(context),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.blueish,
                          border:
                              Border.all(color: AppColors.whitewhite, width: 4),
                        ),
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                // Adjust the radius as needed
                                child: Image.asset(
                                    "assets/images/fox-horizontal-nobackground_2.png"),
                              ),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.width * 0.017,
                              right: MediaQuery.of(context).size.width * 0.005,
                              child: Text(
                                'Ha készen állsz a következő \nmodulra kattints az \nalábbi gombra!',
                                style: MyTextStyles.feherkovercim(context),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.width * 0.09,
                              right: MediaQuery.of(context).size.width * 0.04,
                              child: ElevatedButton(
                                onPressed: () {
                                  print('Button pressed ...');
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ModuleHipno(),
                                    ),
                                  );
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
                            ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          leading: Image.asset('assets/images/2icon_b.png'),
                          // Replace 'your_image.png' with your image path
                          title: Text(
                            'Üdvözlő',
                            style: MyTextStyles.vastagblueish(context),
                          ),
                          onTap: () async {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ModuleOpening('Azonosito'),
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
                            'Elérhető',
                            // Replace this text with what you want as a subtitle
                            style: MyTextStyles.kicsibekezdes(context),
                          ),
                          onTap: () {
                            print('Button pressed ...');
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
                        leading: Image.asset('assets/images/3icon_b.png'),
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
          Positioned(
            top: MediaQuery.of(context).size.width * 0.029, // Adjust to match the text's top padding
            left: 0, // Adjust to position next to the text
            child: Container(
              width: MediaQuery.of(context).size.width * 0.03, // Adjust the width as needed
              height: MediaQuery.of(context).size.height * 0.05, // Adjust the height as needed
              color: AppColors.blueish, // Adjust the color as needed
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
