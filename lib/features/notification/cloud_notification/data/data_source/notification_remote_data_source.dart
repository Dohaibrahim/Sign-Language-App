import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sign_lang_app/core/di/dependency_injection.dart';
import 'package:sign_lang_app/core/errors/failure.dart';
import 'package:sign_lang_app/features/notification/cloud_notification/data/models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<Either<Failure, String>> getDeviceToken();
  Future<Either<Failure, Response<dynamic>>> sendNotification(
      NotificationModel notification);
  Future<void> subscribeToTopic(String topic);
  Future<void> unsubscribeFromTopic(String topic);
  Stream<NotificationModel> getNotificationStream();
  Future<void> initFirebase();
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final Dio dio = getIt<Dio>();
  final String? serverKey;
  NotificationRemoteDataSourceImpl({
    this.serverKey,
  }) {
    initFirebase();
  }

  @override
  Future<Either<Failure, String>> getDeviceToken() async {
    String? token = await firebaseMessaging.getToken();
    if (token != null) {
      return Right(token);
    } else {
      return Left(Failure('Failed to get device token'));
    }
  }

  @override
  Stream<NotificationModel> getNotificationStream() {
    return FirebaseMessaging.onMessage.map((remoteMessage) {
      return NotificationModel.fromRemoteMessage(remoteMessage);
    });
  }

  @override
  Future<Either<Failure, Response<dynamic>>> sendNotification(
      NotificationModel notification) async {
    try {
      final token = await getDeviceToken();

      final response = await dio.post(
        'https://fcm.googleapis.com/fcm/send',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'key=$serverKey',
          },
        ),
        data: {
          'notification': {
            'title': notification.title,
            'body': notification.body,
          },
          'data': notification.data,
          'to': token,
        },
      );
      return Right(response);
    } on DioException {
      return Left(Failure('dio failed'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<void> subscribeToTopic(String topic) async {
    await firebaseMessaging.subscribeToTopic(topic);
  }

  @override
  Future<void> unsubscribeFromTopic(String topic) async {
    await firebaseMessaging.unsubscribeFromTopic(topic);
  }

  @override
  Future<void> initFirebase() async {
    await firebaseMessaging.requestPermission();
    final fcmToken = await firebaseMessaging.getToken();
    log('token : $fcmToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    initPushNotifications();
  }

  Future<void> handleBackgroundMessage(RemoteMessage remoteMessage) async {
    log('notification title : ${remoteMessage.notification?.title}');
    log('notification body : ${remoteMessage.notification?.body}');
    log('message data : ${remoteMessage.data}');
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    //todo : navigate to the notification screen
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
