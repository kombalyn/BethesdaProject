import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:bethesda_2/constants/colors.dart'; // Make sure this path is correct
import 'gdpr.dart'; // Ensure this module is correctly implemented

// Assuming 'main.dart' and 'home_page_model.dart' are correctly set up.

class MyTextStyles {
  static final TextStyle myCommonStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    color: AppColors.darkshade,
  );
}

class Email extends StatelessWidget {
  const Email({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fájdalomkezelés regisztráció',
      theme: ThemeData(
        cardTheme: CardTheme(
          color: Colors.white, // This sets the background color of cards to white
        ),
      ),
      home: const HomePageWidgetEmail(),
    );
  }
}

class HomePageWidgetEmail extends StatefulWidget {
  const HomePageWidgetEmail({Key? key}) : super(key: key);

  @override
  _HomePageWidgetEmailState createState() => _HomePageWidgetEmailState();
}

class _HomePageWidgetEmailState extends State<HomePageWidgetEmail> {
  late HomePageModel _model;

  bool _termsRead = false;
  bool _consentGiven = false;
  bool _guardianAgreed = false;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();  // Ensure that HomePageModel is correctly initialized
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _launchURL(String url) async {
    if (!await canLaunch(url)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch $url'),
        ),
      );
    } else {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: AppColors.whitewhite,
          scrolledUnderElevation: 0.0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/images/bethesda_gyermekkorhaz_logo.png",
                width: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
          ),
          title: const Text(
            "Bethesda Gyermekkórház Fájdalomkezelő Centrum",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20,
              color: AppColors.bethesdacolor,
            ),
          ),
          actions: const [
            Center(
              child: Text(
                'Kutatási fázis',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  color: AppColors.bethesdacolor,
                ),
              ),
            ),
            SizedBox(width: 16), // For spacing
          ],
        ),
        backgroundColor: AppColors.whitewhite,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.width * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Card(
                        elevation: 1,
                        color: AppColors.lightaccentcolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                          child: Text(
                            "ezen az oldalon kell majd emailcímet és nevet kérni, ezután kijelezni a kutatási azonítóját, amit aztán el is küldünk neki emailen, és a REDCAPES form linkjét behelyezni",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: AppColors.whitewhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                  ],
                ),

              ),


              Container(
                color: AppColors.bethesdacolor, // Replace with your desired background color
                padding: const EdgeInsets.symmetric(vertical: 15), // Adjust padding as needed
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.12), // Adjust the padding as necessary
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                '+36 1 920 6000',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16,
                                  color: AppColors.lightshade,
                                ),
                              ),
                              Text(
                                'bethesda@bethesda.hu',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16,
                                  color: AppColors.lightshade,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.12), // Adjust the padding as necessary
                          child: Image.asset(
                            "assets/images/bethesda_white_logo_name.png", // Replace with your logo asset path
                            width: 100, // Adjust the size as necessary
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20), // Space between rows
                    Text(
                      'Magyarországi Református Egyház Bethesda Gyermekkórháza – 1146 Budapest, Bethesda utca 3. (Zugló)',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        color: AppColors.lightshade,
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}

