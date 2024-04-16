import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:bethesda_2/constants/colors.dart'; // Adjust the import path as necessary
import 'package:url_launcher/url_launcher.dart';
import 'gdpr.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'main.dart';
export 'home_page_model.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  bool _isPressed = false; // State variable to track if the button is pressed


  Future<void> sendEmail(String name, String email, String message) async {
    String username = 'your-email@gmail.com';
    String password = 'your-email-password';
    final smtpServer = gmail(username, password);

    final mailMessage = Message()
      ..from = Address(username, 'Your Name or App Name')
      ..recipients.add('destination-email@example.com')
      ..subject = 'New Contact Message from $name'
      ..text = 'Név: $name\nE-mail: $email\nÜzenet: $message';

    try {
      final sendReport = await send(mailMessage, smtpServer);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Sikeres üzenetküldés!"),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Sikertelen üzenetküldés."),
        backgroundColor: Colors.red,
      ));
    }
  }

  Widget formField(String label, TextEditingController controller, {bool isMessage = false}) {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
            child: Text(
              label,
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 16, color: AppColors.darkshade),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.whitewhite, // Ensure this is consistent and set to the right color
            border: Border.all(
              color: Colors.grey,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.whitewhite, // Make sure this is the correct white
              contentPadding: EdgeInsets.symmetric(vertical: isMessage ? 20 : 15, horizontal: 20), // Adjust padding
              labelText: 'Kattintson ide...',
              labelStyle: TextStyle(fontFamily: 'Montserrat', fontSize: 15, color: AppColors.bethesdacolor),
              floatingLabelBehavior: FloatingLabelBehavior.auto, // Adjust as necessary
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.whitewhite, width: 1), // Ensure border color matches background
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.bethesdacolor, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            keyboardType: isMessage ? TextInputType.multiline : TextInputType.text,
            maxLines: isMessage ? null : 1, // Allows multiple lines if it's the message field
            minLines: isMessage ? 5 : 1, // Sets a minimum line count for the message field
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 15),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      // Adjust margins here to match other components if necessary
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Padding(
        // Also adjust internal padding to ensure content alignment
          padding: EdgeInsets.all(16),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.35,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ha kérdésed van, küldj nekünk üzenetet!', style: TextStyle(fontFamily: 'Montserrat', fontSize: 20, color: AppColors.bethesdacolor)),
              formField('Név:', nameController),
              formField('Email cím:', emailController),
              formField('Üzenet:', messageController, isMessage: true),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (emailController.text.isNotEmpty) {
                    sendEmail(nameController.text, emailController.text, messageController.text);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      return AppColors.bethesdacolor; // Default color
                    },
                  ),
                ),
                child: Text(
                  'Üzenet küldése',
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.whitewhite),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





class ResearcherCard extends StatelessWidget {
  const ResearcherCard({Key? key}) : super(key: key);

  final String _url = "https://scholar.semmelweis.hu/majorjanos/";

