import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Thêm provider
import '../../viewmodels/login_vm.dart';
import '../../viewmodels/profile_vm.dart'; // Import ProfileViewModel
import 'edit_basic_info_modal.dart';

class BasicInfoCard extends StatelessWidget {
  const BasicInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final loginVM = context.read<LoginViewModel>();
    final profileVM = context.watch<ProfileViewModel>();
    final profile = profileVM.userProfile;
    final bool hasData = profile?.height != null && profile!.height! > 0;

    // Tự động load nếu chưa có dữ liệu (Lazy Loading)
    if (profile == null && !profileVM.isLoading) {
      final accountId = loginVM.currentAccount?.id;
      if (accountId != null) {
        // Sử dụng Future.microtask để tránh lỗi "setState() or markNeedsBuild() called during build"
        Future.microtask(() => profileVM.fetchProfile(accountId));
      }
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Phần nhãn bên trái
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFEA916E),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Chỉ số cơ bản',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Phần nội dung bên phải
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Tính tuổi từ chuỗi dob (giả sử định dạng yyyy-MM-dd)
                      _buildInfoText("Tuổi: ${_calculateAge(profile?.dob)}"),

                      // 2. Giới tính
                      _buildInfoText(
                        "Giới tính: ${profileVM.getDisplayValue(profile?.gender)}",
                      ),

                      // 3. Chiều cao
                      _buildInfoText(
                        "Chiều cao: ${profileVM.getDisplayValue(profile?.height?.toInt().toString(), unit: " cm")}",
                      ),

                      // 4. Cân nặng
                      _buildInfoText(
                        "Cân nặng: ${profileVM.getDisplayValue(profile?.weight, unit: " kg")}",
                      ),

                      // 5. Tình trạng (Bệnh nền) - Dùng Row + Expanded để xuống dòng
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Tình trạng: ",
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          ),
                          Expanded(
                            child: Text(
                              profileVM
                                  .getDiseasesDisplay(), // Hàm lấy danh sách bệnh đã nối chuỗi
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                              softWrap: true, // Tự động xuống dòng
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),


                  // Kiểm tra xem đã có dữ liệu chưa (Ví dụ dựa vào chiều cao)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: hasData
                          ? () {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) =>
                                    const EditBasicInfoModal(),
                              );
                            }
                          : null, // Vô hiệu hóa khi không có data
                      child: Icon(
                        Icons.edit,
                        color: hasData
                            ? const Color(0xFF379AE6)
                            : Colors.grey, // Đổi màu xám nếu disable
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _calculateAge(String? dob) {
    if (dob == null || dob.isEmpty || dob == "Chưa có") return "N/A";

    try {
      DateTime birthDate;

      // Kiểm tra nếu chuỗi có định dạng DD/MM/YYYY
      if (dob.contains('/')) {
        List<String> parts = dob.split('/');
        if (parts.length == 3) {
          // Chuyển từ DD/MM/YYYY sang YYYY-MM-DD để parse
          int day = int.parse(parts[0]);
          int month = int.parse(parts[1]);
          int year = int.parse(parts[2]);
          birthDate = DateTime(year, month, day);
        } else {
          return "N/A";
        }
      } else {
        // Nếu là định dạng chuẩn YYYY-MM-DD
        birthDate = DateTime.parse(dob);
      }

      DateTime today = DateTime.now();
      int age = today.year - birthDate.year;

      // Kiểm tra xem đã đến sinh nhật năm nay chưa
      if (today.month < birthDate.month ||
          (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }

      return age < 0 ? "0" : age.toString();
    } catch (e) {
      debugPrint("Lỗi tính tuổi với chuỗi '$dob': $e");
      return "N/A";
    }
  }

  Widget _buildInfoText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black, fontSize: 13),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
