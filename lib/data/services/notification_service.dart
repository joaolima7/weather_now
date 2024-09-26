import 'package:weather_now/domain/entities/custom_notification.dart';

abstract class NotificationService {
  Future<void> sendNotification(CustomNotification notification);
}
