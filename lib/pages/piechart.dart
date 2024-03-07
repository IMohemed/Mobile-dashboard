import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartWidget extends StatelessWidget {
  Map<String, dynamic>?  departmentData;
  PieChartWidget({ this.departmentData});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height/2,
          child: 
          // PieChart(
          //   PieChartData(
          //     sections: [departmentData?['piedate']],
              
          //   ),
          // ),
          PieChart(
  PieChartData(
    sections:List.generate(departmentData?['piedate'].length, (index) {
      final sectionData = departmentData?['piedate'][index];
      return PieChartSectionData(
        color: sectionData.color,
        value: sectionData.value,
        title: sectionData.title,
        radius: sectionData.radius,
      );
    }).toList(),
  ),
),

        ),
      ),
    );
  }
}


