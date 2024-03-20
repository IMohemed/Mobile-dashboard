import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
       List<Color> dotColors = [
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.green,
          ];
  final double dotSize = 10.0;
  final int numberOfDots= 8;
  double _angle = 0;
   
  late Timer _timer;
  int _currentDot = 0;

  @override
  void initState() {
    super.initState();
  //  _controller = AnimationController(
  //     vsync: this,
  //     duration: Duration(seconds: 4),
  //   );
  _controllers = List.generate(numberOfDots, (index) {
  return AnimationController(
    vsync: this,
    duration: Duration(seconds: 40),
  )..repeat();
      //  });
});

_animations = _controllers.map((controller) {
  return CurvedAnimation(
    parent: controller,
      curve: Curves.easeInOut,
  );
}).toList();

// for (int i = 0; i < numberOfDots; i++) {
//   Future.delayed(Duration(milliseconds: (i * 500)), () {
//     _controllers[i].repeat(); // Start animation after a delay
//   });

// }
}
// for (var controller in _controllers) {
//       controller.forward(); // Start the animations
//     }
//   }

   @override
  void dispose() {
     for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

   

//int _currentDot = 0; 

  @override
  Widget build(BuildContext context) {
    final _animationDuration = Duration(seconds: 1);
    
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          // Top body part with image and title
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  SizedBox(height: 16.0),
                  Text(
                    'Title',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom body part with loading indicator
          Column(
            children:[ Center(
        child: TweenAnimationBuilder<double>(
  duration: _animationDuration,
  tween: Tween<double>(begin: 0.0, end: 2.0),
  builder: (context, value, child) {
    List<double> animationValues = _animations.map((animation) => animation.value * value).toList();
   return CustomPaint(
      // painter: DotPainter(
      //   //animations:animationValues,
      // ),
    );
  },
)
      ),]
          ),
        ],
      ),
    
    );
  }
}

class DotPainter extends CustomPainter {
   final List<Animation<double>> animations;
  static const int numberOfDots = 8;
  static const double dotRadius = 5;
  static const double circleRadius = 17;

  DotPainter({required this.animations}) : super(repaint: animations[0]) ;

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final double angleStep = 2 * pi / numberOfDots;

    for (int i = 0; i < numberOfDots; i++) {
      final angle = i * angleStep;
      final x = centerX + cos(angle) * circleRadius;
      final y = centerY + sin(angle) * circleRadius;

       double dotSize = dotRadius * (1 + animations[i].value);

      final paint = Paint()
        ..color = Colors.white
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.fill
        ..strokeWidth = 2;

      canvas.drawCircle(Offset(x, y), dotSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
