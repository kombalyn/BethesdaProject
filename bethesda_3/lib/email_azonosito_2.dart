import 'package:bethesda_2/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:bethesda_2/constants/colors.dart'; // Make sure this path is correct
import 'package:web_socket_channel/web_socket_channel.dart';
import 'gdpr.dart'; // Ensure this module is correctly implemented
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'main.dart';
import 'styles.dart'; // Make sure this path is correct based on where you placed the styles.dart file
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Assuming 'main.dart' and 'home_page_model.dart' are correctly set up.

/*class MyTextStyles {
  static final TextStyle myCommonStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    color: AppColors.darkshade,
  );
}*/

class Email_2 extends StatelessWidget {
  const Email_2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fájdalomkezelés regisztráció',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        useMaterial3: false,
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
  late WebSocketChannel _channel = WebSocketChannel.connect(
    Uri.parse('ws://146.148.43.137:8089'),
  );

  late HomePageModel _model;
  String? _selectedOption;
  bool _showBigContainer = false;

  bool _termsRead = false;
  bool _consentGiven = false;
  bool _guardianAgreed = false;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();

    _model.textController1 = TextEditingController();
    _model.textController2 = TextEditingController();
    _model.textController3 = TextEditingController();
    _model.textController4 = TextEditingController();
    _model.textController5 = TextEditingController();
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
                            builder: (BuildContext context) => HomePageWidgetEmail(),
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
        backgroundColor: AppColors.lightshade,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Opacity(
                        opacity: 0.6,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 1.2,
                          child: SvgPicture.asset(
                            "assets/images/reg.svg",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.001,
                            right: MediaQuery.of(context).size.width * 0.05,
                            top: MediaQuery.of(context).size.width * 0.01,
                            bottom: MediaQuery.of(context).size.width * 0.03),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03), // Add padding inside the container

                            child: Column(
                              children: [
                                SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                Center(
                                  child: Text("Kérünk, jegyezd fel magadnak az alábbi kutatási azonosítót, hogy a későbbiekben be tudj lépni a felületre, és elkezdhessük a közös munkát: ", style: MyTextStyles.cim(context)),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                Center(child: Text("AZONOSÍTÓ", style: MyTextStyles.vastagnagybekezdes(context)),),
                                SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                Text("Ezt elküldtük neked e-mailben is, ha elveszítenéd azt ahova most felírtad, ott is meg fogod találni", style: MyTextStyles.cim(context)),
                                SizedBox(height: MediaQuery.of(context).size.width * 0.02),

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
}
