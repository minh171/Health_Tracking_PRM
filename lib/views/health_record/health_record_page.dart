import 'package:flutter/material.dart';

import '../chart/chart_page.dart';
import '../footer/main_footer.dart';
import '../header/main_header.dart';
import '../home/home_page.dart';
import '../notification/notification_page.dart';
import '../setting/settings_page.dart';
import 'health_record_card.dart';
import 'add_record_modal.dart';


class HealthRecordPage extends StatefulWidget {
  const HealthRecordPage({super.key});

  @override
  State<HealthRecordPage> createState() => _HealthRecordPageState();
}

class _HealthRecordPageState extends State<HealthRecordPage> {
  String selectedValue = 'Huyết Áp';
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: const MainHeader(subTitle: "Bản ghi sức khỏe"), // Sử dụng Header đã tách
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: _buildDropdown(),
              ),
              const SizedBox(height: 16),


              // Bên trong Widget build của màn hình chính:
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  // Tự động thay đổi dữ liệu dựa trên Dropdown
                  if (selectedValue == 'Huyết Áp') {
                    return const HealthRecordCard(
                      icon: Icons.favorite,
                      title: 'Huyết áp',
                      value: '120/80',
                      unit: 'mmHg',
                      note: 'Nhịp tim: 72bpm',
                      time: '22:32 30/01/2026',
                    );
                  } else if (selectedValue == 'Đường Huyết') {
                    return const HealthRecordCard(
                      icon: Icons.bloodtype_outlined, // Icon giọt máu
                      title: 'Đường huyết',
                      value: '100',
                      unit: 'mg/dL',
                      note: 'Lúc đói',
                      time: '22:32 30/01/2026',
                    );
                  } else if (selectedValue == 'Cân nặng') {
                    return const HealthRecordCard(
                      icon: Icons.balance, // Icon cái cân
                      title: 'Cân nặng',
                      value: '70',
                      unit: 'kg',
                      note: 'Đo trước khi ăn sáng',
                      time: '22:32 30/01/2026',
                    );
                  } else { // SpO2
                    return const HealthRecordCard(
                      icon: Icons.opacity, // SpO2 thường đo ở ngón tay
                      title: 'SpO2',
                      value: '85',
                      unit: '%',
                      note: 'Đo trước khi ngủ',
                      time: '22:32 30/01/2026',
                    );
                  }
                },
              ),


              const SizedBox(height: 80),
            ],
          ),
        ),
      ),

      // FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddRecordSheet(context),
        backgroundColor: const Color(0xFF3C83F6),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),

      // Footer
      bottomNavigationBar: MainFooter(
        currentIndex: 1, // Fix cứng là 1 để icon chỉ số luôn sáng ở trang này
        onTap: (index) {
          if (index == 1) return; // Nếu đang ở trang chỉ số mà bấm lại thì thôi

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

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        underline: const SizedBox(),
        dropdownColor: Colors.white,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
        items: ['Huyết Áp', 'Đường Huyết', 'Cân nặng', 'Sp02']
            .map((val) => DropdownMenuItem(value: val, child: Text(val)))
            .toList(),
        onChanged: (val) => setState(() => selectedValue = val!),
      ),
    );
  }

  void _showAddRecordSheet(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return const ModalAddRecord(); // Gọi class đã tách
      },
    );
  }
}