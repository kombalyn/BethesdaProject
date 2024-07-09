import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider1.dart';
import '../models/questions1.dart';
import 'package:bethesda_2/constants/colors.dart';
import 'package:bethesda_2/styles.dart';
import '../ModuleOpening_M3.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../meno_gomb.dart';

class QuizScreen1 extends StatefulWidget {
  static const routeName = '/quiz1';

  @override
  _QuizScreenState1 createState() => _QuizScreenState1();
}

class _QuizScreenState1 extends State<QuizScreen1> {
  List<String> _rankableOptions_ = ["1","2","3","4"];
  var icon_most = {1:Icons.videocam,2:Icons.camera, 3:Icons.inbox, 4: Icons.star};
  var felirat_most = {1:"Kora reggel",2:"Délelőtt", 3:"Kora Délután", 4:"Délután-este"};
  List<int> _Types = [1,2,3,4];
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  List<TextEditingController> _optionControllers = [];
  List<TextEditingController> _optionControllers2 = [];
  List<TextEditingController> _optionControllers3 = [];
  List<String> _rankableOptions = [];
  List<TextEditingController> _prosControllers = [];
  List<TextEditingController> _consControllers = [];
  bool _isReordering = false;
  double _sliderValue = 0.0;
  final ScrollController _scrollController = ScrollController();
  int _selectedAnswerIndex = -1;
  bool is_hat_ketto = true;
  bool _isSecondColumnVisible = false;

  List<String> _secondColumnTexts = [];

  WebSocketChannel? _channel;

  @override
  void initState() {
    super.initState();
    _channel = WebSocketChannel.connect(
      // Uri.parse('ws://34.72.67.6:8089'),
      Uri.parse('ws://146.148.43.137:8089'),
    );

    _channel?.stream.listen((message) {
      print('Received message: $message');
    });
  }

  void _sendAnswer(int questionIndex, String answer) {
    String message = 'save|Azonosito;M3;1-2;$questionIndex,$answer';
    _channel?.sink.add(message);
  }

