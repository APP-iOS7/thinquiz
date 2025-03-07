class Quiz {
  String title;
  int point;
  String hint;
  String content;
  String answer;
  String solution;
  QuizStatus status;
  String quizImage;

  Quiz({
    required this.title, 
    required this.point,
    required this.hint,
    required this.content,
    required this.answer,
    required this.solution,
    required this.status,
    required this.quizImage
  });
}

enum QuizStatus { correct, incorrect, pending, inProgress }
