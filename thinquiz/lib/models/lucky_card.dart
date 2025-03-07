class LuckyCard {
  String content;
  CardType type;
  CardEffect efftect;

  LuckyCard({required this.content, required this.type, required this.efftect});
}

enum CardType { chance, penalty }

enum CardEffect { moreHint, noHint, passOK, morePoints }
