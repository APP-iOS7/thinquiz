import 'package:flutter/material.dart';

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
              SizedBox(
                width: 300,
                height: 300,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                  padding: EdgeInsets.all(10),
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      )
    );
  }
}