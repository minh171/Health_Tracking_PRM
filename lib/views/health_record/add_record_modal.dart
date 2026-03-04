import 'package:flutter/material.dart';

class ModalAddRecord extends StatefulWidget {
  const ModalAddRecord({super.key});

  @override
  State<ModalAddRecord> createState() => _ModalAddRecordState();
}

class _ModalAddRecordState extends State<ModalAddRecord> {
  // Đồng bộ giá trị với dropdown ở màn hình chính nếu cần, ở đây mặc định là Huyết áp
  String selectedType = 'Huyết áp';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- PHẦN TIÊU ĐỀ ---
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const Text(
                      'Thêm bản ghi mới',
                      style: TextStyle(
                        color: Color(0xFF379AE6),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 1, thickness: 1),
                const SizedBox(height: 20),

                // --- LOẠI CHỈ SỐ ---
                const Text(
                  'Loại chỉ số',
                  style: TextStyle(color: Color(0xFF334155), fontSize: 14),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedType,
                      dropdownColor: Colors.white,
                      items: ['Huyết áp', 'Đường huyết', 'Cân nặng', 'Sp02']
                          .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedType = val!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // --- PHẦN THAY ĐỔI THEO LOẠI CHỈ SỐ ---
                _buildDynamicFields(),

                const SizedBox(height: 16),

                // --- THỜI ĐIỂM ĐO ---
                const Text('Thời điểm đo',
                    style: TextStyle(color: Color(0xFF334155), fontSize: 14)),
                const SizedBox(height: 8),
                TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Chọn ngày giờ',
                    suffixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  onTap: () {
                    // Xử lý chọn ngày giờ
                  },
                ),
                const SizedBox(height: 16),

                // --- GHI CHÚ ---
                const Text('Ghi chú (tùy chọn)',
                    style: TextStyle(color: Color(0xFF334155), fontSize: 14)),
                const SizedBox(height: 8),
                TextField(
                  maxLines: 2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 24),

                // --- PHẦN NÚT BẤM ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      child: const Text('Hủy', style: TextStyle(color: Colors.black)),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        // Xử lý lưu dữ liệu
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3C83F6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text('Lưu', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Hàm xử lý hiển thị các ô nhập liệu khác nhau
  Widget _buildDynamicFields() {
    if (selectedType == 'Huyết áp') {
      return Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tâm thu (mmHg)',
                    style: TextStyle(color: Color(0xFF334155), fontSize: 12)),
                const SizedBox(height: 8),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tâm trương (mmHg)',
                    style: TextStyle(color: Color(0xFF334155), fontSize: 12)),
                const SizedBox(height: 8),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      // Xử lý cho Đường huyết, Cân nặng, SpO2 (Chỉ có 1 ô nhập giá trị)
      String label = "";
      switch (selectedType) {
        case 'Đường huyết':
          label = "Giá trị (mg/dL)";
          break;
        case 'Cân nặng':
          label = "Giá trị (kg)";
          break;
        case 'Sp02':
          label = "Giá trị (%)";
          break;
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF334155), fontSize: 14)),
          const SizedBox(height: 8),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ],
      );
    }
  }
}