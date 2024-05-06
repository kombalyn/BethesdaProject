import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:bethesda_2/constants/colors.dart'; // Make sure this path is correct
import 'regisztracio.dart'; // Ensure this module is correctly implemented
import 'email_azonosito.dart';
import 'styles.dart'; // Make sure this path is correct based on where you placed the styles.dart file

// Assuming 'main.dart' and 'home_page_model.dart' are correctly set up.

/*class MyTextStyles {
  static TextStyle myCommonStyle(BuildContext context) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: MediaQuery.of(context).size.width * 0.0125,  // Adjust the multiplier as necessary
      color: AppColors.darkshade,
    );
  }
}
*/

class Gdpr extends StatelessWidget {
  const Gdpr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fájdalomkezelés regisztráció',
      theme: ThemeData(
        useMaterial3: false,

        cardTheme: CardTheme(
          color: Colors.white, // This sets the background color of cards to white
        ),
      ),
      home: const HomePageWidgetGdpr(),
    );
  }
}

class HomePageWidgetGdpr extends StatefulWidget {
  const HomePageWidgetGdpr({Key? key}) : super(key: key);

  @override
  _HomePageWidgetGdprState createState() => _HomePageWidgetGdprState();
}

class _HomePageWidgetGdprState extends State<HomePageWidgetGdpr> {
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
          scrolledUnderElevation: 3.0,
          elevation: 3,
          shadowColor: Colors.grey,  // Custom shadow color

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


