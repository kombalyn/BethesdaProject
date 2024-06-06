import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart'; // Import the package
import '../providers/quiz_provider1.dart';
import 'result_screen1.dart';
import 'package:bethesda_2/constants/colors.dart';
import 'package:bethesda_2/styles.dart';
import '../ModuleOpening_M3.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class QuizScreen1 extends StatefulWidget {
  static const routeName = '/quiz1';

  @override
  _QuizScreenState1 createState() => _QuizScreenState1();
}

class _QuizScreenState1 extends State<QuizScreen1> {
  final TextEditingController _controller = TextEditingController();
  final List<TextEditingController> _optionControllers = [];
  double _sliderValue = 0.0;
  List<String> _rankableOptions = [];

  @override
  void initState() {
    super.initState();
    // Initialize controllers if needed
  }

  @override
  void dispose() {
    _controller.dispose();
    for (var controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider1 = Provider.of<QuizProvider1>(context);
    final currentQuestion = quizProvider1.currentQuestion;
    double progressValue = (quizProvider1.currentQuestion.index + 1) / 32;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whitewhite,
        scrolledUnderElevation: 3.0,
        elevation: 3,
        shadowColor: Colors.grey,
        leading: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.03),
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
                    right: MediaQuery.of(context).size.width * 0.05),
                child: Text(
                  "Kutatási fázis",
                  style: MyTextStyles.cim(context),
                ),
              ),
            ],
          ),
        ),
        leadingWidth: MediaQuery.of(context).size.width,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      color: AppColors.lightshade,
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.33,
                        right: MediaQuery.of(context).size.width * 0.05,
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 25.0),
                          Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width*0.55,  // Fixed width for the container
                                  margin: EdgeInsets.only(top: 20.0),
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey.shade600, // Outline color
                                      width: 2.0, // Outline width
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.black26,
                                    //     blurRadius: 10.0,
                                    //     offset: Offset(0, 2),
                                    //   ),
                                    // ],
                                  ),
                                  child: Text(
                                    currentQuestion.text,
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey.shade800, // Change this to your desired color
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  left: 30,
                                  right: 30,
                                  child: Container(
                                    //margin: EdgeInsets.symmetric(horizontal: 16.0),
                                   //padding: EdgeInsets.symmetric(vertical: 10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all(
                                        color: Colors.grey.shade600, // Outline color
                                        width: 2.0, // Outline width
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18.0), // Adjust this to fit inside the outline
                                      child: LinearProgressIndicator(
                                        value: progressValue,
                                        backgroundColor: AppColors.whitewhite,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                                        minHeight: 20.0,
                                      ),
                                    ),
                                  ),
                                  ),

                              ],
                            ),
                          ),
                          SizedBox(height: 20.0),
                          if (currentQuestion.requiresRanking) ...[
                            Column(
                              children: [
                                ..._optionControllers.map((controller) {
                                  return TextField(
                                    controller: controller,
                                    decoration: InputDecoration(
                                      labelText: 'Enter an option',
                                      border: OutlineInputBorder(),
                                    ),
                                  );
                                }).toList(),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _optionControllers.add(TextEditingController());
                                    });
                                  },
                                  child: Text('Új írása'),
                                ),
                                if (_optionControllers.isNotEmpty)
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _rankableOptions = _optionControllers
                                            .map((controller) => controller.text)
                                            .where((text) => text.isNotEmpty)
                                            .toList();
                                        quizProvider1.updateRankableOptions(_rankableOptions);
                                      });
                                    },
                                    child: Text('Mentés, sorbarendezés megkezdése'),
                                  ),
                                if (_rankableOptions.isNotEmpty)
                                  Column(
                                    children: [
                                      for (int index = 0; index < _rankableOptions.length; index++)
                                        LongPressDraggable<String>(
                                          key: ValueKey(_rankableOptions[index]),
                                          data: _rankableOptions[index],
                                          child: DragTarget<String>(
                                            onWillAccept: (data) => data != _rankableOptions[index],
                                            onAccept: (receivedItem) {
                                              setState(() {
                                                final int oldIndex = _rankableOptions.indexOf(receivedItem);
                                                final int newIndex = index;

                                                // Remove the item from the old position
                                                final item = _rankableOptions.removeAt(oldIndex);

                                                // Insert the item into the new position
                                                _rankableOptions.insert(newIndex, item);
                                              });
                                            },
                                            builder: (context, acceptedItems, rejectedItems) {
                                              return ListTile(
                                                title: Text(_rankableOptions[index]),
                                                tileColor: Colors.grey[200],
                                              );
                                            },
                                          ),
                                          feedback: Material(
                                            child: ListTile(
                                              title: Text(
                                                _rankableOptions[index],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  decoration: TextDecoration.none,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              tileColor: Colors.blue,
                                            ),
                                          ),
                                          childWhenDragging: Container(),
                                        ),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Process rankable input
                                          quizProvider1.answerQuestion(
                                              currentQuestion.answers.first.nextQuestionIndex);
                                          if (quizProvider1.isQuizFinished) {
                                            Navigator.of(context).pushReplacementNamed(
                                                ResultScreen1.routeName);
                                          }
                                        },
                                        child: Text('Sorbarendezés mentése'),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                        ] else
                            ...currentQuestion.answers.map((answer) {
                              if (answer.isNumeric) {
                                return Column(
                                  children: [
                                    TextField(
                                      controller: _controller,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'A válaszod..',
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        int? numericAnswer =
                                            int.tryParse(_controller.text);
                                        if (numericAnswer != null) {
                                          quizProvider1.answerQuestion(
                                              answer.nextQuestionIndex);
                                          if (quizProvider1.isQuizFinished) {
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    ResultScreen1.routeName);
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    'Please enter a valid number')),
                                          );
                                        }
                                      },
                                      child: Text('Submit'),
                                    ),
                                    // Place the SizedBox here as a sibling
                                  ],
                                );
                              } else if (answer.isScale) {
                                return Column(
                                  children: [
                                    Slider(
                                      value: _sliderValue,
                                      min: 0.0,
                                      max: 10.0,
                                      divisions: 10,
                                      label: _sliderValue.round().toString(),
                                      onChanged: (double value) {
                                        setState(() {
                                          _sliderValue = value;
                                        });
                                      },
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        quizProvider1.answerQuestion(
                                            answer.nextQuestionIndex);
                                        if (quizProvider1.isQuizFinished) {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  ResultScreen1.routeName);
                                        }
                                      },
                                      child: Text('Submit'),
                                    ),
                                  ],
                                );
                              } else if (answer.isVideo) {
                                return Column(
                                  children: [
                                    Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.73,
                                          height: MediaQuery.of(context).size.width * 0.4,
                                          child: HtmlWidget(
                                            '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="${answer.video}"></video>',
                                          ),
                                        ),
                                      ),
                                    ),

                                    ElevatedButton(
                                      onPressed: () {
                                        quizProvider1.answerQuestion(
                                            answer.nextQuestionIndex);
                                        if (quizProvider1.isQuizFinished) {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  ResultScreen1.routeName);
                                        }
                                      },
                                      child: Text('Megnéztem'),
                                    ),
                                    // Place the SizedBox here as a sibling
                                  ],
                                );
                              }
                              return ElevatedButton(
                                onPressed: () {
                                  quizProvider1
                                      .answerQuestion(answer.nextQuestionIndex);
                                  if (quizProvider1.isQuizFinished) {
                                    Navigator.of(context).pushReplacementNamed(
                                        ResultScreen1.routeName);
                                  }
                                },
                                child: Text(
                                    answer.text.isEmpty ? 'Next' : answer.text),
                              );
                            }).toList(),
                          if (currentQuestion.requiresTextInput) ...[
                            TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                labelText: 'A válaszod...',
                                border: OutlineInputBorder(),
                              ),
                              maxLines: null,
                            ),
                            SizedBox(height: 20.0),
                            ElevatedButton(
                              onPressed: () {
                                if (_controller.text.isNotEmpty) {
                                  quizProvider1.nextQuestion();
                                  if (quizProvider1.isQuizFinished) {
                                    Navigator.of(context).pushReplacementNamed(
                                        ResultScreen1.routeName);
                                  }
                                  _controller.clear();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Kérlek írd be a válaszod!')),
                                  );
                                }
                              },
                              child: Text('Küldés'),
                            ),
                            // Place the SizedBox here as a sibling
                          ],
                        ],
                      ),
                    ),
                    Container(
                      height: 800,
                      color: AppColors.lightshade, // Set the color of the container here
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
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
                                    MediaQuery.of(context).size.width * 0.03,
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
                                  '1-2. hét terve',
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
                                    bottomRight: Radius.circular(20.0),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
