import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  
  late final List<FlSpot> line1Data;
  late final List<FlSpot> line2Data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        //margin: EdgeInsets.only(top: 200),
          
           children:[Container(
            height: MediaQuery.of(context).size.height/2,
             child: Card(
              
              margin: EdgeInsets.all(0),
              child: LineChart(
                  LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 0),
                    FlSpot(1, 1),
                    FlSpot(2, 2),
                    FlSpot(3, 1.5),
                    FlSpot(4, 3),
                  ],
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 2,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(show: false),
                  dotData: FlDotData(show: true),
                ),
                LineChartBarData(
                  spots: [
                    FlSpot(0, 0),
                    FlSpot(2, 1),
                    FlSpot(5, 2),
                    FlSpot(6, 1.5),
                    FlSpot(8, 3),
                  ],
                  isCurved: true,
                  color: Colors.red,
                  barWidth: 2,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(show: false),
                  dotData: FlDotData(show: true),
                ),
              ],
              minY: 0,
              titlesData: FlTitlesData(
                leftTitles:  AxisTitles(
                     sideTitles: SideTitles(showTitles: false),
                   ),
                bottomTitles: AxisTitles(
                     sideTitles: SideTitles(showTitles: false),
                   ),
                topTitles:  AxisTitles(
                     sideTitles: SideTitles(showTitles: false),
                   ),
                rightTitles: AxisTitles(
                     sideTitles: SideTitles(showTitles: false),
                   ),
              ),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
                  ),
                ),
                     ),
           ),
           ]
      ),
    );
  }
}