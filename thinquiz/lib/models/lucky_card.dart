class LuckyCard {
  String content;
  CardType type;

  LuckyCard({required this.content, required this.type});
}

enum CardType { chance, penalty }
