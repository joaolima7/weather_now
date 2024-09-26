import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:weather_now/domain/entities/custom_notification.dart';
import '../../core/utils/conts.dart';

class NotificationAndroidServiceImp {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;

  NotificationAndroidServiceImp() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupNotifications();
  }

  _setupNotifications() async {
    await _setupTimezone();
    await _initializeNotifications();
  }

  Future<void> _setupTimezone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  _initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await localNotificationsPlugin.initialize(
      const InitializationSettings(android: android),
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        _handleNotificationClick(response.payload);
      },
    );

    _createNotificationChannel();
  }

  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'weather_channel', // id
      'Weather Notifications', // nome
      importance: Importance.high,
      description: 'Canal para notificações do app de clima',
    );

    await localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // Método para exibir uma notificação
  Future<void> showNotification(CustomNotification notification) async {
    androidDetails = const AndroidNotificationDetails(
      'weather_channel', // id do canal
      'Weather Notifications', // nome do canal
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
    );

    final notificationDetails = NotificationDetails(android: androidDetails);
    await localNotificationsPlugin.show(
      notification.id, // id da notificação
      notification.title,
      notification.body,
      notificationDetails,
      payload:
          notification.payload, // Passa o payload para o clique na notificação
    );
  }

  // Método para agendar uma notificação
  Future<void> scheduleNotification(
      String title, String body, DateTime dateTime, String payload) async {
    androidDetails = const AndroidNotificationDetails(
      'weather_channel', // id do canal
      'Weather Notifications', // nome do canal
      importance: Importance.high,
      priority: Priority.high,
    );

    await localNotificationsPlugin.zonedSchedule(
      0, // id da notificação
      title,
      body,
      tz.TZDateTime.from(dateTime, tz.local),
      NotificationDetails(android: androidDetails),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload, // Passa o payload
    );
  }

  // Método para tratar o clique na notificação
  void _handleNotificationClick(String? payload) {
    if (payload != null) {
      navigatorKey.currentState?.pushNamed('/$payload');
    } else {
      navigatorKey.currentState?.pushNamed('/home');
    }
  }
}
