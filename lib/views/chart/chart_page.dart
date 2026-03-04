
import 'package:flutter/material.dart';
import 'package:health_tracking/views/chart/chart_content.dart';
import '../header/main_header.dart';
import '../footer/main_footer.dart';
import '../health_record/health_record_page.dart';
import '../home/home_page.dart';
import '../notification/notification_page.dart';
import '../setting/settings_page.dart';
import 'chart_widgets.dart';
import 'chart_filter_controls.dart';


/// Trang chính
class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  String selectedMetric = "Huyết áp";
  final List<String> metrics = ["Huyết áp", "Đường huyết", "Cân nặng", "SpO2"];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const MainHeader(subTitle: 'Biểu đồ thống kê'),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: Column(
              children: [
                // 1. Phần điều khiển lọc (Đã tách)
                ChartFilterControls(
                  selectedMetric: selectedMetric,
                  metrics: metrics,
                  onMetricChanged: (newValue) =>
                      setState(() => selectedMetric = newValue),
                ),

                const SizedBox(height: 30),

                // 2. Container trắng bao quanh biểu đồ
                Container(
                  height: screenHeight * 0.5,
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 40,
                    right: 35,
                    left: 10,
                    bottom: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  // 3. Nội dung biểu đồ (Đã tách)
                  child: ChartContentView(selectedMetric: selectedMetric),
                ),

                const SizedBox(height: 25),

                // 4. Chú thích (Sử dụng widget từ file chart_widgets)
                if (selectedMetric == "Huyết áp")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ChartWidgets.buildLegendItem("Tâm thu", Colors.red),
                      const SizedBox(width: 25),
                      ChartWidgets.buildLegendItem("Tâm trương", Colors.blue),
                    ],
                  ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: MainFooter(
        currentIndex: 2, // Fix cứng là 2 để icon chỉ số luôn sáng ở trang này
        onTap: (index) {
          if (index == 2) return; // Nếu đang ở trang chỉ số mà bấm lại thì thôi

          // Chuyển trang đơn giản bằng Navigator
          Widget nextPage;
          switch (index) {
            case 0: nextPage = const HomePage(); break;
            case 1: nextPage = const HealthRecordPage(); break;
            case 2: nextPage = const ChartPage(); break;
            case 3: nextPage = const NotificationPage(); break;
            case 4: nextPage = const SettingsPage(); break;
            default: nextPage = const HomePage();
          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => nextPage),
          );
        },
      ),
    );
  }
}
