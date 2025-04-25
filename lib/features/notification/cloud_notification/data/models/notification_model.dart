import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationModel {
  final String? id;
  final String title;
  final String body;
  final DateTime? sentTime;
  final Map<String, dynamic>? data;

  NotificationModel({
    this.id,
    required this.title,
    required this.body,
    this.sentTime,
    this.data,
  });

  factory NotificationModel.fromRemoteMessage(RemoteMessage message) {
    return NotificationModel(
      id: message.messageId,
      title: message.notification?.title ?? 'No title',
      body: message.notification?.body ?? 'No body',
      sentTime: message.sentTime,
      data: message.data,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'sentTime': sentTime?.toIso8601String(),
      'data': data,
    };
  }
}
