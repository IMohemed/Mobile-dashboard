import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  Map<String, dynamic>?  departmentData;
   Report({super.key,this.departmentData});

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
              lineBarsData: List.generate(widget.departmentData?['output'].length, (index) {
      final sectionData = widget.departmentData?['output'][index];
      return LineChartBarData(
        spots: 
          sectionData.spots
          ,
        color: sectionData.color,
        isCurved: sectionData.isCurved,
        barWidth: sectionData.barWidth,
        isStrokeCapRound: sectionData.isStrokeCapRound,
      );
    }).toList(),
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