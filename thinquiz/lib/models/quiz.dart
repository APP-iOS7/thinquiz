class Quiz {
  String title;
  int point;
  String hint;
  bool isHintOpen;
  String content;
  String answer;
  String solution;
  QuizStatus status;
  String quizImage;

  Quiz(
      {required this.title,
      required this.point,
      required this.hint,
      required this.isHintOpen,
      required this.content,
      required this.answer,
      required this.solution,
      required this.status,
      required this.quizImage});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      title: json['title'] as String,
      point: json['point'] as int,
      hint: json['hint'] as String,
      isHintOpen: json['isHintOpen'] as bool,
      content: json['content'] as String,
      answer: json['answer'] as String,
      solution: json['solution'] as String,
      status: quizStatusFromString(json['status'] as String),
      quizImage: json['quizImage'] as String,
    );
  }
}

enum QuizStatus { correct, incorrect, pending, solving }

String quizStatusToString(QuizStatus status) {
  return status.toString().split('.').last;
}

QuizStatus quizStatusFromString(String value) {
  return QuizStatus.values
      .firstWhere((status) => status.toString().split('.').last == value);
}
