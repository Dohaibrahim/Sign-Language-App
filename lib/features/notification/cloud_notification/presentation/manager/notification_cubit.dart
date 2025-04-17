import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_lang_app/features/notification/cloud_notification/data/models/notification_model.dart';
import 'package:sign_lang_app/features/notification/cloud_notification/domain/repo/notification_repo.dart';
import 'package:sign_lang_app/features/notification/cloud_notification/presentation/manager/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepoImpl repository;

  NotificationCubit(this.repository) : super(NotificationInitial());

  Future<void> getDeviceToken() async {
    emit(NotificationLoading());

    final result = await repository.getDeviceToken();

    result.fold(
      (failure) => emit(NotificationError(failure.message)),
      (token) => emit(NotificationTokenLoaded(token)),
    );
  }

  Future<void> sendNotification(NotificationModel notification) async {
    emit(NotificationLoading());
    final result = await repository.sendNotification(notification);
    result.fold(
      (failure) => emit(NotificationError(failure.message)),
      (_) => emit(NotificationSent()),
    );
  }

  Future<void> subscribeToTopic(String topic) async {
    emit(NotificationLoading());
    try {
      await repository.subscribeToTopic(topic);
      emit(NotificationSubscribed(topic));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    emit(NotificationLoading());
    try {
      await repository.unsubscribeFromTopic(topic);
      emit(NotificationUnsubscribed(topic));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  void listenToNotifications() {
    repository.getNotificationStream().listen((notification) {
      emit(NotificationReceived(notification));
    });
  }

  Future<void> triggerDailyNotification() async {
    await checkAndSendDailyNotification();
  }

  Future<void> checkAndSendDailyNotification() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final lastSent =
        DateTime.tryParse(prefs.getString('last_notification_sent') ?? '');

    if (lastSent == null || now.difference(lastSent).inHours >= 24) {
      final notification = NotificationModel(
        title: 'Daily Update!',
        body: 'Check out what’s new today!',
        sentTime: DateTime.now(),
      );
      await sendNotification(notification);
      await prefs.setString('last_notification_sent', now.toIso8601String());
    }
  }
}
