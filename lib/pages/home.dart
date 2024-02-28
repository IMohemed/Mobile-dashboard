import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
    dotColors = List.filled(numberOfDots, Colors.transparent);
    _timer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      setState(() {
        //_currentDot = (_currentDot + 3) % numberOfDots;
        updateDotColors();
        _angle += 0.2;
      });
    });
  }

   void updateDotColors() {
    dotColors = List.generate(numberOfDots, (index) {
      final colorIndex = (_currentDot + index) % dotColors.length;
      return index == _currentDot ? dotColors[colorIndex] : Colors.transparent;
    });
    _currentDot = (_currentDot + 1) %numberOfDots;
  }

//int _currentDot = 0; 

  @override
  Widget build(BuildContext context) {
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
          Expanded(
            child: Container(
              alignment: Alignment.center,
             child: SizedBox(
        height: dotSize * 2,
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: List.generate(numberOfDots, (index) {
        //     final colorIndex = index % dotColors.length;
        //     final color = dotColors[colorIndex];
        //     // return Padding(
        //     //   padding: EdgeInsets.symmetric(horizontal: dotSize / 2),
        //     //   child: Container(
        //     //     width: dotSize,
        //     //     height: dotSize,
        //     //     decoration: BoxDecoration(
        //     //       shape: BoxShape.circle,
        //     //       color: index == _currentDot ? color : Colors.transparent,
        //     //     ),
        //     //   ),
        //     // );

        //   }),
        // ),
        child: Stack(
          children: List.generate(numberOfDots, (index) {
            final colorIndex = index % dotColors.length;
            final double angle = (2 * pi * index /numberOfDots) + _angle;
            final double x = cos(angle) *dotSize * 2;
            final double y = sin(angle) *dotSize * 2;
            final color = dotColors[colorIndex];

            return Center(
              child: Transform.translate(
                offset: Offset(x, y),
                child: Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                     
                    color:index == _currentDot ? color : Colors.transparent,
                  ),
                ),
              ),
            );
          }),
        ),
      )
            ),
          ),
        ],
      ),
    
    );
  }
}