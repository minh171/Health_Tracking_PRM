import '../../data/models/user_profile.dart';
import '../../interface/repository/isetting_repository.dart';
import '../../interface/service/isetting_service.dart';

class SettingService implements ISettingService {
  final ISettingRepository _repository;

  SettingService(this._repository);

  /// 1. Lấy dữ liệu và chuyển đổi thành Map để ViewModel dễ sử dụng
  @override
  Future<Map<String, double>> getAlertSettingsMap(int accountId) async {
    try {
      final List<Map<String, dynamic>> rawData =
      await _repository.getAlertSettings(accountId);

      // Chuyển đổi List [{key_name: 'sys_max', value: 130}, ...]
      // thành Map {'sys_max': 130.0}
      return {
        for (var item in rawData)
          item['key_name'] as String: (item['value'] as num).toDouble()
      };
    } catch (e) {
      // Log lỗi nếu cần
      return {};
    }
  }

  /// 2. Cập nhật một ngưỡng cụ thể do người dùng chỉnh sửa thủ công
  @override
  Future<bool> updateThreshold(int accountId, String key, double value) async {
    try {
      final result = await _repository.updateAlertSetting(accountId, key, value);
      // Trả về true nếu có ít nhất 1 dòng trong DB được cập nhật
      return result > 0;
    } catch (e) {
      return false;
    }
  }

  /// 3. Khôi phục về ngưỡng mặc định theo logic y khoa
  @override
  Future<bool> resetToDefault(
      int accountId,
      UserProfile profile,
      List<int> diseaseIds,
      ) async {
    try {
      // Chuyển đổi model UserProfile thành Map để tương thích với logic DB cũ
      final Map<String, dynamic> profileMap = profile.toMap();

      // Gọi repository để thực hiện việc tính toán lại (Recalculate)
      // Lưu ý: Repository nên gọi hàm `updateInitialProfile` hoặc logic tương tự
      // mà bạn đã viết trong DatabaseHelper trước đó.
      final result = await _repository.resetThresholdsToDefault(
          accountId,
          profileMap,
          diseaseIds
      );

      return result > 0;
    } catch (e) {
      return false;
    }
  }
}