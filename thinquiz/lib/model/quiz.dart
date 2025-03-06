class Quiz {
  final String title;
  final int point;
  final String hint;
  final String content;
  final String answer;
  final String solution;
  final String status;
  final String quizImage;

  Quiz({
    required this.title,
    required this.point,
    required this.hint,
    required this.content,
    required this.answer,
    required this.solution,
    required this.status,
    required this.quizImage,
  });

  // factory Quiz.fromJson(Map<String, dynamic> json) {
  //   return Quiz(
  //     title: json['title'] as String,
  //     point: json['point'] as int,
  //     hint: json['hint'] as String,
  //     content: json['content'] as String,
  //     answer: json['answer'] as String,
  //     solution: json['solution'] as String,
  //     status: json['status'] as String,
  //     quizImage: json['quizImage'] as String,
  //   );
  // }
}
