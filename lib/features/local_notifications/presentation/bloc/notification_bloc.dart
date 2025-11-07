import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:baza_gibdd_gai/core/network/api_client.dart';
import 'package:baza_gibdd_gai/features/local_notifications/data/models/response_message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// BLOC
@singleton
class LocalNotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final ApiClient apiClient;
  final SharedPreferences preferences;
  bool isDialogVisible = false;
  LocalNotificationBloc(this.apiClient, this.preferences)
      : super(NotificationInitial()) {
    on<GetBackgroundNotifications>(_onGetBackgroundNotifications);
    on<SaveNotificationToCache>(_onSaveNotificationToCache);
    on<RemoveNotificationFromCache>(_onRemoveNotificationFromCache);
    on<GetNotificationFromCache>(_onGetNotificationFromCache);
    on<ClearNotifications>(_onClearNotificationsCache);
  }

  Future<void> _onClearNotificationsCache(
    ClearNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await preferences.remove('local_notifications');
      add(GetNotificationFromCache());
    } catch (error) {
      emit(NotificationError());
    }
  }

  Future<void> _onGetBackgroundNotifications(
    GetBackgroundNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await apiClient.getBackgroundNotification();
    } catch (error) {
      emit(NotificationError());
    }
  }

  Future<void> _onRemoveNotificationFromCache(
    RemoveNotificationFromCache event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      var notificationsList =
          preferences.getStringList('local_notifications') ?? [];
      notificationsList.removeWhere(
        (item) =>
            MessagesResponse.fromJson(jsonDecode(item)).messages.first.time ==
            event.messagesResponse.messages.first.time,
      );
      await preferences.setStringList('local_notifications', notificationsList);
      add(GetNotificationFromCache());
    } catch (error) {
      emit(NotificationError());
    }
  }

  Future<void> _onSaveNotificationToCache(
    SaveNotificationToCache event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      var notificationsList =
          preferences.getStringList('local_notifications') ?? [];
      notificationsList.add(jsonEncode(event.messagesResponse.toJson()));
      await preferences.setStringList('local_notifications', notificationsList);
      add(GetNotificationFromCache());
    } catch (error) {
      emit(NotificationError());
    }
  }

  Future<void> _onGetNotificationFromCache(
    GetNotificationFromCache event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      var notificationsList =
          preferences.getStringList('local_notifications') ?? [];
      if (notificationsList.isEmpty) {
        emit(NotificationLoadedSuccessfull([]));
      } else {
        List<MessagesResponse> messageResponses = [];
        for (var item in notificationsList) {
          var jsonMap = jsonDecode(item);
          messageResponses.add(MessagesResponse.fromJson(jsonMap));
        }
        emit(NotificationLoadedSuccessfull(messageResponses));
      }
    } catch (error) {
      emit(NotificationError());
    }
  }
}

// EVENTS
abstract class NotificationEvent {}

class GetBackgroundNotifications extends NotificationEvent {}

class SaveNotificationToCache extends NotificationEvent {
  MessagesResponse messagesResponse;
  SaveNotificationToCache(this.messagesResponse);
}

class RemoveNotificationFromCache extends NotificationEvent {
  MessagesResponse messagesResponse;
  RemoveNotificationFromCache(this.messagesResponse);
}

class EditNotificationToCache extends NotificationEvent {
  MessagesResponse messagesResponse;
  EditNotificationToCache(this.messagesResponse);
}

class GetNotificationFromCache extends NotificationEvent {}

class ClearNotifications extends NotificationEvent {}

// STATES
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationError extends NotificationState {}

class NotificationLoadedSuccessfull extends NotificationState {
  List<MessagesResponse> messageResponses;
  NotificationLoadedSuccessfull(this.messageResponses);
}
