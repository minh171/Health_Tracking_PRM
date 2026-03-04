import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Chứa các hàm cung cấp dữ liệu số (tọa độ $x, y$).
class ChartDataModel {
  // Sau này truyền List<DataFromServer> vào đây
  static List<LineChartBarData> getBloodPressureData() {
    return [
      _lineData([118, 125, 142, 130, 128, 135, 120], Colors.red),
      _lineData([75, 82, 95, 85, 80, 88, 78], Colors.blue),
    ];
  }

  static List<LineChartBarData> getGlucoseData() {
    return [
      LineChartBarData(
        spots: const [FlSpot(0, 85), FlSpot(1, 120), FlSpot(2, 110), FlSpot(3, 160), FlSpot(4, 95), FlSpot(5, 105), FlSpot(6, 115)],
        color: Colors.orange,
        isCurved: true,
        barWidth: 4,
        belowBarData: BarAreaData(show: true, color: Colors.orange.withOpacity(0.1)),
        dotData: const FlDotData(show: true),
      )
    ];
  }

  static List<BarChartGroupData> getWeightData() {
    final values = [68.5, 69.2, 67.8, 68.0];
    return values.asMap().entries.map((e) => BarChartGroupData(
      x: e.key,
      barRods: [BarChartRodData(toY: e.value, color: Colors.green, width: 20, borderRadius: BorderRadius.circular(4))],
    )).toList();
  }

  static List<LineChartBarData> getSpO2Data() {
    return [
      LineChartBarData(
        spots: const [FlSpot(0, 98), FlSpot(1, 95), FlSpot(2, 99), FlSpot(3, 97), FlSpot(4, 94), FlSpot(5, 98), FlSpot(6, 99)],
        color: Colors.teal,
        isCurved: true,
        barWidth: 4,
        dotData: const FlDotData(show: true),
      )
    ];
  }

  static LineChartBarData _lineData(List<double> yValues, Color color) {
    return LineChartBarData(
      spots: yValues.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
      isCurved: true,
      color: color,
      barWidth: 4,
      dotData: const FlDotData(show: true),
    );
  }
}