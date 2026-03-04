import 'package:flutter/material.dart';

/// File này chứa các nút chọn thời gian và Dropdown chọn chỉ số.
class ChartFilterControls extends StatelessWidget {
  final String selectedMetric;
  final List<String> metrics;
  final Function(String) onMetricChanged;

  const ChartFilterControls({
    super.key,
    required this.selectedMetric,
    required this.metrics,
    required this.onMetricChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildTimeButton("Tuần", const Color(0xFF2028BD), Colors.white),
            const SizedBox(width: 8),
            _buildTimeButton("Tháng", Colors.orange, Colors.white),
          ],
        ),
        _buildMetricDropdown(),
      ],
    );
  }

  Widget _buildMetricDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedMetric,
          dropdownColor: Colors.white,
          items: metrics.map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
          onChanged: (v) {
            if (v != null) onMetricChanged(v);
          },
        ),
      ),
    );
  }

  Widget _buildTimeButton(String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 13)),
    );
  }
}