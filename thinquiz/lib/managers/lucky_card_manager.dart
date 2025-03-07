import 'dart:math';

import 'package:thinquiz/models/lucky_card.dart';

class LuckyCardManager {
  static final LuckyCardManager _instance = LuckyCardManager._internal();
  List<LuckyCard> _items = [];

  factory LuckyCardManager() => _instance;

  LuckyCardManager._internal() {
    _items = [
      LuckyCard(content: '힌트가 1개 더 제공됩니다!', type: CardType.chance),
      LuckyCard(content: '정답을 맞출 경우 점수를 두배로 획득합니다!', type: CardType.chance),
      LuckyCard(content: '이번 문제를 패스해도 정답으로 인정됩니다!', type: CardType.chance),
      LuckyCard(content: '이번 문제에서 힌트를 사용할 수 없습니다.', type: CardType.penalty),
      //LuckyCard(content: '제한 시간이 1분 증가합니다!', type: CardType.chance)
      //LuckyCard(content: '제한 시간이 1분 감소합니다', type: CardType.penalty)
      //LuckyCard(content: '이번 문제에서 패스를 사용할 수 없습니다', type: CardType.penalty)
    ];
  }

  int get count => _items.length;
  List<LuckyCard> get shuffledItems =>
      [..._items]..shuffle(Random(Random().nextInt(10000)));
}
