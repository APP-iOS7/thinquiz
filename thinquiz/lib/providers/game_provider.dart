import 'package:flutter/material.dart';
import 'package:thinquiz/models/game.dart';
import 'package:thinquiz/models/quiz.dart';

import '../services/game_storage_service.dart';

class GameProvider extends ChangeNotifier {
  final Game _item = Game(hintCount: 3, quizIndex: 0, totalPoint: 0, quizList: [
    Quiz(
        title: '사탕나누기',
        point: 30,
        hint:
            '50개들이 병 10개이므로\n사탕은 전부 500개이다. 이를 20개의 봉투에 나눠 담는 것이다.\n\n여기까지의 계산은 간단.\n\n그 다음은...\n수수께끼의 문장을 다시 한 번 잘 읽어 보자.',
        content:
            '사탕 50개 들어 있는 병이 10개 있다. 이를 적당히 반씩 나누어 봉투에 담았더니 20개의 사탕봉투가 생겼다.\n\n이때 봉투에 나눠담은 사탕 수의 평균이 25개가 될 확률은 몇퍼센트일까?',
        answer: '100',
        solution:
            '50개들이 병이 10개이므로\n사탕은 500개.\n이를 20개의 봉투에 나눠 담는 것이므로\n\n평균은 당연히 25개 인것이다.',
        status: QuizStatus.solving,
        quizImage: '',
        isHintOpen: false),
    Quiz(
        title: '면적은 몇 배',
        point: 30,
        hint: '회전 시켜 보세요!',
        content:
            '가장 바깥쪽에 있는 파란 선으로\n그려진 정사각형의 면적은\n가장 안쪽에 있는 빨간 선으로\n그려진 정사각형 면적의 몇배일까?',
        answer: '4',
        solution:
            '그림과 같이 중간에 있는 정사각형을\n45도 회전시켜 보면 간단히 알 수 있다.\n중간 정사각형은 바깥쪽 정사각형의 반.\n안쪽 정사각형은 중간 정사각형의 반이\n되는 것이다. 그러므로 안쪽 정사각형은\n바깥쪽 정사각형의 4분의 1인 것이 된다.',
        status: QuizStatus.pending,
        quizImage: '002.png',
        isHintOpen: false),
    Quiz(
        title: '큰 숫자',
        point: 45,
        hint: '공통으로 들어가는 부분을 찾아봐!',
        content:
            '그림과 같이 9개의 나무판이 있다.\n중앙을 지나가는 가로세로 대각선의\n각각의 열의합이 모두 동일하도록\n1~51의 숫자 중에서 9개의 숫자를\n써 넣으려고 한다.\n\n열의 합계가 가장 크게 되도록\n하려면 중앙의 나무판에는\n어떤 숫자를 넣어야 할까?',
        answer: '51',
        solution:
            '가로세로 그리고 대각선(두방향)\n모두가 최대가 되게 하기 위해서는 모든 열에 공통으로 포함되는 위치에 가장 큰 숫자를 넣어야 할 것이다.',
        status: QuizStatus.pending,
        quizImage: '003.png',
        isHintOpen: false),
    Quiz(
        title: '수통의 물',
        point: 30,
        hint: '흘러 넘친다라는 말을 잘 생각해!',
        content:
            '깊이가 2.5m인 수통에 아침9시부터\n8시간동안 물을 받으면 수면이 60cm\n상승한다고 한다.\n그런데 밤 사이에 물이 새는지, 다음 날\n아침 9시에는 다시 수면이 20cm 하강한다고 한다.\n이런 식으로 수면이 1일에 40cm씩 상승한다고 하면, 물이 처음으로 수통에서 흘러 넘치는 것은 며칠 째일까?',
        answer: '6',
        solution:
            '1일 40cm씩 상승하므로\n6일째에는 240cm, 2.4m가 되고 7일째에 남은 10cm가 상승하여 흘러 넘칠 것이라고 생각하기 쉽다.\n하지만 5일째에는 200cm까지 상승하고, 6일째 낮 사이에 60cm가 상승하므로 6일째 오후에 처음으로 흘러 넘치게 되는 것이다.',
        status: QuizStatus.pending,
        quizImage: '',
        isHintOpen: false),
    Quiz(
        title: '관람차 수수께끼',
        point: 50,
        hint: '사람이 비어있는 시간이 필요해!',
        content:
            '어느 놀이공원의 관람차에 2인승 탑승실이 10개 있고 각 탑승실은 1분 간격으로 탑승구에 도착한다고 한다.\n\n어느 날 오전 10시부터 운행을 시작하여 30분 후에 운행을 종료했다면,\n최대 몇 명의 승객을 태울 수 있었을까?',
        answer: '42',
        solution:
            '운행을 시작한 후 9분 동안은 사람을 태우지 않은 탑승실이 도착한다.\n또한 운행 종료 9분 전부터는 당연히 새로운 승객을 태우지 않을 것이다.\n시작 10분 후부터 승객을 태운 탑승실이 도착하기 시작하여 마지막 탑승실이 도착하는 30분 후까지는 총 21대의 탑승실이 도착하는 것이다.',
        status: QuizStatus.pending,
        quizImage: '',
        isHintOpen: false),
    Quiz(
        title: '천 배의 수수께끼',
        point: 20,
        hint: '모여서 하나가 된다라는 것을 생각해!',
        content:
            '다음과 같은 암호가 쓰여있는 종이가 있다.\n\n ⌜1__ = 1000___⌟\n\n__는 ___의 천 배가 된다는 뜻인데\n__에 알파벳 1글자를 넣으면 \n의미가 통하는 문장이 된다고 한다.\n그 글자는 무엇일까?\n__에 들어가는 글자는 모두 같은 글자이다.',
        answer: 'M',
        solution: '미터는\n밀리미터의 천 배인 것이다.',
        status: QuizStatus.pending,
        quizImage: '',
        isHintOpen: false),
    Quiz(
        title: '쥐와 고양이',
        point: 25,
        hint: '말 그대롭니다.',
        content:
            '고양이 5마리가 5분 동안에 쥐를 5마리 잡을 수 있다고 한다.\n\n같은 비율로 쥐를 잡는다면, 100마리의 쥐를 100분만에 잡기 위해서는 몇마리의 고양이가 있어야 할까?',
        answer: '5',
        solution:
            '5마리\n\n5마리가 5분 동안 5마리를 잡는다. 또 5분 뒤에는 10마리가 잡혀있을 것이다.\n즉 5마리의 고양이가 계속 쥐를 잡으면 10분동안 10마리, 20분 동안 20마리 ... 잡은 쥐의 수는 계속해서 늘어나는 것이다.',
        status: QuizStatus.pending,
        quizImage: '',
        isHintOpen: false),
    Quiz(
        title: '마름모의 면적',
        point: 60,
        hint: '마름모를 잘라봐!',
        content:
            '그림과 같은 깃발을 디자인했다.\n\n중앙에 있는 마름모의 면적은 깃발 전체 면적의 몇 분의 1일까?\n\n어렵게 생각하지 말고 단번에 정답을 맞혀보자.',
        answer: '8',
        solution:
            '각 부분의 길이가 포인트.\n마름모 부분이 원래 깃발의 16분의 1에 해당하는 면적 2개로 이루어져 있음을 알 수 있다.\n\n즉, 깃발 전체의 8분의 1이 되는 것이다.',
        status: QuizStatus.pending,
        quizImage: '008.png',
        isHintOpen: false),
    Quiz(
        title: '주사위 나열',
        point: 60,
        hint: '주사위를 나눠서 생각해봐!',
        content:
            '그림과 같이 주사위의 3과 6의 눈이 어떤 법칙에 따라 나열되 되어 있다고 한다.\n\n그럼 이 법칙을 추리하여 오른쪽 끝의 ⌜ ? ⌟에 들어갈 주사위의 눈을 맞혀 보아라.',
        answer: 'C',
        solution:
            '늘어놓은 주사위의 눈을 상,중,하의 3단으로 나누어 보면 상단의 배열에는 규칙성이 있다.\n주사위 눈에 있는 점의 배열이 1개부터 점점 늘어가는 것이다. ⌜ ? ⌟ 부분에는 6개의 점이 붙어 있어야 하므로 왼쪽의 주사위에 이어서 상단에 점이 세 개 위치하는 눈이 오도록 고르면 된다.',
        status: QuizStatus.pending,
        quizImage: '009.png',
        isHintOpen: false),
    Quiz(
        title: '이어진 선',
        point: 20,
        hint: '없음',
        content:
            '그림은 어느 정사면체의 전개도이다.이 전개도를 다시 정사면체로 만들었을 때 빨간 선과 파란 선이 끊어지지 않고 이어지도록 하기 위해서는 물음표 부분에 다음 중 어느 조각을 넣어야 할까?',
        answer: 'C',
        solution: '입체적 사고가 필요한 수수께끼이다.',
        status: QuizStatus.pending,
        quizImage: '010.png',
        isHintOpen: false)
  ]);

