import 'package:flutter/material.dart';

class DrawingApp extends StatelessWidget {
  const DrawingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DrawingScreen(),
                  fullscreenDialog: true, // Fullscreen Dialog 설정
                ),
              );
            },
            child: const Text('Open Drawing Screen'),
          ),
        ),
      ),
    );
  }
}

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key});

  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  List<DrawnLine> lines = [];
  Color drawColor = Colors.black;
  double strokeWidth = 4.0;

  void _startDrawing(Offset position) {
    setState(() {
      lines.add(DrawnLine(
        [position],
        drawColor,
        strokeWidth,
      ));
    });
  }

  void _draw(Offset position) {
    setState(() {
      if (lines.isNotEmpty) {
        lines.last.points.add(position);
      }
    });
  }

  void _clearDrawing() {
    setState(() {
      lines.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Scaffold 배경 투명
      appBar: AppBar(
        //backgroundColor: Colors.transparent, // AppBar를 투명하게 설정
        //elevation: 0, // 그림자 제거
        title: const Text('메모장'),
        leading: IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: _clearDrawing,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop(); // 닫기
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black.withOpacity(0.2), // 화면 배경 투명
        child: GestureDetector(
          onPanStart: (details) => _startDrawing(details.localPosition),
          onPanUpdate: (details) => _draw(details.localPosition),
          child: CustomPaint(
            painter: DrawingPainter(lines),
            size: Size.infinite,
          ),
        ),
      ),
    );
  }
}

class DrawnLine {
  List<Offset> points;
  Color color;
  double strokeWidth;

  DrawnLine(this.points, this.color, this.strokeWidth);
}

class DrawingPainter extends CustomPainter {
  final List<DrawnLine> lines;

  DrawingPainter(this.lines);

  @override
  void paint(Canvas canvas, Size size) {
    for (var line in lines) {
      final paint = Paint()
        ..color = line.color
        ..strokeWidth = line.strokeWidth
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      for (int i = 0; i < line.points.length - 1; i++) {
        canvas.drawLine(line.points[i], line.points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
