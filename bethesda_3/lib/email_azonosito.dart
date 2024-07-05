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

class Email extends StatelessWidget {
  const Email({Key? key}) : super(key: key);

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
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                Center(
                                  child: Text("Készítsük el a profilod", style: MyTextStyles.cim(context)),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional.centerStart,
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              0, MediaQuery.of(context).size.width * 0.03, 0, 0),
                                          child: Text(
                                            'Regisztráló neve:',
                                            textAlign: TextAlign.center,
                                            style: MyTextStyles.bekezdes(context),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.whitewhite,
                                                border: Border.all(
                                                  color: Colors.grey,
                                                  width: 0.5,
                                                ),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                    MediaQuery.of(context).size.width * 0.005, 0,
                                                    MediaQuery.of(context).size.width * 0.005, 0),
                                                child: TextFormField(
                                                  controller: _model.textController1,
                                                  focusNode: _model.textFieldFocusNode1,
                                                  autofocus: true,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.zero,
                                                    labelText: 'Vezetéknév...',
                                                    labelStyle: MyTextStyles.kicsisbethesdabekezdes(context),
                                                    enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    focusedBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    errorBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.red,
                                                        width: 2,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    focusedErrorBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.red,
                                                        width: 2,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  style: MyTextStyles.kicsibekezdes(context),
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'Kérjük, töltse ki ezt a mezőt';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.whitewhite,
                                                border: Border.all(
                                                  color: Colors.grey,
                                                  width: 0.5,
                                                ),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                    MediaQuery.of(context).size.width * 0.005, 0,
                                                    MediaQuery.of(context).size.width * 0.005, 0),
                                                child: TextFormField(
                                                  controller: _model.textController2,
                                                  focusNode: _model.textFieldFocusNode2,
                                                  autofocus: true,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.zero,
                                                    labelText: 'Keresztnév...',
                                                    labelStyle: MyTextStyles.kicsisbethesdabekezdes(context),
                                                    enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    focusedBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    errorBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.red,
                                                        width: 2,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    focusedErrorBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.red,
                                                        width: 2,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  style: MyTextStyles.kicsibekezdes(context),
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'Kérjük, töltse ki ezt a mezőt';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      //EMAIL
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.35,
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional.centerStart,
                                              child: Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                    0, MediaQuery.of(context).size.width * 0.03, 0, 0),
                                                child: Text(
                                                  'E-mail:',
                                                  textAlign: TextAlign.center,
                                                  style: MyTextStyles.bekezdes(context),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.whitewhite,
                                                border: Border.all(
                                                  color: Colors.grey,
                                                  width: 0.5,
                                                ),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                    MediaQuery.of(context).size.width * 0.005, 0,
                                                    MediaQuery.of(context).size.width * 0.005, 0),
                                                child: TextFormField(
                                                  controller: _model.textController3,
                                                  focusNode: _model.textFieldFocusNode1,
                                                  autofocus: true,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.zero,
                                                    labelText: '...',
                                                    labelStyle: MyTextStyles.kicsisbethesdabekezdes(context),
                                                    enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    focusedBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    errorBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.red,
                                                        width: 2,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    focusedErrorBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.red,
                                                        width: 2,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  style: MyTextStyles.kicsibekezdes(context),
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'Kérjük, töltse ki ezt a mezőt';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      //DÖNTÉS
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.35,
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional.centerStart,
                                              child: Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                    0, MediaQuery.of(context).size.width * 0.03, 0, 0),
                                                child: Text(
                                                  'Szülőként vagy gyermekként regisztrál:',
                                                  textAlign: TextAlign.center,
                                                  style: MyTextStyles.bekezdes(context),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.whitewhite,
                                                border: Border.all(
                                                  color: Colors.grey,
                                                  width: 0.5,
                                                ),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                    MediaQuery.of(context).size.width * 0.005, 0,
                                                    MediaQuery.of(context).size.width * 0.005, 0),
                                                child: DropdownButtonFormField<String>(
                                                  value: _selectedOption,
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      _selectedOption = newValue;
                                                    });
                                                  },
                                                  items: <String?>['szülő', 'gyermek']
                                                      .map<DropdownMenuItem<String>>((String? value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(
                                                        value ?? 'Kattints ide...',
                                                        style: MyTextStyles.kicsibekezdes(context),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.zero,
                                                    labelText: 'Válassz...',
                                                    labelStyle: MyTextStyles.kicsisbethesdabekezdes(context),
                                                    enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    focusedBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    errorBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.red,
                                                        width: 2,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    focusedErrorBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.red,
                                                        width: 2,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'Kérjük, válasszon egy lehetőséget';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      //ROKON ADAT
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.35,
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional.centerStart,
                                              child: Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                    0, MediaQuery.of(context).size.width * 0.03, 0, 0),
                                                child: Text(
                                                  _selectedOption == 'szülő'
                                                      ? 'Kutatásban résztvevő gyermekének a TAJ száma:'
                                                      : 'A TAJ számod:',
                                                  textAlign: TextAlign.center,
                                                  style: MyTextStyles.bekezdes(context),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: List.generate(9, (index) {
                                                return Expanded(
                                                  child: Container(
                                                    margin: EdgeInsets.symmetric(horizontal: 2.0),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.whitewhite,
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 0.5,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8.0),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 2.0),
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter.digitsOnly,
                                                          LengthLimitingTextInputFormatter(1),
                                                        ],
                                                        textAlign: TextAlign.center,
                                                        decoration: InputDecoration(
                                                          border: InputBorder.none,
                                                          counterText: '',
                                                        ),
                                                        style: MyTextStyles.kicsibekezdes(context),
                                                        onChanged: (value) {
                                                          if (value.length == 1) {
                                                            if (index < 8) {
                                                              FocusScope.of(context).nextFocus();
                                                            } else {
                                                              FocusScope.of(context).unfocus();
                                                            }
                                                          }
                                                        },
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return ' ';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {
                                            setState(() {
                                              print("regisztracio most en");
                                              _showBigContainer = true;

                                              String? szov1 = _model.textController1?.text;
                                              String? szov2 = _model.textController2?.text;
                                              String? szov3 = _model.textController3?.text;
                                              String? szov4 = _model.textController4?.text;
                                              String? szov5 = _model.textController5?.text;
                                              print("regisztracio|$szov3-$szov1,$szov2,$_selectedOption,NULL,BARMI");

                                              _channel = WebSocketChannel.connect(
                                                Uri.parse('ws://146.148.43.137:8089'),
                                              );
                                              _channel.sink.add(
                                                  "regisztracio|$szov3-$szov1,$szov2,$_selectedOption,NULL,BARMI");
                                              _channel.stream.listen((message) {
                                                print('Received message: $message');
                                                if (message == "True") {
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext context) => AlertDialog(
                                                      title: Text("Regisztrációs Hiba"),
                                                      content: Text(
                                                          "A bevitt adatokkal már regisztráltak. Kérem lépjen be regisztráció helyett a létező fiókjába az email-ben kapott azonosító segítségével."),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () => Navigator.pop(context, 'OK'),
                                                          child: const Text('OK'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext context) => MyApp(),
                                                    ),
                                                  );
                                                } else {
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext context) => AlertDialog(
                                                      title: Text("Regisztráció Sikeres"),
                                                      content: Text("Regisztrációját sikeresen mentettük."),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () => Navigator.pop(context, 'OK'),
                                                          child: const Text('OK'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext context) => MyApp(),
                                                    ),
                                                  );
                                                }
                                              });

                                              print("regisztracio vege");
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Kérjük, töltse ki az összes mezőt.'),
                                              ),
                                            );
                                          }
                                        },
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(
                                              AppColors.bethesdacolor),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                            EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 24),
                                          ),
                                        ),
                                        child: Text(
                                          "Regisztrálok",
                                          textAlign: TextAlign.center,
                                          style: MyTextStyles.gomb(context),
                                        ),
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
