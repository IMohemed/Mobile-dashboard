import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
  top: 15,
  left: MediaQuery.of(context).size.width / 4, // Move the widget to the center horizontally
  right: MediaQuery.of(context).size.width / 4,
  child: Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
           // _scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(Icons.menu),
          color: Colors.white,
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                // showDialog(
                //   context: context,
                //   builder: (BuildContext context) {
                //     //return calender();
                //   },
                // );
              },
              icon: Icon(Icons.calendar_today, color: Colors.white),
            ),
            IconButton(
              onPressed: () async {
                //await api.loadPieChartData(date: date1, loca: 4, imei: mei);
              },
              icon: Icon(Icons.notifications, color: Colors.white),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.refresh, color: Colors.white),
            ),
          ],
        ),
      ],
    ),
  ),
),

Positioned(
  top: 75,
  left: MediaQuery.of(context).size.width / 4, // Move the widget to the center horizontally
  right: MediaQuery.of(context).size.width / 4,
  child: Center(
    child: Container(
      child: Text(
        NumberFormat.currency(locale: 'si_LK', symbol: 'LKR', decimalDigits: 2)
            .format(7890)
            .replaceFirst('LKR', 'LKR '), // Format the number as needed
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    ),
  ),
),
        ],
      ),
    );
  }
}