  Game get item => _item;
  int get hintCount => _item.hintCount;
  int get quizIndex => _item.quizIndex;
  int get totalPoint => _item.totalPoint;
  List<Quiz> get quizItems => _item.quizList;

  Color getQuizColor(int index) {
    QuizStatus status = _item.quizList[index].status;

    switch (status) {
      case QuizStatus.correct:
        return Color(0xff003049);
      case QuizStatus.incorrect:
        return Color(0xffa22c29);
      case QuizStatus.solving:
        return Color(0xffffc300);
      case QuizStatus.pending:
        return Color(0xffd6d5c9);
    }
  }

  void increaseQuizIndex() {
    _item.quizIndex++;
    _item.quizList[_item.quizIndex].status = QuizStatus.solving;
    notifyListeners();
  }

  void increaseHint() {
    _item.hintCount++;
    notifyListeners();
  }

  void decreaseHint() {
    _item.hintCount--;
    notifyListeners();
  }

  // main_screen 의 진행 사항 초기화 버튼 동작을 위해 코드 추가
  Future<void> clearGame() async {
    final storageService = GameStorageService();
    await storageService.clearGame();

    _item.hintCount = 3;
    _item.quizIndex = 0;
    _item.totalPoint = 0;
    for (var quiz in _item.quizList) {
      quiz.status = QuizStatus.pending;
    }
    notifyListeners();
  }
}
