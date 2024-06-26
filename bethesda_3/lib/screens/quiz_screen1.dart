import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider1.dart';
import '../models/questions1.dart';

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
  final TextEditingController _commentController = TextEditingController(); // Controller for comment input
  List<TextEditingController> _optionControllers = [];
  List<TextEditingController> _optionControllers2 = []; // Nehézségek
  List<TextEditingController> _optionControllers3 = []; // Előnyök
  List<String> _rankableOptions = [];
  List<String> hatosOptions = [];
  List<TextEditingController> _prosControllers = [];
  List<TextEditingController> _consControllers = [];
  bool _isReordering = false;
  double _sliderValue = 0.0;
  final ScrollController _scrollController = ScrollController();
  int _selectedAnswerIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _commentController.dispose(); // Dispose of the comment controller
    for (var controller in _optionControllers) {
      controller.dispose();
    }
    for (var controller in _prosControllers) {
      controller.dispose();
    }
    for (var controller in _consControllers) {
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
                                  width: MediaQuery.of(context).size.width * 0.55,
                                  margin: EdgeInsets.only(top: 20.0),
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey.shade600,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Text(
                                    currentQuestion.text,
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey.shade800,
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
                                        width: 2.0,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18.0),
                                      child: LinearProgressIndicator(
                                        value: progressValue,
                                        backgroundColor: AppColors.whitewhite,
                                        valueColor: AlwaysStoppedAnimation<Color>(
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
                          if (currentQuestion.hasInfoButton) ...[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context).size.width * 0.06),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Nincs ötleted? Szeretnéd, hogy segítsek?",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Tooltip(
                                    message: currentQuestion.infoButtonText,
                                    child: Icon(Icons.info_outline),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          SizedBox(height: 20.0),
                          if (currentQuestion.requiresRanking) ...[
                            Column(
                              children: [
                                if (_optionControllers.isNotEmpty)
                                  if (!_isReordering)
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: _optionControllers.length,
                                        itemBuilder: (context, index) {
                                          var controller = _optionControllers[index];
                                          return Padding(
                                            key: ValueKey(controller),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 4.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.4,
                                                  child: TextField(
                                                    controller: controller,
                                                    decoration: InputDecoration(
                                                      labelText: 'Az ötleted...',
                                                      labelStyle: TextStyle(
                                                          color: Colors.grey.shade600),
                                                      border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.green,
                                                            width: 2.0),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.yellow,
                                                            width: 2.0),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey.shade600,
                                                            width: 2.0),
                                                      ),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                    ),
                                                    style: TextStyle(color: Colors.grey.shade800),
                                                    maxLines: null,
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.delete),
                                                  onPressed: () {
                                                    setState(() {
                                                      _optionControllers.removeAt(index);
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: (currentQuestion.twoColumn)
                                            ? MediaQuery.of(context).size.width * 0.45
                                            : MediaQuery.of(context).size.width * 0.3,
                                        child: (currentQuestion.twoColumn)
                                            ? ListView(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          children: [
                                            for (int index = 0; index < _rankableOptions.length; index++)
                                              Padding(
                                                key: ValueKey(_rankableOptions[index]),
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 8.0, vertical: 4.0),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.2,
                                                      decoration: BoxDecoration(
                                                        color: AppColors.whitewhite,
                                                        border: Border.all(
                                                          color: Colors.grey.shade600,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius: BorderRadius.circular(8.0),
                                                      ),
                                                      child: ListTile(
                                                        title: Text(
                                                          _rankableOptions[index],
                                                          style: TextStyle(color: Colors.grey.shade800),
                                                        ),
                                                        tileColor: Colors.grey.shade100,
                                                      ),
                                                    ),
                                                    if (currentQuestion.twoColumn)
                                                      Container(
                                                        width: MediaQuery.of(context).size.width * 0.2,
                                                        decoration: BoxDecoration(
                                                          color: AppColors.whitewhite,
                                                          border: Border.all(
                                                            color: Colors.grey.shade600,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius: BorderRadius.circular(8.0),
                                                        ),
                                                        child: ListTile(
                                                          title: TextField(
                                                            style: TextStyle(color: Colors.grey.shade800),
                                                          ),
                                                          tileColor: Colors.grey.shade100,
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                          ],
                                        )
                                            : ReorderableListView(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          onReorder: (int oldIndex, int newIndex) {
                                            setState(() {
                                              if (newIndex > oldIndex) {
                                                newIndex -= 1;
                                              }
                                              final item = _rankableOptions.removeAt(oldIndex);
                                              _rankableOptions.insert(newIndex, item);
                                            });
                                          },
                                          children: [
                                            for (int index = 0; index < _rankableOptions.length; index++)
                                              Padding(
                                                key: ValueKey(_rankableOptions[index]),
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 8.0, vertical: 4.0),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.2,
                                                      decoration: BoxDecoration(
                                                        color: AppColors.whitewhite,
                                                        border: Border.all(
                                                          color: Colors.grey.shade600,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius: BorderRadius.circular(8.0),
                                                      ),
                                                      child: ListTile(
                                                        title: Text(
                                                          _rankableOptions[index],
                                                          style: TextStyle(color: Colors.grey.shade800),
                                                        ),
                                                        tileColor: Colors.grey.shade100,
                                                      ),
                                                    ),
                                                    if (currentQuestion.twoColumn)
                                                      Container(
                                                        width: MediaQuery.of(context).size.width * 0.2,
                                                        decoration: BoxDecoration(
                                                          color: AppColors.whitewhite,
                                                          border: Border.all(
                                                            color: Colors.grey.shade600,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius: BorderRadius.circular(8.0),
                                                        ),
                                                        child: ListTile(
                                                          title: TextField(
                                                            style: TextStyle(color: Colors.grey.shade800),
                                                          ),
                                                          tileColor: Colors.grey.shade100,
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                if (_optionControllers.isNotEmpty && _isReordering)
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.whitewhite, width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _isReordering = false;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: AppColors.whitewhite,
                                        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                                        textStyle: TextStyle(fontSize: 20.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0),
                                        ),
                                      ),
                                      child: Text(
                                        'Szerkesztés',
                                        style: TextStyle(color: Colors.grey.shade800),
                                      ),
                                    ),
                                  ),
                                SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                if (_optionControllers.isNotEmpty && _isReordering)
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.whitewhite, width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        quizProvider1.nextQuestion();
                                        _scrollToTop();
                                        if (quizProvider1.isQuizFinished) {
                                          Navigator.of(context).pushReplacementNamed(ResultScreen1.routeName);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: AppColors.yellow,
                                        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                                        textStyle: TextStyle(fontSize: 20.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0),
                                        ),
                                      ),
                                      child: Text(
                                        'Válasz mentése',
                                        style: TextStyle(color: AppColors.whitewhite),
                                      ),
                                    ),
                                  ),
                                if (_optionControllers.isEmpty || !_isReordering)
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade600, width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _optionControllers.add(TextEditingController());
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: AppColors.whitewhite,
                                        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                                        textStyle: TextStyle(fontSize: 20.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0),
                                        ),
                                      ),
                                      child: Text(
                                        'Új megadása',
                                        style: TextStyle(color: Colors.grey.shade800),
                                      ),
                                    ),
                                  ),
                                SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                if (_optionControllers.isNotEmpty && !_isReordering)
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.whitewhite, width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _rankableOptions = _optionControllers
                                              .map((controller) => controller.text)
                                              .where((text) => text.isNotEmpty)
                                              .toList();
                                          _isReordering = true;

                                          //TODO

                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.yellow,
                                        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                                        textStyle: TextStyle(fontSize: 20.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0),
                                        ),
                                      ),
                                      child: Text(
                                        'Eddigiek mentése, sorbarendezés megkezdése',
                                        style: TextStyle(color: Colors.grey.shade800),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ] else if (currentQuestion.requiresRadioOptions) ...[
                            Column(
                              children: [
                                ...currentQuestion.radioOptions.map((radioOption) {
                                  int index = currentQuestion.radioOptions.indexOf(radioOption);
                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor: Colors.grey,
                                        radioTheme: RadioThemeData(
                                          fillColor: MaterialStateColor.resolveWith((states) =>
                                          states.contains(MaterialState.selected) ? AppColors.yellow : Colors.grey),
                                        ),
                                      ),
                                      child: RadioListTile(
                                        title: Text(radioOption.text),
                                        value: index,
                                        groupValue: _selectedAnswerIndex,
                                        onChanged: (int? value) {
                                          setState(() {
                                            _selectedAnswerIndex = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                }).toList(),
                                SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                // Comment section
                                if (currentQuestion.allowsComment) ...[
                                  SizedBox(height: 20.0),
                                  Text(
                                    currentQuestion.commentText,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey.shade800,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 10.0),
                                  TextField(
                                    controller: _commentController,
                                    decoration: InputDecoration(
                                      labelText: 'Megjegyzés...',
                                      labelStyle: TextStyle(color: Colors.grey.shade600),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green, width: 2.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.yellow, width: 2.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey.shade600, width: 2.0),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    style: TextStyle(color: Colors.grey.shade800),
                                    maxLines: null,
                                  ),
                                ],
                                SizedBox(height: MediaQuery.of(context).size.width*0.05),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_selectedAnswerIndex != -1) {
                                      quizProvider1.answerQuestion(currentQuestion.radioOptions[_selectedAnswerIndex].nextQuestionIndex);
                                      _scrollToTop();
                                      if (quizProvider1.isQuizFinished) {
                                        Navigator.of(context).pushReplacementNamed(ResultScreen1.routeName);
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: AppColors.yellow,
                                    padding: EdgeInsets.symmetric(horizontal: 70.0, vertical: 12.0),
                                    textStyle: TextStyle(fontSize: 20.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  child: Text(
                                    'Tovább',
                                    style: TextStyle(color: AppColors.whitewhite),
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                              ],
                            ),

                            ///TO DO ADAM
                          ]else if (currentQuestion.twoColumn) ...[
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        currentQuestion.prosText,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade800,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        currentQuestion.consText,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade800,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),







                                //if (currentQuestion.requiresRanking) ...[
                                  Column(
                                    children: [
                                      //if (_optionControllers.isNotEmpty)
                                        //if (!_isReordering)


                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: _optionControllers2.length,
                                          itemBuilder: (context, index) {
                                            var controller = _optionControllers2[index];
                                            var controller2 = _optionControllers3[index];
                                            return Padding(
                                              key: ValueKey(controller),
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8.0, vertical: 4.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.2,
                                                    child: TextField(
                                                      controller: controller,
                                                      decoration: InputDecoration(
                                                        labelText: 'nehézség...',
                                                        labelStyle: TextStyle(
                                                            color: Colors.grey.shade600),
                                                        border: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.green,
                                                              width: 2.0),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.yellow,
                                                              width: 2.0),
                                                        ),
                                                        enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.grey.shade600,
                                                              width: 2.0),
                                                        ),
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                      ),
                                                      style: TextStyle(color: Colors.grey.shade800),
                                                      maxLines: null,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.2,
                                                    child: TextField(
                                                      controller: controller2,
                                                      decoration: InputDecoration(
                                                        labelText: 'előny...',
                                                        labelStyle: TextStyle(
                                                            color: Colors.grey.shade600),
                                                        border: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.green,
                                                              width: 2.0),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.yellow,
                                                              width: 2.0),
                                                        ),
                                                        enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.grey.shade600,
                                                              width: 2.0),
                                                        ),
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                      ),
                                                      style: TextStyle(color: Colors.grey.shade800),
                                                      maxLines: null,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),

                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey.shade600, width: 2.0),
                                            borderRadius: BorderRadius.circular(4.0),
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                _optionControllers2.add(TextEditingController());
                                                _optionControllers3.add(TextEditingController());
                                                // TODO
                                                //print("MEGNYOMTAD");
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: AppColors.whitewhite,
                                              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                                              textStyle: TextStyle(fontSize: 20.0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(4.0),
                                              ),
                                            ),
                                            child: Text(
                                              'Új megadása',
                                              style: TextStyle(color: Colors.grey.shade800),
                                            ),
                                          ),
                                        ),
                                      SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                      if (_optionControllers.isNotEmpty && !_isReordering)
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: AppColors.whitewhite, width: 2.0),
                                            borderRadius: BorderRadius.circular(4.0),
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                _rankableOptions = _optionControllers
                                                    .map((controller) => controller.text)
                                                    .where((text) => text.isNotEmpty)
                                                    .toList();
                                                _isReordering = true;

                                                //TODO
                                                //_optionControllers.clear();
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.yellow,
                                              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                                              textStyle: TextStyle(fontSize: 20.0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(4.0),
                                              ),
                                            ),
                                            child: Text(
                                              'Eddigiek mentése, sorbarendezés megkezdése',
                                              style: TextStyle(color: Colors.grey.shade800),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                //]

                                /*
                                if (currentQuestion.twoColumnEntries.any((entry) => entry.isFillable)) ...[
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade600, width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          currentQuestion.twoColumnEntries.add(TwoColumnEntry(pros: '', cons: '', isFillable: true));
                                          //hatosOptions.add("ADAM");

                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: AppColors.whitewhite,
                                        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                                        textStyle: TextStyle(fontSize: 20.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0),
                                        ),
                                      ),
                                      child: Text(
                                        'Új sor hozzáadása',
                                        style: TextStyle(color: Colors.grey.shade800),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.whitewhite, width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        quizProvider1.nextQuestion();
                                        _scrollToTop();
                                        if (quizProvider1.isQuizFinished) {
                                          Navigator.of(context).pushReplacementNamed(ResultScreen1.routeName);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: AppColors.yellow,
                                        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                                        textStyle: TextStyle(fontSize: 20.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0),
                                        ),
                                      ),
                                      child: Text(
                                        'Válasz mentése',
                                        style: TextStyle(color: AppColors.whitewhite),
                                      ),
                                    ),
                                  ),
                                ],

                                 */



                              ],
                            ),
                          ]


                          else ...currentQuestion.answers.map((answer) {
                              if (answer.isScale) {
                                return Column(
                                  children: [
                                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
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
                                      inactiveColor: AppColors.whitewhite,
                                      thumbColor: Colors.grey.shade600,
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: AppColors.whitewhite, width: 2.0),
                                        borderRadius: BorderRadius.circular(4.0),
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          quizProvider1.answerQuestion(answer.nextQuestionIndex);
                                          _scrollToTop();
                                          if (quizProvider1.isQuizFinished) {
                                            Navigator.of(context).pushReplacementNamed(ResultScreen1.routeName);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: AppColors.yellow,
                                          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                                          textStyle: TextStyle(fontSize: 20.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4.0),
                                          ),
                                        ),
                                        child: Text(
                                          'Tovább',
                                          style: TextStyle(color: AppColors.whitewhite),
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
                                        borderRadius: BorderRadius.circular(20.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          child: SizedBox(
                                            child: HtmlWidget(
                                              '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="${answer.video}"></video>',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.2,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: AppColors.whitewhite, width: 2.0),
                                        borderRadius: BorderRadius.circular(4.0),
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          quizProvider1.answerQuestion(answer.nextQuestionIndex);
                                          _scrollToTop();
                                          if (quizProvider1.isQuizFinished) {
                                            Navigator.of(context).pushReplacementNamed(ResultScreen1.routeName);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: AppColors.yellow,
                                          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                                          textStyle: TextStyle(fontSize: 20.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4.0),
                                          ),
                                        ),
                                        child: Text(
                                          'Megnéztem',
                                          style: TextStyle(color: AppColors.whitewhite),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                                  ],
                                );
                              }
                              return Container();
                            }).toList(),
                          if (currentQuestion.requiresTextInput) ...[
                            TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                labelText: 'A válaszod...',
                                labelStyle: TextStyle(color: Colors.grey.shade600),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.yellow, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.shade600, width: 2.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: TextStyle(color: Colors.grey.shade800),
                              maxLines: null,
                            ),
                            SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.whitewhite, width: 2.0),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_controller.text.isNotEmpty) {
                                    quizProvider1.nextQuestion();
                                    _scrollToTop();
                                    if (quizProvider1.isQuizFinished) {
                                      Navigator.of(context).pushReplacementNamed(ResultScreen1.routeName);
                                    }
                                    _controller.clear();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Kérlek írd be a válaszod!')),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: AppColors.yellow,
                                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                                  textStyle: TextStyle(fontSize: 20.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                ),
                                child: Text(
                                  'Tovább',
                                  style: TextStyle(color: AppColors.whitewhite),
                                ),
                              ),
                            ),
                          ],

                        ],
                      ),
                    ),
                    Container(
                      height: 800,
                      color: AppColors.lightshade,
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
                                height: MediaQuery.of(context).size.width * 0.03,
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
                                leading: Image.asset('assets/images/2icon_m.png'),
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
                                height: MediaQuery.of(context).size.width * 0.02,
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
                                height: MediaQuery.of(context).size.width * 0.02,
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
                                leading: Image.asset('assets/images/5icon_m.png'),
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
                                height: MediaQuery.of(context).size.width * 0.02,
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
                                height: MediaQuery.of(context).size.width * 0.02,
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
                                height: MediaQuery.of(context).size.width * 0.02,
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
                                height: MediaQuery.of(context).size.width * 0.02,
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
                                height: MediaQuery.of(context).size.width * 0.02,
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
