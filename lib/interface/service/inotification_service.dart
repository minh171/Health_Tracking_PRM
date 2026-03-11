abstract class INotificationService {
  Future<List<Map<String, dynamic>>> getFilteredNotifications(
    int accountId, {
    String? level,
    String? type,
  });

  Future<bool> markAsRead(int notificationId);

  // Hàm quan trọng để lấy kết quả ngay sau khi đo
  Future<Map<String, dynamic>?> getResultAfterRecording(int recordId);
}
