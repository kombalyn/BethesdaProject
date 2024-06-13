import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  List<TextEditingController> _optionControllers = [];
  List<String> _rankableOptions = [];
  bool _isReordering = false;
  double _sliderValue = 0.0;
  final ScrollController _scrollController = ScrollController();
  int _selectedAnswerIndex = -1;

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
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
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
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      color: AppColors.lightshade,
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.28,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.55,
                                  // Fixed width for the container
                                  margin: EdgeInsets.only(top: 20.0),
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey.shade600,
                                      // Outline color
                                      width: 2.0, // Outline width
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Text(
                                    currentQuestion.text,
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey
                                          .shade800, // Change this to your desired color
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  left: 30,
                                  right: 30,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all(
                                        color: Colors.grey.shade600,
                                        // Outline color
                                        width: 2.0, // Outline width
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18.0),
                                      child: LinearProgressIndicator(
                                        value: progressValue,
                                        backgroundColor: AppColors.whitewhite,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.yellow,
                                        ),
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
                                if (_optionControllers.isNotEmpty)
                                  if (!_isReordering)
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      // Set the width to be narrower
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: _optionControllers.length,
                                        itemBuilder: (context, index) {
                                          var controller =
                                              _optionControllers[index];
                                          return Padding(
                                            key: ValueKey(controller),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 4.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  // Make the cells narrower
                                                  child: TextField(
                                                    controller: controller,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Az ötleted...',
                                                      labelStyle: TextStyle(
                                                          color: Colors
                                                              .grey.shade600),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.green,
                                                            width: 2.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.yellow,
                                                            width: 2.0),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .grey.shade600,
                                                            width: 2.0),
                                                      ),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                    ),
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade800),
                                                    maxLines: null,
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.delete),
                                                  onPressed: () {
                                                    setState(() {
                                                      _optionControllers
                                                          .removeAt(index);
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                if (_isReordering)
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    // Set the width to be narrower
                                    child: ReorderableListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      onReorder: (int oldIndex, int newIndex) {
                                        setState(() {
                                          if (newIndex > oldIndex) {
                                            newIndex -= 1;
                                          }
                                          final item = _rankableOptions
                                              .removeAt(oldIndex);
                                          _rankableOptions.insert(
                                              newIndex, item);
                                        });
                                      },
                                      children: [
                                        for (int index = 0;
                                            index < _rankableOptions.length;
                                            index++)
                                          Padding(
                                            key: ValueKey(
                                                _rankableOptions[index]),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 4.0),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              // Make the cells narrower
                                              decoration: BoxDecoration(
                                                color: AppColors.whitewhite,
                                                // Background color for the container
                                                border: Border.all(
                                                    color: Colors.grey.shade600,
                                                    width: 1.0),
                                                // Border color and width
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        8.0), // Border radius
                                              ),
                                              child: ListTile(
                                                title: Text(
                                                  _rankableOptions[index],
                                                  style: TextStyle(
                                                      color: Colors.grey
                                                          .shade800), // Text color
                                                ),
                                                tileColor: Colors.grey
                                                    .shade100, // Background color for the tile
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.02),
                                if (_optionControllers.isNotEmpty &&
                                    _isReordering)
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade600,
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _isReordering =
                                              false; // Switch back to editing mode
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: AppColors.whitewhite,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24.0, vertical: 12.0),
                                        textStyle: TextStyle(fontSize: 20.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                      ),
                                      child: Text(
                                        'Szerkesztés',
                                        style: TextStyle(
                                            color: Colors.grey.shade800),
                                      ),
                                    ),
                                  ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.02),
                                if (_optionControllers.isNotEmpty &&
                                    _isReordering)
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade600,
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Save the reordered list here if needed
                                        quizProvider1
                                            .nextQuestion(); // Move to the next question
                                        _scrollToTop(); // Scroll to top when question changes
                                        if (quizProvider1.isQuizFinished) {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  ResultScreen1.routeName);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: AppColors.yellow,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24.0, vertical: 12.0),
                                        textStyle: TextStyle(fontSize: 20.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                      ),
                                      child: Text(
                                        'Sorbarendezés mentése',
                                        style: TextStyle(
                                            color: AppColors.whitewhite),
                                      ),
                                    ),
                                  ),
                                if (_optionControllers.isEmpty ||
                                    !_isReordering)
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade600,
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _optionControllers
                                              .add(TextEditingController());
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: AppColors.whitewhite,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24.0, vertical: 12.0),
                                        textStyle: TextStyle(fontSize: 20.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                      ),
                                      child: Text(
                                        'Új megadása',
                                        style: TextStyle(
                                            color: Colors.grey.shade800),
                                      ),
                                    ),
                                  ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.02),
                                if (_optionControllers.isNotEmpty &&
                                    !_isReordering)
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade600,
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _rankableOptions = _optionControllers
                                              .map((controller) =>
                                                  controller.text)
                                              .where((text) => text.isNotEmpty)
                                              .toList();
                                          _isReordering =
                                              true; // Toggle reordering state
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.yellow,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24.0, vertical: 12.0),
                                        textStyle: TextStyle(fontSize: 20.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                      ),
                                      child: Text(
                                        'Eddigiek mentése, sorbarendezés megkezdése',
                                        style: TextStyle(
                                            color: Colors.grey.shade800),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ] else
                            ...currentQuestion.answers.map((answer) {
                              if (answer.isScale) {
                                return Column(
                                  children: [
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.02),
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
                                      activeColor: Colors.yellow,
                                      // Color of the active portion of the slider
                                      inactiveColor: AppColors.whitewhite,
                                      // Color of the inactive portion of the slider
                                      thumbColor: Colors.grey.shade600,
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.whitewhite,
                                          // Outline color
                                          width: 2.0, // Outline width
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            4.0), // Border radius to match the button
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          quizProvider1.answerQuestion(
                                              answer.nextQuestionIndex);
                                          _scrollToTop(); // Scroll to top when question changes
                                          if (quizProvider1.isQuizFinished) {
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    ResultScreen1.routeName);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: AppColors.yellow,
                                          // Background color
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 24.0, vertical: 12.0),
                                          // Button padding
                                          textStyle: TextStyle(fontSize: 20.0),
                                          // Text size
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                4.0), // Border radius to match the container
                                          ),
                                        ),
                                        child: Text(
                                          'Tovább',
                                          style: TextStyle(
                                              color: AppColors
                                                  .whitewhite), // Text color
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else if (answer.isVideo) {
                                return Column(
                                  children: [
                                    Center(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        // Adjust the radius as needed
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                20.0), // Same border radius as ClipRRect
                                          ),
                                          child: SizedBox(
                                            child: HtmlWidget(
                                              '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="${answer.video}"></video>',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.whitewhite,
                                          // Outline color
                                          width: 2.0, // Outline width
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            4.0), // Border radius to match the button
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          quizProvider1.answerQuestion(
                                              answer.nextQuestionIndex);
                                          _scrollToTop(); // Scroll to top when question changes
                                          if (quizProvider1.isQuizFinished) {
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    ResultScreen1.routeName);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: AppColors.yellow,
                                          // Background color
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 24.0, vertical: 12.0),
                                          // Button padding
                                          textStyle: TextStyle(fontSize: 20.0),
                                          // Text size
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                4.0), // Border radius to match the container
                                          ),
                                        ),
                                        child: Text(
                                          'Megnéztem',
                                          style: TextStyle(
                                              color: AppColors
                                                  .whitewhite), // Text color
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return Column(
                                children: [
                                  Column(
                                    children: quizProvider1
                                        .currentQuestion.answers
                                        .map((answer) {
                                      int index = quizProvider1
                                          .currentQuestion.answers
                                          .indexOf(answer);
                                      return RadioListTile(
                                        title: Text(answer.text),
                                        value: index,
                                        groupValue: _selectedAnswerIndex,
                                        onChanged: (int? value) {
                                          setState(() {
                                            _selectedAnswerIndex = value!;
                                          });
                                        },
                                      );
                                    }).toList(),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_selectedAnswerIndex != -1) {
                                        quizProvider1.answerQuestion(
                                            quizProvider1
                                                .currentQuestion
                                                .answers[_selectedAnswerIndex]
                                                .nextQuestionIndex);
                                        _scrollToTop(); // Scroll to top when question changes
                                        if (quizProvider1.isQuizFinished) {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  ResultScreen1.routeName);
                                        }
                                      }
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return Colors
                                                .yellow; // Background color when clicked
                                          } else if (states.contains(
                                              MaterialState.hovered)) {
                                            return Colors
                                                .yellow; // Background color when hovered
                                          } else {
                                            return Colors
                                                .white; // Default background color
                                          }
                                        },
                                      ),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Colors.grey.shade800,
                                      ),
                                      overlayColor:
                                          MaterialStateProperty.all<Color>(
                                        Colors.yellow.withOpacity(
                                            0.3), // Splash color on hover/click
                                      ),
                                    ),
                                    child: Text('Tovább'),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                ],
                              );
                            }).toList(),
                          if (currentQuestion.requiresTextInput) ...[
                            TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                labelText: 'A válaszod...',
                                labelStyle:
                                    TextStyle(color: Colors.grey.shade600),
                                // Label text color
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green, // Border color
                                    width: 2.0, // Border width
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.yellow,
                                    // Border color when focused
                                    width: 2.0, // Border width when focused
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade600,
                                    // Border color when enabled
                                    width: 2.0, // Border width when enabled
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white, // Background color
                              ),
                              style: TextStyle(color: Colors.grey.shade800),
                              // Text color
                              maxLines: null,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.02),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.whitewhite, // Outline color
                                  width: 2.0, // Outline width
                                ),
                                borderRadius: BorderRadius.circular(
                                    4.0), // Border radius to match the button
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_controller.text.isNotEmpty) {
                                    quizProvider1.nextQuestion();
                                    _scrollToTop(); // Scroll to top when question changes
                                    if (quizProvider1.isQuizFinished) {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              ResultScreen1.routeName);
                                    }
                                    _controller.clear();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Kérlek írd be a válaszod!')),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: AppColors.yellow,
                                  // Background color
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24.0, vertical: 12.0),
                                  // Button padding
                                  textStyle: TextStyle(fontSize: 20.0),
                                  // Text size
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        4.0), // Border radius to match the container
                                  ),
                                ),
                                child: Text(
                                  'Tovább',
                                  style: TextStyle(
                                      color:
                                          AppColors.whitewhite), // Text color
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Container(
                      height: 800,
                      color: AppColors
                          .lightshade, // Set the color of the container here
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
                Positioned(
                  top: MediaQuery.of(context).size.width *
                      0.029, // Adjust to match the text's top padding
                  left: 0, // Adjust to position next to the text
                  child: Container(
                    width: MediaQuery.of(context).size.width *
                        0.03, // Adjust the width as needed
                    height: MediaQuery.of(context).size.height *
                        0.05, // Adjust the height as needed
                    color: AppColors.yellow, // Adjust the color as needed
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