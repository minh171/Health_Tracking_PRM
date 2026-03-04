import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'chart_widgets.dart';
import 'chart_data_model.dart';


/// File này xử lý logic "Switch-case" để quyết định vẽ biểu đồ nào.
/// Đây là nơi bạn sẽ "map" dữ liệu từ ChartDataModel vào các fl_chart.
class ChartContentView extends StatelessWidget {
  final String selectedMetric;

  const ChartContentView({super.key, required this.selectedMetric});

  @override
  Widget build(BuildContext context) {
    switch (selectedMetric) {
      case "Huyết áp":
        return LineChart(LineChartData(
          gridData: const FlGridData(show: true, drawVerticalLine: true, horizontalInterval: 20),
          borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey.shade300)),
          titlesData: ChartWidgets.buildTitles(
            leftLabel: "mmHg", bottomLabel: "Thứ", interval: 20,
            bottomValues: ["T2", "T3", "T4", "T5", "T6", "T7", "CN"],
          ),
          lineBarsData: ChartDataModel.getBloodPressureData(),
        ));
      case "Đường huyết":
        return LineChart(LineChartData(
          gridData: const FlGridData(show: true, horizontalInterval: 40),
          borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey.shade300)),
          titlesData: ChartWidgets.buildTitles(
            leftLabel: "mg/dL", bottomLabel: "Ngày", interval: 40,
            bottomValues: ["01", "05", "10", "15", "20", "25", "30"],
          ),
          lineBarsData: ChartDataModel.getGlucoseData(),
        ));
      case "Cân nặng":
        return BarChart(BarChartData(
          titlesData: ChartWidgets.buildTitles(
            leftLabel: "kg", bottomLabel: "Tuần", interval: 10,
            bottomValues: ["W1", "W2", "W3", "W4"],
          ),
          borderData: FlBorderData(show: false),
          barGroups: ChartDataModel.getWeightData(),
        ));
      case "SpO2":
        return LineChart(LineChartData(
          minY: 80, maxY: 100,
          titlesData: ChartWidgets.buildTitles(
            leftLabel: "%", bottomLabel: "Giờ", interval: 5,
            bottomValues: ["08h", "10h", "12h", "14h", "16h", "18h", "20h"],
          ),
          lineBarsData: ChartDataModel.getSpO2Data(),
        ));
      default:
        return const Center(child: Text("Đang cập nhật..."));
    }
  }
}