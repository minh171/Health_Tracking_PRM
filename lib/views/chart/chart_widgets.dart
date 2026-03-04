import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Định nghĩa cách hiển thị các trục tọa độ (Trục X hiện Thứ/Ngày, Trục Y hiện đơn vị mmHg/kg).
/// Cấu hình khoảng cách các vạch kẻ (interval), font chữ, màu sắc nhãn.
/// Tạo các chú thích (Legend) màu sắc dưới biểu đồ.
class ChartWidgets {
  // Build tiêu đề trục X, Y dùng chung
  static FlTitlesData buildTitles({
    required String leftLabel,
    required String bottomLabel,
    required double interval,
    required List<String> bottomValues,
  }) {
    return FlTitlesData(
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        axisNameWidget: Text(leftLabel, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF379AE6))),
        axisNameSize: 20,
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          interval: interval,
          getTitlesWidget: (value, meta) => Text(value.toInt().toString(), style: const TextStyle(color: Colors.grey, fontSize: 10)),
        ),
      ),
      bottomTitles: AxisTitles(
        axisNameWidget: Text(bottomLabel, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF379AE6))),
        axisNameSize: 25,
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: (value, meta) {
            int index = value.toInt();
            if (index >= 0 && index < bottomValues.length) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(bottomValues[index], style: const TextStyle(color: Colors.grey, fontSize: 10)),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  static Widget buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(width: 14, height: 14, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }
}