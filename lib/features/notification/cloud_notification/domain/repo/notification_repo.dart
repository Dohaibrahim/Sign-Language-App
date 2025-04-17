import 'package:dartz/dartz.dart';
import 'package:dio/src/response.dart';
import 'package:sign_lang_app/core/errors/failure.dart';
import 'package:sign_lang_app/features/notification/cloud_notification/data/data_source/notification_remote_data_source.dart';
import 'package:sign_lang_app/features/notification/cloud_notification/data/models/notification_model.dart';

class NotificationRepoImpl {
  final NotificationRemoteDataSource notificationRemoteDataSource;
  NotificationRepoImpl({required this.notificationRemoteDataSource});

  Future<Either<Failure, String>> getDeviceToken() {
    return notificationRemoteDataSource.getDeviceToken();
  }

  Stream<NotificationModel> getNotificationStream() {
    return notificationRemoteDataSource.getNotificationStream();
  }

  Future<Either<Failure, Response>> sendNotification(
      NotificationModel notification) {
    return notificationRemoteDataSource.sendNotification(notification);
  }

  Future<void> subscribeToTopic(String topic) {
    return notificationRemoteDataSource.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) {
    return notificationRemoteDataSource.unsubscribeFromTopic(topic);
  }
}