      backgroundColor: AppColors.lightshade,
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
                            "Adatvédelmi nyilatkozat a Gyermekhipnózis Alapítvány részére",
                            textAlign: TextAlign.center,
                            style: MyTextStyles.fehercim(context),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: MyTextStyles.bekezdes(context), // Your common text style
                        children: <TextSpan>[
                          TextSpan(
                            text: "A személyes adatok feldolgozása a ",
                          ),
                          TextSpan(
                            text: "www.hypnosis4abdominalpain.com",
                            style: MyTextStyles.bekezdes(context).copyWith(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _launchURL('http://www.hypnosis4abdominalpain.com');
                              },
                          ),
                          TextSpan(
                            text: " weboldalon keresztül történik a Holland Gyermekhipnózis Alapítvány (DFHC) által. A DFHC nagy jelentőséget tulajdonít a személyes adatok gondos kezelésének. A személyes adatokat ezért gondosan kezeljük és biztosítjuk. A feldolgozás során betartjuk az adatvédelmi törvény követelményeit. Ez többek között azt jelenti, hogy:",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "•  Világosan jelezzük, hogy milyen célból dolgozunk fel személyes adatokat. Ezt a jelen adatvédelmi nyilatkozaton keresztül tesszük;",
                            style: MyTextStyles.bekezdes(context),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            "•  Igyekszünk a személyes adatok gyűjtését csak a törvényes célokhoz szükséges személyes adatokra korlátozni;",
                            style: MyTextStyles.bekezdes(context),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            "•  Először kifejezett engedélyt kérünk Öntől személyes adatai feldolgozásához, amennyiben az Ön engedélye szükséges;",
                            style: MyTextStyles.bekezdes(context),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            "• Megfelelő biztonsági intézkedéseket teszünk az Ön személyes adatainak védelme érdekében, és ugyanezt megköveteljük a személyes adatokat a nevünkben feldolgozó felektől is;",
                            style: MyTextStyles.bekezdes(context),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            "• Tiszteletben tartjuk az Ön azon jogát, hogy személyes adatait az Ön kérésére betekintés, helyesbítés vagy törlés céljából hozzáférhetővé tegyük.",
                            style: MyTextStyles.bekezdes(context),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                    Text("Mi vagyunk felelősek az adatfeldolgozásért. Ebben az adatvédelmi nyilatkozatban ismertetjük, hogy milyen személyes adatokat gyűjtünk és használunk fel, és milyen célból. Javasoljuk, hogy figyelmesen olvassa el ezt a nyilatkozatot.",
                        style: MyTextStyles.bekezdes(context),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                    Text("Az online hipnózisgyakorlatok megrendelésekor bizonyos információkat meg kell osztania velünk. Ezek a személyes adatok és az Ön fizetési módja a Mollie felületen keresztül. Csak azokat a személyes adatokat tároljuk és használjuk fel, amelyeket Ön közvetlenül megad, vagy amelyekről egyértelműen azonosíthatóak, hogy adatfeldolgozásra a rendelkezésünkre bocsájtja. A személyes adatokat más célra nem használjuk fel, kivéve, ha Ön előzetesen engedélyt adott rá, vagy ha erre törvényi felhatalmazásunk vagy kötelezettségünk van. A következő adatokat vesszük fel Öntől:",
                        style: MyTextStyles.bekezdes(context),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "• Annak a gyermeknek a kereszt- és vezetékneve, akinek a számára a kezelést megvásárolja;",
                            style: MyTextStyles.bekezdes(context),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            "• E-mail cím;",
                            style: MyTextStyles.bekezdes(context),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                    Text("A fenti adatokat a következő célokra használjuk fel:",
                    style: MyTextStyles.bekezdes(context),
                    textAlign: TextAlign.justify,),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "• Annak érdekében, hogy Ön igénybe vehesse szolgáltatásainkat;",
                            style: MyTextStyles.bekezdes(context),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            "• Az Ön által a weboldalon vagy az ott megadott e-mail címen keresztül feltett kérdések megválaszolása;",
                            style: MyTextStyles.bekezdes(context),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                    Text("A Holland Gyermekhipnózis Alapítvány nem tárolja az Ön adatait tovább, mint amennyi a jelen adatvédelmi nyilatkozatban meghatározott célok eléréséhez szükséges. Nem adjuk át az Ön által megadott adatokat más feleknek, ha Ön nem adott erre engedélyt, kivéve, ha ez törvényileg szükséges vagy megengedett. Csalás vagy szolgáltatásainkkal való visszaélés gyanúja esetén a személyes adatokat átadhatjuk az illetékes hatóságoknak. \nMegfelelő biztonsági intézkedéseket tettünk az Ön személyes adataival való visszaélés és az azokhoz való jogosulatlan hozzáférés korlátozása érdekében. \nEz a nyilatkozat nem vonatkozik a weboldalunkhoz kapcsolódó harmadik fél webhelyeire.\nNem tudjuk garantálni, hogy ezek a harmadik felek megbízható vagy biztonságos módon kezelik az Ön személyes adatait. Javasoljuk, hogy a webhelyek használata előtt olvassa el ezen webhelyek adatvédelmi nyilatkozatát.\nEz az adatvédelmi nyilatkozat legutóbb 20-05-2022.05.20-án módosult, és az 1.0 verziószámot viseli. Fenntartjuk a jogot a jelen nyilatkozat módosítására. A módosításokat ezen a weboldalon közzétesszük. Javasoljuk, hogy rendszeresen tekintse meg ezt a nyilatkozatot, hogy tisztában legyen ezekkel a változásokkal.",
                      style: MyTextStyles.bekezdes(context),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                    Text("Ha Ön személyes adatokat adott meg nekünk, akkor kérheti, hogy beletekintsen az adataiba, hogy módosítsuk vagy töröljük ezeket az adatokat. Ezt a kérelmet a info@hypnosis4abdominalpain.com címen keresztül küldheti el. \nTermészetesen szívesen segítünk Önnek, ha panasza van személyes adatainak feldolgozásával kapcsolatban. Az adatvédelmi törvény értelmében Önnek joga van panaszt tenni a holland adatvédelmi hatóságnál is.\nHa bármilyen kérdése van az adatvédelemmel, valamint az adatvédelmi és cookie-nyilatkozatunkkal kapcsolatban, a info@hypnosis4abdominalpain.com e-mail címen teheti fel azokat.",
                    style: MyTextStyles.bekezdes(context),
                    textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                    Theme(
                      data: Theme.of(context).copyWith(
                        checkboxTheme: CheckboxThemeData(
                          checkColor: MaterialStateProperty.all(Colors.white),
                          fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return AppColors.bethesdacolor; // Color of the tick background when selected
                            }
                            return Colors.grey; // Default color when not selected
                          }),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                          CheckboxListTile(
                            title: Text(
                              "Elolvastam és megértettem a kutatás feltételeit, s benne az én szerepemet.",
                              style: MyTextStyles.bekezdes(context)
                            ),
                            value: _termsRead,
                            onChanged: (bool? value) {
                              setState(() {
                                _termsRead = value!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          CheckboxListTile(
                            title: Text(
                              "Hozzájárulok, hogy a Bethesda Gyermekkórház az adataimat kutatási és oktatási célra tárolja és felhasználja.",
                              style: MyTextStyles.bekezdes(context)
                            ),
                            value: _consentGiven,
                            onChanged: (bool? value) {
                              setState(() {
                                _consentGiven = value!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          CheckboxListTile(
                            title: Text(
                              "Szülőm vagy gondviselőm is beleegyezik a kutatásba",
                              style: MyTextStyles.bekezdes(context),
                            ),
                            value: _guardianAgreed,
                            onChanged: (bool? value) {
                              setState(() {
                                _guardianAgreed = value!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Email()), // Replace `Gdpr` with the correct widget class name if different
                        );
                        print("Tovább button was pressed.");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.bethesdacolor, // Button color
                        foregroundColor: Colors.white, // Text and icon color
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Padding inside the button
                      ),
                      child: Text(
                        "Tovább",
                        style: MyTextStyles.gomb(context),
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.width * 0.03),

                  ],
                ),

              ),


      Container(
        color: AppColors.bethesdacolor, // Use your desired background color
        padding: const EdgeInsets.symmetric(vertical: 15), // Adjust padding as needed
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05), // Adjust the padding as necessary
                  child: Image.asset(
                    "assets/images/bethesda_white_logo_name.png", // Replace with your logo asset path
                    width: MediaQuery.of(context).size.width * 0.05, // Adjust the size as necessary
                  ),
                ),
                Expanded(
                  child: Text(
                    'Magyarországi Református Egyház Bethesda Gyermekkórháza – 1146 Budapest, Bethesda utca 3. (Zugló)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: MediaQuery.of(context).size.width * 0.012,
                      color: AppColors.lightshade,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05), // Adjust the padding as necessary
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '+36 1 920 6000',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: MediaQuery.of(context).size.width * 0.0115,
                          color: AppColors.lightshade,
                        ),
                      ),
                      Text(
                        'bethesda@bethesda.hu',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: MediaQuery.of(context).size.width * 0.0115,
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



      ],
          ),
        ),
      ),
    );
  }

}

