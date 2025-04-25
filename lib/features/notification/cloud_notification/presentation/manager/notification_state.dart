import 'package:sign_lang_app/features/notification/cloud_notification/data/models/notification_model.dart';
/*
abstract class NotificationState {}

class NotificationReceived extends NotificationState {
  final NotificationModel notification;

  NotificationReceived(this.notification);
}

class NotificationInitial extends NotificationState {
  NotificationInitial();
}

// Loading state
class NotificationLoading extends NotificationState {
  NotificationLoading();
}

// Device token states
class DeviceTokenLoading extends NotificationState {
  DeviceTokenLoading();
}

class DeviceTokenLoaded extends NotificationState {
  final String token;
  
  DeviceTokenLoaded(this.token);
}

class DeviceTokenError extends NotificationState {
  final String message;
  
  DeviceTokenError(this.message);
}

// Notification sending states
class NotificationSending extends NotificationState {
  NotificationSending();
}

class NotificationSent extends NotificationState {
  NotificationSent();
}

class NotificationSendError extends NotificationState {
  final String message;
  
  NotificationSendError(this.message);
}


class TopicSubscribing extends NotificationState {
  TopicSubscribing();
}

class TopicSubscribed extends NotificationState {
  final String topic;
  
  TopicSubscribed(this.topic);
}

class TopicSubscribeError extends NotificationState {
  final String message;
  
  TopicSubscribeError(this.message);
}

class TopicUnsubscribing extends NotificationState {
  TopicUnsubscribing();
}

class TopicUnsubscribed extends NotificationState {
  final String topic;
  
  TopicUnsubscribed(this.topic);
}

class TopicUnsubscribeError extends NotificationState {
  final String message;
  
  TopicUnsubscribeError(this.message);
}

*/

class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationTokenLoaded extends NotificationState {
  final String token;

  NotificationTokenLoaded(this.token);
}

class NotificationReceived extends NotificationState {
  final NotificationModel notification;

  NotificationReceived(this.notification);
}

class NotificationSent extends NotificationState {}

class NotificationSubscribed extends NotificationState {
  final String topic;
  NotificationSubscribed(this.topic);
}

class NotificationUnsubscribed extends NotificationState {
  final String topic;
  NotificationUnsubscribed(this.topic);
}

class NotificationError extends NotificationState {
  final String message;
  NotificationError(this.message);
}
