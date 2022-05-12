import 'package:flutter/material.dart';
import 'package:bezier_chart/bezier_chart.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  @override
  Widget build(BuildContext context) {
    final fromDate = DateTime(2018, 11, 22);
    final toDate = DateTime.now();

    final date1 = DateTime.now().subtract(const Duration(days: 2));
    final date2 = DateTime.now().subtract(const Duration(days: 3));

    final date3 = DateTime.now().subtract(const Duration(days: 35));
    final date4 = DateTime.now().subtract(const Duration(days: 36));

    final date5 = DateTime.now().subtract(const Duration(days: 65));
    final date6 = DateTime.now().subtract(const Duration(days: 64));

    return SafeArea(
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text("記録",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600]))),
          Container(
            color: Colors.grey[200],
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: BezierChart(
              bezierChartScale: BezierChartScale.MONTHLY,
              fromDate: fromDate,
              toDate: toDate,
              selectedDate: toDate,
              series: [
                BezierLine(
                  label: "Duty",
                  onMissingValue: (dateTime) {
                    if (dateTime.month.isEven) {
                      return 10.0;
                    }
                    return 5.0;
                  },
                  data: [
                    DataPoint<DateTime>(value: 10, xAxis: date1),
                    DataPoint<DateTime>(value: 50, xAxis: date2),
                    DataPoint<DateTime>(value: 20, xAxis: date3),
                    DataPoint<DateTime>(value: 80, xAxis: date4),
                    DataPoint<DateTime>(value: 14, xAxis: date5),
                    DataPoint<DateTime>(value: 30, xAxis: date6),
                  ],
                ),
              ],
              config: BezierChartConfig(
                verticalIndicatorStrokeWidth: 3.0,
                verticalIndicatorColor: Colors.black26,
                showVerticalIndicator: true,
                verticalIndicatorFixedPosition: false,
                backgroundColor: Colors.grey,
                footerHeight: 30.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
