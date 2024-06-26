class Question {
  final String text;
  final int index;
  final bool requiresTextInput;
  final bool requiresRanking;
  final bool requiresVideo;
  final String video;
  final bool twoColumn;
  final bool requiresRadioOptions;
  final List<RadioOption> radioOptions;
  final List<Answer> answers;
  List<String> rankableOptions;
  List<String> NotFillableOptions;
  int NotFillableindex = 0;
  final bool hasInfoButton;
  final String infoButtonText;
  final bool allowsComment;
  final String commentText;
  final List<TwoColumnEntry> twoColumnEntries;
  final String prosText;
  final String consText;
  final List<TwoColumnEntry> readonlyTwoColumnEntries;

  Question({
    required this.text,
    required this.index,
    this.requiresTextInput = false,
    this.requiresRanking = false,
    this.requiresVideo = false,
    required this.answers,
    this.rankableOptions = const [],
    this.NotFillableOptions = const [],
    this.video = '',
    required this.twoColumn,
    this.requiresRadioOptions = false,
    this.radioOptions = const [],
    this.hasInfoButton = false,
    this.infoButtonText = '',
    this.allowsComment = false,
    this.commentText = '',
    this.twoColumnEntries = const [],
    this.prosText = 'Előnyök',
    this.consText = 'Hátrányok',
    this.readonlyTwoColumnEntries = const [],

  });
}


class RadioOption {
  final String text;
  final int nextQuestionIndex;

  RadioOption({
    required this.text,
    required this.nextQuestionIndex,
  });
}

class Answer {
  final String text;
  final int nextQuestionIndex;
  final bool isNumeric;
  final bool isScale;
  final bool isRankable;
  final bool isVideo;
  final String video;

  Answer({
    this.text = '',
    required this.nextQuestionIndex,
    this.isNumeric = false,
    this.isScale = false,
    this.isRankable = false,
    this.isVideo = false,
    this.video = '',
  });
}

// New class to represent a 2-column table entry
class TwoColumnEntry {
  final String pros;
  final String cons;
  final bool isFillable;

  TwoColumnEntry({
    required this.pros,
    required this.cons,
    this.isFillable = true, // Default to true, assuming most entries will be fillable unless specified otherwise
  });
}