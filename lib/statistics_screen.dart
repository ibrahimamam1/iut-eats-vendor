// lib/statistics_screen.dart
import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(8.0),
          children: [
            Card(
              elevation: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Total Sales', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text('\$10,000', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Card(
              elevation: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Number of Orders', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text('150', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(8.0),
            color: Colors.grey[200],
            child: Center(
              child: Text('Sales Chart Placeholder', style: TextStyle(fontSize: 18)),
            ),
          ),
        ),
      ],
    );
  }
}