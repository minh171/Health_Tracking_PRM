abstract class INotificationRepository {
  Future<List<Map<String, dynamic>>> getFilteredNotifications(
      int accountId, {String? level, String? type}
      );

  Future<int> markAsRead(int notificationId);
}