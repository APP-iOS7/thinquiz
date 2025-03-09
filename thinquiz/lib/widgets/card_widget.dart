import 'package:flutter/material.dart';
import 'package:thinquiz/managers/lucky_card_manager.dart';
import 'package:thinquiz/models/lucky_card.dart';

class CardWidget extends StatefulWidget {
  final List<LuckyCard> items = LuckyCardManager().shuffledItems;
  CardWidget({super.key});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> with TickerProviderStateMixin {
  int? selectedCard;
  late List<AnimationController> _controllers;
  bool isSelectionComplete = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
        4,
        (index) => AnimationController(
            duration: Duration(microseconds: 500), vsync: this));
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _selectedCard(int index) {
    if (selectedCard != null || isSelectionComplete) return;

    LuckyCardManager().currentCard = widget.items[index];
    
    setState(() {
      selectedCard = index;
      isSelectionComplete = true;
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: isSelectionComplete
            ? AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: 250,
                height: 200,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: widget.items[selectedCard!].type == CardType.chance
                      ? Color(0xff669bbc)
                      : Color(0xffa22c29)
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.items[selectedCard!].type == CardType.chance
                              ? '찬스 카드'
                              : '페널티 카드',
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(height: 10),
                        Text(
                          widget.items[selectedCard!].content,
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 9),
                        TextButton(
                            style: TextButton.styleFrom(
                                splashFactory: NoSplash.splashFactory),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Center(
                                child: const Text('확인',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))))
                      ],
                    )),
                  ),
                ),
              )
            : SizedBox(
                width: 300,
                height: 300,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 40,
                  padding: EdgeInsets.all(2),
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(4, (index) {
                    return GestureDetector(
                      onTap: () => _selectedCard(index),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xffd6d9c5),
                              borderRadius: BorderRadius.circular(5))),
                    );
                  }),
                )));
  }
}
