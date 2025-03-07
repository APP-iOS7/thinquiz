class Card {
  String content;
  String type;

  Card({required this.content, required this.type});

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      content: json['content'] as String,
      type: json['type'] as String,
    );
  }
}
