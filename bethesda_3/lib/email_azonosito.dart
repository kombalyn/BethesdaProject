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
        useMaterial3: false,
        cardTheme: CardTheme(
          color:
              Colors.white, // This sets the background color of cards to white
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
    //Uri.parse('ws://34.72.67.6:8089'),
    Uri.parse('ws://146.148.43.137:8089'),
  );


  late HomePageModel _model;
  String? _selectedOption; // Change to String?
  bool _showBigContainer = false;

  bool _termsRead = false;
  bool _consentGiven = false;
  bool _guardianAgreed = false;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model =
        HomePageModel(); // Ensure that HomePageModel is correctly initialized

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
        backgroundColor: AppColors.lightshade,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    // Stack(
                    //   children: [
                    //     // Other widgets in the stack
                    //     Visibility(
                    //       visible: _showBigContainer,
                    //       child: Center(
                    //         child: Container(
                    //           width: 500,
                    //           padding: EdgeInsets.all(16.0),
                    //           color: Colors.grey.shade200,
                    //           child: Column(
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: [
                    //               Text(
                    //                 'A KÓD ÉS ÍRJA FEL ÉS EMAILBEN IS MOST ELKÜLDTÜK NEKI',
                    //                 textAlign: TextAlign.center,
                    //               ),
                    //               SizedBox(height: 20),
                    //               ElevatedButton(
                    //                 onPressed: () {
                    //                   setState(() {
                    //                     _showBigContainer = false;
                    //                   });
                    //                 },
                    //                 child: Text('FELÍRTAM'),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    child: Container(
                      color: AppColors.lightshade,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Your other widgets
                          Image.asset(
                            'assets/images/szines_2.png',
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: AppColors.lightshade,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.1,
                        vertical: MediaQuery.of(context).size.width * 0.03),
                        child:Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5), // Shadow color
                                spreadRadius: 5, // Spread radius
                                blurRadius: 7, // Blur radius
                                offset: Offset(0, 3), // Offset in the direction of top-left
                              ),
                            ],
                            color: Colors.white, // Background color
                            borderRadius: BorderRadius.circular(8), // Optional: Add border radius for rounded corners
                          ),
                          child:
                          Column(

                        children: [
                          //ITT DOLGOZOK
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.02),
                          Center(
                            child: Text("Készítsük el a profilod",
                                style: MyTextStyles.cim(context)),
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Column(
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0,
                                        MediaQuery.of(context).size.width *
                                            0.03,
                                        0,
                                        0),
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
                                          color: AppColors.lightshade,
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 0.5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.005,
                                                  0,
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.005,
                                                  0),
                                          child: TextFormField(
                                            controller: _model.textController1,
                                            focusNode:
                                                _model.textFieldFocusNode1,
                                            autofocus: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.zero,
                                              labelText: 'Vezetéknév...',
                                              labelStyle: MyTextStyles
                                                  .kicsisbethesdabekezdes(
                                                      context),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              errorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedErrorBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            style: MyTextStyles.kicsibekezdes(
                                                context),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    // Add spacing between the containers
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.lightshade,
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 0.5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.005,
                                                  0,
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.005,
                                                  0),
                                          child: TextFormField(
                                            controller: _model.textController2,
                                            focusNode:
                                                _model.textFieldFocusNode2,
                                            autofocus: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.zero,
                                              labelText: 'Keresztnév...',
                                              labelStyle: MyTextStyles
                                                  .kicsisbethesdabekezdes(
                                                      context),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              errorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedErrorBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            style: MyTextStyles.kicsibekezdes(
                                                context),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                //EMAIL
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0,
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.03,
                                                  0,
                                                  0),
                                          child: Text(
                                            'E-mail cím:',
                                            textAlign: TextAlign.center,
                                            style:
                                                MyTextStyles.bekezdes(context),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.lightshade,
                                          // Background color of the container
                                          border: Border.all(
                                            color: Colors.grey, // Outline color
                                            width: 0.5, // Outline thickness
                                          ),
                                          // If you also want to have rounded corners, add the borderRadius property
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.005,
                                                  0,
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.005,
                                                  0),
                                          child: TextFormField(
                                            controller: _model.textController3,
                                            focusNode:
                                                _model.textFieldFocusNode1,
                                            autofocus: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.zero,
                                              // <-- Set contentPadding to zero
                                              labelText: '...',
                                              labelStyle: MyTextStyles
                                                  .kicsisbethesdabekezdes(
                                                      context),
                                              //hintStyle: FlutterFlowTheme.of(context).labelMedium,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              errorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedErrorBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            style: MyTextStyles.kicsibekezdes(
                                                context),
                                            //validator: _model.textController1Validator.asValidator(context),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                //DÖNTÉS
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0,
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.03,
                                                  0,
                                                  0),
                                          child: Text(
                                            'Szülőként vagy gyermekként regisztrálsz:',
                                            textAlign: TextAlign.center,
                                            style:
                                                MyTextStyles.bekezdes(context),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.lightshade,
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 0.5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.005,
                                                  0,
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.005,
                                                  0),
                                          child:
                                              DropdownButtonFormField<String>(
                                            value: _selectedOption,
                                            onChanged: (String? newValue) {
                                              // Change parameter type to String?
                                              setState(() {
                                                _selectedOption = newValue;
                                              });
                                            },
                                            items: <String?>['szülő', 'gyermek']
                                                .map<DropdownMenuItem<String>>(
                                                    (String? value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value ?? 'Kattints ide...',
                                                  // Handle null value
                                                  style: MyTextStyles
                                                      .kicsibekezdes(context),
                                                ),
                                              );
                                            }).toList(),
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.zero,
                                              labelText: 'Válassz...',
                                              labelStyle: MyTextStyles
                                                  .kicsisbethesdabekezdes(
                                                      context),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              errorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedErrorBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                //ROKON ADAT
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0,
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.03,
                                                  0,
                                                  0),
                                          child: Text(
                                            _selectedOption == 'szülő'
                                                ? 'Kutatásban résztvevő gyermekének a TAJ száma:'
                                                : 'A TAJ számod:',
                                            textAlign: TextAlign.center,
                                            style:
                                                MyTextStyles.bekezdes(context),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.lightshade,
                                                border: Border.all(
                                                  color: Colors.grey,
                                                  width: 0.5,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.005,
                                                        0,
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.005,
                                                        0),
                                                child: TextFormField(
                                                  controller:
                                                      _model.textController4,
                                                  focusNode: _model
                                                      .textFieldFocusNode1,
                                                  autofocus: true,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    labelText: 'Vezetéknév...',
                                                    labelStyle: MyTextStyles
                                                        .kicsisbethesdabekezdes(
                                                            context),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    errorBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.red,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedErrorBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.red,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                  style: MyTextStyles
                                                      .kicsibekezdes(context),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          // Add spacing between the containers
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.lightshade,
                                                border: Border.all(
                                                  color: Colors.grey,
                                                  width: 0.5,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.005,
                                                        0,
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.005,
                                                        0),
                                                child: TextFormField(
                                                  controller:
                                                  _model.textController5,
                                                  focusNode: _model
                                                      .textFieldFocusNode2,
                                                  autofocus: true,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    labelText: 'Keresztnév...',
                                                    labelStyle: MyTextStyles
                                                        .kicsisbethesdabekezdes(
                                                            context),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    errorBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.red,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedErrorBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.red,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                  style: MyTextStyles
                                                      .kicsibekezdes(context),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),


                                SizedBox(height: MediaQuery.of(context).size.width*0.02),
                                //GOMB
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      print("regisztracio most en");
                                      _showBigContainer = true;

                                      String? szov1 = _model.textController1?.text;
                                      String? szov2 = _model.textController2?.text;
                                      String? szov3 = _model.textController3?.text;
                                      String? szov4 = _model.textController4?.text;
                                      String? szov5 = _model.textController5?.text;
                                      //String? szov6 = _model.textController6?.text;
                                      print("regisztracio|$szov3-$szov1,$szov2,$_selectedOption,NULL,BARMI");


                                      _channel = WebSocketChannel.connect(
                                      //Uri.parse('ws://34.72.67.6:8089'),
                                      Uri.parse('ws://146.148.43.137:8089'),
                                      );
                                      //kerdes = "$_selectedLocaleId | $kerdes";
                                      _channel.sink.add("regisztracio|$szov3-$szov1,$szov2,$_selectedOption,NULL,BARMI");
                                      //_channel.sink.add("bejelentkezes|adam@ali.com");
                                      _channel.stream.listen(
                                      (message) {
                                        print('Received message: $message');
                                        if(message=="True"){
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) => AlertDialog(
                                              title: Text("Regisztrációs Hiba"),
                                              content: Text("A bevitt adatokkal már regisztráltak. Kérem lépjen be regisztráció helyett a létező fiókjába az email-ben kapott azonosító segítségével."),
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
                                              builder: (BuildContext context) =>
                                                  MyApp(),
                                            ),
                                          );
                                        }else{
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
                                              builder: (BuildContext context) =>
                                                  MyApp(),
                                            ),
                                          );
                                        }

                                      });

                                      print("regisztracio vege");
                                    });
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppColors.bethesdacolor),
                                    // Change the color to your desired color
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // Adjust the value as needed
                                      ),
                                    ),
                                    padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                      EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal:
                                              24), // Adjust the padding as needed
                                    ),
                                  ),
                                  child: Text(
                                    "Regisztrálok",
                                    textAlign: TextAlign.center,
                                    style: MyTextStyles.gomb(context),
                                  ),
                                ),




                                SizedBox(height: MediaQuery.of(context).size.width*0.02),

                              ],
                            ),
                          ),
                        ],
                      ),
                      //EDDIG
                      ),
                      ),

                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Container(
                            child: HtmlWidget(
                              '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="https://redcapdemo.vumc.org/surveys/?s=YN98PRHNDJAD8T3P" frameborder="0" ></iframe>',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              Row(
                children: [
                  Center(child: Text("Kitöltötted?", style: MyTextStyles.bekezdes(context),), ),

                ],
              ),

              // //

              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: AppColors.bethesdacolor,
                      // Use your desired background color
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      // Adjust padding as needed
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.05),
                                // Adjust the padding as necessary
                                child: Image.asset(
                                  "assets/images/bethesda_white_logo_name.png",
                                  // Replace with your logo asset path
                                  width: MediaQuery.of(context).size.width *
                                      0.05, // Adjust the size as necessary
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Magyarországi Református Egyház Bethesda Gyermekkórháza – 1146 Budapest, Bethesda utca 3. (Zugló)',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.012,
                                    color: AppColors.lightshade,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.05),
                                // Adjust the padding as necessary
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '+36 1 920 6000',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.0115,
                                        color: AppColors.lightshade,
                                      ),
                                    ),
                                    Text(
                                      'bethesda@bethesda.hu',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.0115,
                                        color: AppColors.lightshade,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
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
