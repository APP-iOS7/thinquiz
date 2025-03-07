import 'package:flutter/material.dart';
import 'package:thinquiz/widgets/card_widget.dart';

class LuckyCardScreen extends StatefulWidget {
  const LuckyCardScreen({super.key});

  @override
  State<LuckyCardScreen> createState() => _LuckyCardScreenState();
}

class _LuckyCardScreenState extends State<LuckyCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '행운카드를 뽑아보세요',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: 50),
          Container(
            width: 300,
            height: 300,
            alignment: Alignment.center,
            child: CardWidget(),
          )
        ],
      ),
    ));
  }
}