  @override
  void dispose() {
    _controller.dispose();
    _commentController.dispose();
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
    _channel?.sink.close();
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
        backgroundColor: AppColors.lightshade,
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
                          builder: (BuildContext context) => ModuleOpening_M3('Azonosito'),
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
                        left: MediaQuery.of(context).size.width * 0.27,
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
                                  margin: EdgeInsets.only(top: 20.0),
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey.shade600,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Text(
                                    currentQuestion.text,
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey.shade600,
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
                                        width: 1.5,
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
                          if (currentQuestion.hasInfoButton) ...[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                  MediaQuery.of(context).size.width * 0.06),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Nincs ötleted? Szeretnéd, hogy segítsek?",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Tooltip(
                                    message: currentQuestion.infoButtonText,
                                    child: Icon(
                                      Icons.info_outline,
                                      color: Colors.grey, // Custom color (blue)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.03),

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
                                            padding:
                                            const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.4,
                                                  child: TextField(
                                                    controller: controller,
                                                    decoration: InputDecoration(
                                                      labelText: 'Az ötleted...',
                                                      labelStyle: TextStyle(color: Colors.grey.shade600),
                                                      border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.green, width: 2.0),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.yellow, width: 2.0),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey.shade600, width: 2.0),
                                                      ),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                    ),
                                                    style: TextStyle(color: Colors.grey.shade600),
                                                    maxLines: null,
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.delete, color: Colors.grey),
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
                                            ? Row(
                                          children: [
                                            Expanded(
                                              child: ListView(
                                                shrinkWrap: true,
                                                physics: NeverScrollableScrollPhysics(),
                                                children: [
                                                  for (int index = 0;
                                                  index < _rankableOptions.length;
                                                  index++)
                                                    Padding(
                                                      key: ValueKey(_rankableOptions[index]),
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 8.0, vertical: 4.0),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                                0.2,
                                                            decoration: BoxDecoration(
                                                              color: AppColors.whitewhite,
                                                              border: Border.all(
                                                                color: Colors.grey.shade600,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius.circular(8.0),
                                                            ),
                                                            child: ListTile(
                                                              title: Text(
                                                                _rankableOptions[index],
                                                                style: TextStyle(
                                                                    color: Colors.grey.shade600),
                                                              ),
                                                              tileColor: Colors.grey.shade100,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width: MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                                  0.02),
                                                          if (currentQuestion.twoColumn)
                                                            Container(
                                                              width: MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                                  0.2,
                                                              decoration: BoxDecoration(
                                                                color: AppColors.whitewhite,
                                                                border: Border.all(
                                                                  color: Colors.grey.shade600,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                BorderRadius.circular(8.0),
                                                              ),
                                                              child: ListTile(
                                                                title: TextField(
                                                                  style: TextStyle(
                                                                      color: Colors.grey.shade600),
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
                                        )
                                            : ReorderableListView(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          onReorder: (int oldIndex, int newIndex) {
                                            setState(() {
                                              if (newIndex > oldIndex) {
                                                newIndex -= 1;
                                              }
                                              final item =
                                              _rankableOptions.removeAt(oldIndex);
                                              _rankableOptions.insert(newIndex, item);
                                            });
                                          },
                                          children: [
                                            for (int index = 0;
                                            index < _rankableOptions.length;
                                            index++)
                                              Padding(
                                                key: ValueKey(_rankableOptions[index]),
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 8.0, vertical: 4.0),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.2,
                                                      decoration: BoxDecoration(
                                                        color: AppColors.whitewhite,
                                                        border: Border.all(
                                                          color: Colors.grey.shade600,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                        BorderRadius.circular(8.0),
                                                      ),
                                                      child: ListTile(
                                                        title: Text(
                                                          _rankableOptions[index],
                                                          style: TextStyle(
                                                              color: Colors.grey.shade600),
                                                        ),
                                                        tileColor: Colors.grey.shade100,
                                                      ),
                                                    ),
                                                    if (currentQuestion.twoColumn)
                                                      Container(
                                                        width: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.2,
                                                        decoration: BoxDecoration(
                                                          color: AppColors.whitewhite,
                                                          border: Border.all(
                                                            color: Colors.grey.shade600,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius.circular(8.0),
                                                        ),
                                                        child: ListTile(
                                                          title: TextField(
                                                            style: TextStyle(
                                                                color: Colors.grey.shade600),
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
                                  GradientButton(
                                    text: 'SZERKESZTÉS',
                                    gradient: LinearGradient(
                                      colors: [AppColors.whitewhite, Colors.yellow],
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isReordering = false;
                                      });
                                    },
                                    showIcon: false,
                                  ),
                                SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                if (_optionControllers.isNotEmpty && _isReordering)
                                  GradientButton(
                                    text: 'VÁLASZ MENTÉSE',
                                    gradient: LinearGradient(colors: [Colors.yellow, AppColors.yellow]),
                                    onPressed: () {
                                      _sendAnswer(quizProvider1.currentQuestion.index, _rankableOptions.join(', '));
                                      quizProvider1.nextQuestion();
                                      _scrollToTop();
                                      if (quizProvider1.isQuizFinished) {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(builder: (context) => ModuleOpening_M3('Azonosito')));
                                      }
                                    },
                                    showIcon: true,
                                  ),
                                SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                if (_optionControllers.isEmpty || !_isReordering)
                                  GradientButton(
                                    text: 'ÚJ MEGADÁSA',
                                    gradient: LinearGradient(
                                      colors: [AppColors.whitewhite, Colors.yellow],
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _optionControllers.add(TextEditingController());
                                      });
                                    },
                                    showIcon: false,
                                  ),
                                SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                if (_optionControllers.isNotEmpty && !_isReordering)
                                  GradientButton(
                                    text: 'EDDIGIEK MENTÉSE, SORBARENDEZÉS MEGKEZDÉSE',
                                    gradient: LinearGradient(colors: [Colors.yellow, Colors.yellow]),
                                    onPressed: () {
                                      setState(() {
                                        List<String> answers = _optionControllers
                                            .map((controller) => controller.text)
                                            .where((text) => text.isNotEmpty)
                                            .toList();

                                        // Validate at least 5 different answers
                                        if (answers.length >= 5 &&
                                            answers.toSet().length == answers.length) {
                                          _rankableOptions = answers;
                                          _isReordering = true;
                                        } else {
                                          // Show an alert or a message to the user
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            content: Text('Kérlek, adj meg legalább 5 különböző választ.'),
                                          ));
                                        }
                                      });
                                    },
                                    showIcon: false,
                                  ),
                              ],
                            ),
                          ] else if (currentQuestion.requiresRadioOptions) ...[
                            Column(
                              children: [
                                ...currentQuestion.radioOptions
                                    .map((radioOption) {
                                  int index = currentQuestion.radioOptions
                                      .indexOf(radioOption);
                                  bool isSelected =
                                      _selectedAnswerIndex == index;
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24.0, vertical: 8.0),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor: Colors.grey,
                                        radioTheme: RadioThemeData(
                                          fillColor:
                                          MaterialStateColor.resolveWith(
                                                  (states) => states.contains(
                                                  MaterialState
                                                      .selected)
                                                  ? AppColors.yellow
                                                  : Colors.grey),
                                        ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 4.0,
                                              spreadRadius: 1.0,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                          border: Border.all(
                                            color: isSelected
                                                ? Colors.yellow
                                                : Colors.grey,
                                            width: 1.5,
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
                                    ),
                                  );
                                }).toList(),
                                if (currentQuestion.allowsComment) ...[
                                  SizedBox(height: 20.0),
                                  Text(
                                    currentQuestion.commentText,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey.shade600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 10.0),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24.0, vertical: 8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: TextField(
                                        controller: _commentController,
                                        decoration: InputDecoration(
                                          labelText: 'Megjegyzés...',
                                          labelStyle:
                                          TextStyle(color: Colors.grey),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade600,
                                                width: 1.5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                            borderSide: BorderSide(
                                                color: Colors.yellow,
                                                width: 1.5),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 1.5),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                        maxLines: null,
                                      ),
                                    ),
                                  ),
                                ],
                                SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.02),
                                GradientButton(
                                  text: 'TOVÁBB',
                                  gradient: LinearGradient(
                                    colors: [Colors.yellow, AppColors.yellow],
                                  ),
                                  onPressed: () {
                                    if (_selectedAnswerIndex != -1) {
                                      _sendAnswer(currentQuestion.index, currentQuestion.radioOptions[_selectedAnswerIndex].text);
                                      quizProvider1.answerQuestion(
                                          currentQuestion
                                              .radioOptions[
                                          _selectedAnswerIndex]
                                              .nextQuestionIndex);
                                      _scrollToTop();
                                      if (quizProvider1.isQuizFinished) {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ModuleOpening_M3('Azonosito')));
                                      }
                                    }
                                  },
                                  showIcon: true,
                                ),
                              ],
                            ),
                          ] else if (currentQuestion.twoColumn) ...[

                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.05),
                                          child: Text(
                                            currentQuestion.prosText,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade600,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.05),
                                          child: Text(
                                            currentQuestion.consText,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade600,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.02),
                                Column(
                                  children: [
                                    is_hat_ketto
                                        ? Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.5,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                        NeverScrollableScrollPhysics(),
                                        itemCount:
                                        _optionControllers2.length,
                                        itemBuilder: (context, index) {
                                          var controller =
                                          _optionControllers2[index];
                                          var controller2 =
                                          _optionControllers3[index];
                                          return Padding(
                                            key: ValueKey(controller),
                                            padding: const EdgeInsets
                                                .symmetric(
                                                horizontal: 8.0,
                                                vertical: 4.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .width *
                                                            0.01),
                                                    child: TextField(
                                                      controller:
                                                      controller,
                                                      decoration:
                                                      InputDecoration(
                                                        labelText:
                                                        'nehézség...',
                                                        labelStyle: TextStyle(
                                                            color: Colors
                                                                .grey
                                                                .shade600),
                                                        border:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              8.0),
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .grey
                                                                  .shade600,
                                                              width: 1.5),
                                                        ),
                                                        focusedBorder:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              8.0),
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .yellow,
                                                              width: 1.5),
                                                        ),
                                                        enabledBorder:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              8.0),
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .grey,
                                                              width: 1.5),
                                                        ),
                                                        filled: true,
                                                        fillColor:
                                                        Colors.white,
                                                      ),
                                                      style: TextStyle(
                                                          color: Colors
                                                              .grey
                                                              .shade800),
                                                      maxLines: null,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .width *
                                                        0.1),
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .width *
                                                            0.01),
                                                    child: TextField(
                                                      controller:
                                                      controller2,
                                                      decoration:
                                                      InputDecoration(
                                                        labelText:
                                                        'előny...',
                                                        labelStyle: TextStyle(
                                                            color: Colors
                                                                .grey
                                                                .shade600),
                                                        border:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              8.0),
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .grey
                                                                  .shade600,
                                                              width: 1.5),
                                                        ),
                                                        focusedBorder:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              8.0),
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .yellow,
                                                              width: 1.5),
                                                        ),
                                                        enabledBorder:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              8.0),
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .grey,
                                                              width: 1.5),
                                                        ),
                                                        filled: true,
                                                        fillColor:
                                                        Colors.white,
                                                      ),
                                                      style: TextStyle(
                                                          color: Colors
                                                              .grey
                                                              .shade800),
                                                      maxLines: null,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                        : Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.5,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                        NeverScrollableScrollPhysics(),
                                        itemCount:
                                        _optionControllers2.length,
                                        itemBuilder: (context, index) {
                                          var text2 =
                                              _optionControllers2[index]
                                                  .text;
                                          var text3 =
                                              _optionControllers3[index]
                                                  .text;
                                          return Padding(
                                            key: ValueKey(text2),
                                            padding: const EdgeInsets
                                                .symmetric(
                                                horizontal: 8.0,
                                                vertical: 4.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .width *
                                                            0.01),
                                                    child: Container(
                                                      decoration:
                                                      BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey
                                                                .shade600,
                                                            width: 2.0),
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            8.0),
                                                        color:
                                                        Colors.white,
                                                      ),
                                                      padding:
                                                      const EdgeInsets
                                                          .all(8.0),
                                                      child: Text(
                                                        text2,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey
                                                                .shade800),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .width *
                                                        0.1),
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .width *
                                                            0.01),
                                                    child: Container(
                                                      decoration:
                                                      BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey
                                                                .shade600,
                                                            width: 2.0),
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            8.0),
                                                        color:
                                                        Colors.white,
                                                      ),
                                                      padding:
                                                      const EdgeInsets
                                                          .all(8.0),
                                                      child: Text(
                                                        text3,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey
                                                                .shade800),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    ...currentQuestion.answers.map((answer) {
                                      if (answer.isFillable) {
                                        return Column(
                                          children: [
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.02),
                                            GradientButton(
                                              text: 'ÚJ MEGADÁSA',
                                              gradient: LinearGradient(
                                                colors: [
                                                  AppColors.whitewhite,
                                                  Colors.yellow
                                                ],
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _optionControllers2.add(
                                                      TextEditingController());
                                                  _optionControllers3.add(
                                                      TextEditingController());
                                                });
                                              },
                                              showIcon: false,
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.02),
                                          ],
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }).toList(),
                                    if (is_hat_ketto)
                                      GradientButton(
                                        text: 'TOVÁBB',
                                        gradient: LinearGradient(
                                          colors: [Colors.yellow, AppColors.yellow],
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            is_hat_ketto = false;
                                          });
                                          List<String> combinedAnswers = [];
                                          for (int i = 0; i < _optionControllers2.length; i++) {
                                            // Combining two columns into a single answer per row
                                            String answerRow = _optionControllers2[i].text + ':' + _optionControllers3[i].text;
                                            combinedAnswers.add(answerRow);
                                          }
                                          // Format: 1-answers;2-answers
                                          String finalAnswer = combinedAnswers.join(',');
                                          _sendAnswer(currentQuestion.index, finalAnswer);
                                          quizProvider1.nextQuestion();
                                          _scrollToTop();
                                          if (quizProvider1.isQuizFinished) {
                                            Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(builder: (context) => ModuleOpening_M3('Azonosito'))
                                            );
                                          }
                                          _controller.clear();
                                        },
                                        showIcon: true,
                                      ),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.02),
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
                                    SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        trackHeight: 12.0,
                                        activeTrackColor: Colors.yellow,
                                        inactiveTrackColor:
                                        AppColors.whitewhite,
                                        thumbColor: Colors.grey.shade600,
                                        overlayColor: Colors.grey.shade600
                                            .withOpacity(0.2),
                                        valueIndicatorColor:
                                        Colors.grey.shade600,
                                        thumbShape: RoundSliderThumbShape(
                                            enabledThumbRadius: 12.0),
                                        overlayShape: RoundSliderOverlayShape(
                                            overlayRadius: 15.0),
                                      ),
                                      child: Slider(
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
                                    ),
                                    SizedBox(
                                        height:
                                        MediaQuery.of(context).size.width *
                                            0.02),
                                    GradientButton(
                                      text: 'TOVÁBB',
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.yellow,
                                          AppColors.yellow
                                        ],
                                      ),
                                      onPressed: () {
                                        _sendAnswer(currentQuestion.index, _sliderValue.toString());
                                        quizProvider1.answerQuestion(
                                            answer.nextQuestionIndex);
                                        _scrollToTop();
                                        if (quizProvider1.isQuizFinished) {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ModuleOpening_M3('Azonosito')));
                                        }
                                      },
                                      showIcon: true,
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
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(20.0),
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
                                    GradientButton(
                                      text: 'MEGNÉZTEM',
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.yellow,
                                          AppColors.yellow
                                        ],
                                      ),
                                      onPressed: () {
                                        _sendAnswer(currentQuestion.index, "Watched Video");
                                        quizProvider1.answerQuestion(
                                            answer.nextQuestionIndex);
                                        _scrollToTop();
                                        if (quizProvider1.isQuizFinished) {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ModuleOpening_M3('Azonosito')));
                                        }
                                      },
                                      showIcon: true,
                                    ),
                                  ],
                                );
                              }
                              return Container();
                            }).toList(),
                          if (currentQuestion.requiresTextInput) ...[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: TextField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    labelText: 'A válaszod...',
                                    labelStyle:
                                    TextStyle(color: Colors.grey.shade600),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade600,
                                          width: 1.5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                          color: Colors.yellow, width: 1.5),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1.5),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  style: TextStyle(color: Colors.grey.shade600),
                                  maxLines: null,
                                ),
                              ),
                            ),


                            // ADAM tette be es kesobb kiveheto
                            if(currentQuestion.index==24)
                              Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                height: MediaQuery.of(context).size.width * 0.55,
                                //width: MediaQuery.of(context).size.width * 0.2,
                                // Make the cells narrower
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  // Background color for the container
                                  border: Border.all(
                                      color: Colors.grey.shade600,
                                      width: 1.0),
                                  // Border color and width
                                  borderRadius:
                                  BorderRadius.circular(
                                      8.0), // Border radius
                                ),
                                child:
                                //ReorderableListView(
                                ListView(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  /*onReorder: (int oldIndex, int newIndex) {
                                    setState(() {
                                      if (newIndex > oldIndex) {
                                        newIndex -= 1;
                                      }
                                      final item = _rankableOptions_
                                          .removeAt(oldIndex);
                                      _rankableOptions_.insert(
                                          newIndex, item);
                                    });
                                  },*/
                                  children: [
                                    for (int index = 0;
                                    index < _rankableOptions_.length;
                                    index++)
                                      Padding(
                                        key: ValueKey(
                                            _rankableOptions_[index]),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 4.0),
                                        child: // Adam tette be, kesobb kiveheto:
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.7,
                                          // Make the cells narrower
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            // Background color for the container
                                            border: Border.all(
                                                color: Colors.grey.shade600,
                                                width: 1.0),
                                            // Border color and width
                                            borderRadius:
                                            BorderRadius.circular(
                                                8.0), // Border radius
                                          ),
                                          child:
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [



                                              /*
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.1,
                                                child: Icon(icon_most[_Types[index]],size: MediaQuery.of(context).size.width * 0.05,),),
                                              */

                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.1,
                                                // Make the cells narrower
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
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
                                                  title: Text(felirat_most[_Types[index]]!,
                                                    style: TextStyle(
                                                        color: Colors.grey
                                                            .shade800), // Text color
                                                  ),
                                                  tileColor: Colors.grey
                                                      .shade100, // Background color for the tile
                                                ),
                                              ),

                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.05,
                                                // Make the cells narrower
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
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
                                                  title: TextField(
                                                    style: TextStyle(
                                                        color: Colors.grey
                                                            .shade800), // Text color
                                                  ),
                                                  tileColor: Colors.grey
                                                      .shade100, // Background color for the tile
                                                ),
                                              ),

                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.05,
                                                // Make the cells narrower
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
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
                                                  title: TextField(
                                                    style: TextStyle(
                                                        color: Colors.grey
                                                            .shade800), // Text color
                                                  ),
                                                  tileColor: Colors.grey
                                                      .shade100, // Background color for the tile
                                                ),
                                              ),


                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.05,
                                                // Make the cells narrower
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
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
                                                  title: TextField(
                                                    style: TextStyle(
                                                        color: Colors.grey
                                                            .shade800), // Text color
                                                  ),
                                                  tileColor: Colors.grey
                                                      .shade100, // Background color for the tile
                                                ),
                                              ),


                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.05,
                                                // Make the cells narrower
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
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
                                                  title: TextField(
                                                    style: TextStyle(
                                                        color: Colors.grey
                                                            .shade800), // Text color
                                                  ),
                                                  tileColor: Colors.grey
                                                      .shade100, // Background color for the tile
                                                ),
                                              ),

                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.05,
                                                // Make the cells narrower
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
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
                                                  title: TextField(
                                                    style: TextStyle(
                                                        color: Colors.grey
                                                            .shade800), // Text color
                                                  ),
                                                  tileColor: Colors.grey
                                                      .shade100, // Background color for the tile
                                                ),
                                              ),

                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.05,
                                                // Make the cells narrower
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
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
                                                  title: TextField(
                                                    style: TextStyle(
                                                        color: Colors.grey
                                                            .shade800), // Text color
                                                  ),
                                                  tileColor: Colors.grey
                                                      .shade100, // Background color for the tile
                                                ),
                                              ),

                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.05,
                                                // Make the cells narrower
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
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
                                                  title: TextField(
                                                    style: TextStyle(
                                                        color: Colors.grey
                                                            .shade800), // Text color
                                                  ),
                                                  tileColor: Colors.grey
                                                      .shade100, // Background color for the tile
                                                ),
                                              ),




                                            ],
                                          ),
                                        ),

                                      ),
                                  ],
                                ),
                              ),




                            SizedBox(
                                height:
                                MediaQuery.of(context).size.width * 0.02),
                            GradientButton(
                              text: 'TOVÁBB',
                              gradient: LinearGradient(
                                colors: [Colors.yellow, AppColors.yellow],
                              ),
                              onPressed: () {
                                if (_controller.text.isNotEmpty) {
                                  _sendAnswer(currentQuestion.index, _controller.text);
                                  quizProvider1.nextQuestion();
                                  _scrollToTop();
                                  if (quizProvider1.isQuizFinished) {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ModuleOpening_M3('Azonosito')));
                                  }
                                  _controller.clear();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                        Text('Kérlek, írd be a válaszod!')),
                                  );
                                }
                              },
                              showIcon: true,
                            ),
                          ],
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.5,
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
                                onTap: () async {},
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
                                  '1-2. hét',
                                  style: MyTextStyles.vastagbekezdes(context),
                                ),
                                subtitle: Text(
                                  'Zárolva',
                                  style: MyTextStyles.kicsibekezdes(context),
                                ),
                                onTap: () {},
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
                              onTap: () {},
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
                              leading: Image.asset('assets/images/6icon_m.png'),
                              title: Text(
                                '5-6. hét',
                                style: MyTextStyles.vastagbekezdes(context),
                              ),
                              subtitle: Text(
                                'Zárolva',
                                style: MyTextStyles.kicsibekezdes(context),
                              ),
                              onTap: () {},
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
                              onTap: () {},
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
                              onTap: () {},
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
