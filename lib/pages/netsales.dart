import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Netsale extends StatefulWidget {
  const Netsale({super.key});

  @override
  State<Netsale> createState() => _NetsaleState();
}

class _NetsaleState extends State<Netsale> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
         Center(
           
            child: Padding(
              padding: EdgeInsets.all(0.0),
              child: Column(
                //mainAxisSize: MainAxisSize.max,
                
                children: [
                  Text('Net sales'),
                  Text('Text 2'),
                  Text('Text 3'),
                  Text('Text 4'),
                  Text('Text 5'),
                ],
              ),
            ),
                 
         ),
      
    );
  }
}