  void _launchURL() async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
  @override
  Widget build(BuildContext context) {
    // Calculate dynamic sizes based on screen width
    double screenWidth = MediaQuery.of(context).size.width;
    double paddingValue = screenWidth * 0.005;
    double avatarRadius = screenWidth * 0.05; // Adjust this value as needed for your design
    double spaceWidth = screenWidth * 0.02; // Space between avatar and text

    return Card(
      elevation: 1, // Elevation to give depth
      color: AppColors.whitewhite,
      margin: EdgeInsets.all(paddingValue), // Margin for spacing
      child: Padding(
        padding: EdgeInsets.all(paddingValue), // Inner spacing
        child: Row(
          mainAxisSize: MainAxisSize.min, // Use the minimum space that's necessary for the children
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/major_janos.png"), // Replace with your image path
              radius: avatarRadius, // Dynamically adjusted size
            ),
            SizedBox(width: spaceWidth),
            Flexible( // Makes the column flexible to prevent overflow
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Use the minimum space that's necessary for the children
                children: [
                  Flexible( // Allows text to wrap if it's too long for the screen
                    child: Text(
                      "Vezető kutató: \nDr Major János, PhD",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        color: AppColors.bethesdacolor,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: _launchURL,
                    child: Text(
                      _url,
                      style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );


}
}


class Regisztracio extends StatelessWidget {
  const Regisztracio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fájdalomkezelés regisztráció',
      theme: ThemeData(
        /*colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
        ),*/
        cardTheme: CardTheme(
          color: Colors.white, // This sets the background color of cards to white
        ),
        // Other theme configurations
      ),
      home: const HomePageWidgetRegisztracio(),
    );
  }
}

class HomePageWidgetRegisztracio extends StatefulWidget {
  const HomePageWidgetRegisztracio({Key? key}) : super(key: key);

  @override
  State<HomePageWidgetRegisztracio> createState() => _HomePageWidgetRegisztracioState();
}

class _HomePageWidgetRegisztracioState extends State<HomePageWidgetRegisztracio> {
  late HomePageModel _model;

  late double _currentPointOnFunction = 0; // Az aktuális függvényérték
  late double _sliderValue = 0.0; // A csúszka értéke
  late bool toggle = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

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
          title: Text(
            "Bethesda Gyermekkórház Fájdalomkezelő Centrum",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              // fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.bethesdacolor,
            ),
          ),
          actions: <Widget>[
            Center(
              child: Text(
                'Kutatási fázis',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                 // fontWeight: FontWeight.bold,
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
              SizedBox(height: MediaQuery.of(context).size.width * 0.02), // Space between rectangle and card

              Padding(
          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.04),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.04, // Width of the colored rectangle
              height: 100, // Height of the colored rectangle
              color: AppColors.lightaccentcolor, // Color of the rectangle
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.04), // Space between rectangle and card
            Expanded(
              child: Card(
                elevation: 1, // Shadow effect
                color: AppColors.lightaccentcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Rounded corners for the card
                ),
                child: Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.009),
                  child: Text(
                    "Funkcionális hasi fájdalomzavarok online hipnózis és mozgás-motivációs tréning kezelésének hatásvizsgálata tizenévesek körében",
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


              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Colored rectangle container
                  Container(
                    width: MediaQuery.of(context).size.width * 0.04, // Adjust the width to your preference
                    color: AppColors.lightaccentcolor, // The color of the rectangle
                    height: MediaQuery.of(context).size.height*2.7, // Make the container fill the height of the viewport
                  ),

                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            SizedBox(height: MediaQuery.of(context).size.width*0.04),
                              Text("A kutatás célja",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: AppColors.bethesdacolor,
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.width*0.01),
                              Text("A funkcionális hasi fájdalomzavarral élő serdülők részére kifejlesztett, különböző online és személyes terápiás módszerek összehasonlítása és azok hatékonyságának vizsgálata. \nEz a kutatás nagy előrelépést jelenthet a krónikus gyermekkori hasi fájdalom kezelésében, ami gyakran jelentős terhet jelent a betegek és családjaik számára. Az eredmények segíthetnek optimalizálni a kezelési protokollokat és módszereket, hogy hatékonyabb és kevésbé invazív megközelítést biztosítsanak a fájdalom csillapítására. Ezenkívül az online terápiás lehetőségek fejlesztése és hatékonyságának igazolása segíthet elérhetővé tenni az ilyen típusú kezeléseket az olyan területeken élő fiatalok számára is, ahol ezek a terápiás lehetőségek nehezen elérhetőek.",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.darkshade,
                                ),
                                textAlign: TextAlign.justify, // This ensures the text is justified within the padding
                              ),
                              SizedBox(height: MediaQuery.of(context).size.width*0.04),
                              Text("Miért érdemes részt venned a kutatásban?",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: AppColors.bethesdacolor,
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.width*0.01),
                              Text("A legjobb dolog, amit tehetsz, hogy minél jobban megismered a saját fájdalmadat és tanulsz róla. Ugyanis minél jobban ismered a fájdalmadat, annál több mindent tudsz tenni azért, hogy jobban legyél! Mi ebben tudunk segíteni Neked. Magyarországon elsőként próbálhatsz ki akár több olyan online és személyes terápiát is, amelyeket kifejezetten funkcionális hasi fájdalmakkal élő serdülőknek fejlesztettünk ki.",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.darkshade,
                                ),
                                textAlign: TextAlign.justify, // This ensures the text is justified within the padding
                              ),
                              SizedBox(height: MediaQuery.of(context).size.width*0.04),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.lightaccentcolor, // Replace with your desired background color
                                  borderRadius: BorderRadius.circular(20), // Adjust the radius to get your desired curve
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01), // Add padding around the texts within the container
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min, // Use the minimum space necessary to fit the children
                                    crossAxisAlignment: CrossAxisAlignment.start, // Align texts to the start (left side)
                                    children: [
                                      Text(
                                        "Ez mit foglal magában?",
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 20,
                                          color: AppColors.lightshade,
                                        ),
                                        textAlign: TextAlign.justify, // This ensures the text is justified within the padding
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                                      Table(
                                        children: [
                                          TableRow(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Milyen terápiákról van szó?",
                                                      style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                        color: AppColors.lightshade,
                                                      ),
                                                      textAlign: TextAlign.justify, // This ensures the text is justified within the padding
                                                    ),
                                                    Text(
                                                      "Online hipnózis terápia, mely a hasi régióra fókuszál\nOnline mozgás-motivációs tréning (M3 Tréning)\nPszichoedukáció a krónikus hasi fájdalmakról\nInterdiszciplináris, multimodális fájdalomterápia",
                                                      style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        fontSize: 16,
                                                        color: AppColors.lightshade,
                                                      ),
                                                      textAlign: TextAlign.justify, // This ensures the text is justified within the padding
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Hogy néz ki a folyamat?",
                                                      style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                        color: AppColors.lightshade,
                                                      ),
                                                      textAlign: TextAlign.justify, // This ensures the text is justified within the padding
                                                    ),
                                                    Text(
                                                      "1. szakasz: első terápiás lehetőség 12 hétig\n2. szakasz: második terápiás lehetőség újabb 12 hétig\n+ 1 terápiás lehetőség, ha még a panaszok fennállnak: interdiszciplináris, multimodális fájdalomterápia",
                                                      style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        fontSize: 16,
                                                        color: AppColors.lightshade,
                                                      ),
                                                      textAlign: TextAlign.justify, // This ensures the text is justified within the padding
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Meddig tart a kutatás?",
                                                      style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                        color: AppColors.lightshade,
                                                      ),
                                                      textAlign: TextAlign.justify, // This ensures the text is justified within the padding
                                                    ),
                                                    Text(
                                                      "A kutatás teljes hossza 6+3 hónap, mely 2+1 szakaszra bontható",
                                                      style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        fontSize: 16,
                                                        color: AppColors.lightshade,
                                                      ),
                                                      textAlign: TextAlign.justify, // This ensures the text is justified within the padding
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Hány alkalommal keresünk meg Téged a vizsgálat alatt?",
                                                      style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                        color: AppColors.lightshade,
                                                      ),
                                                      textAlign: TextAlign.justify, // This ensures the text is justified within the padding
                                                    ),
                                                    Text(
                                                      "Tippelek: 12-18 alkalom",
                                                      style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        fontSize: 16,
                                                        color: AppColors.lightshade,
                                                      ),
                                                      textAlign: TextAlign.justify, // This ensures the text is justified within the padding
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      // Add more Text widgets as needed
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: MediaQuery.of(context).size.width*0.02),

                              ResearcherCard(),


                              SizedBox(height: MediaQuery.of(context).size.width*0.02),
                              Text("A kutatás engedélyszáma:",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: AppColors.bethesdacolor,
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.width*0.005),
                              Text("VALAMI",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.darkshade,
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.width*0.02),
                              Text("A kutatás kezdete:",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: AppColors.bethesdacolor,
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.width*0.005),
                              Text("VALAMI",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.darkshade,
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.width*0.02),
                              Text("A bevonási időszak:",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: AppColors.bethesdacolor,
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.width*0.0),
                              Text("2024.04.01.-2026. 02. 28.",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.darkshade,
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.width*0.02),
                              ContactForm(),
                              SizedBox(height: MediaQuery.of(context).size.width*0.02),

                            ],
                          ),
                        ),
                        // You can continue adding more sections here...
                      ],
                    ),
                  ),


                  Expanded(
                    flex: 1,
                    child: Card(
                      elevation: 4, // Set the elevation for the Card
                      color: AppColors.whitewhite, // Background color for Card
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                        top: MediaQuery.of(context).size.height * 0.2,
                        bottom: MediaQuery.of(context).size.height * 0.02,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13), // Adjust the border radius of the Card
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Te is szívesen részt vennél ebben a kutatásban?",
                              textAlign: TextAlign.center, // Center align text horizontally
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 20,
                                color: AppColors.darkshade,
                              ),
                            ),
                            SizedBox(height: 16), // Adds space between the text and the button
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Gdpr()), // Replace `Gdpr` with the correct widget class name if different
                                );
                                },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(AppColors.lightaccentcolor), // Set the background color
                              ),
                              child: Text(
                                "Igen,\n részt veszek!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: AppColors.lightshade, // This sets the text color inside the button
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),




                ],
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
