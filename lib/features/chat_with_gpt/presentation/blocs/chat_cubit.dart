import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:baza_gibdd_gai/core/network/api_client.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/data/models/message_model.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/data/repositories/api_repository.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/data/request_bodies/chat_request_body.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:baza_gibdd_gai/features/local_notifications/data/models/response_message_model.dart';
import 'package:baza_gibdd_gai/features/local_notifications/main_notification_logic.dart';
import 'package:baza_gibdd_gai/features/local_notifications/presentation/bloc/notification_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class ChatCubit extends Cubit<ChatState> {
  final ApiRepository repository;
  final SharedPreferences preferences;
  ChatCubit({required this.repository, required this.preferences})
      : super(ChatInitialState());

  Future<void> sendMessage(String message) async {
    emit(ChatLoadingState());

    try {
      var userId = preferences.getString('userId');
      var userDialogResponse = await repository.sendMessage(
        ChatRequestBody.sendMessageBody(message, userId),
      );
      var userDialog = userDialogResponse.userDialog;
      if (userDialog != null) {
        if (userId == null) {
          await preferences.setString('userId', userDialog.userId);
        }
        await preferences.setString('dialogId', userDialog.dialogId);
        await preferences.setString('operatorName', userDialog.operatorName);
        emit(ChatReadyState(userDialog));
      } else {
        emit(ChatErrorState(userDialogResponse.error));
      }
    } catch (error) {
      String? message;
      if (error is DioException) {
        message = error.message;
      }
      emit(ChatErrorState(message));
    }
  }

  Future<void> getLastMessage({bool isNotification = false}) async {
    if (!isNotification) emit(ChatLoadingState());
    try {
      var userId = preferences.getString('userId') ?? '';
      var dialogId = preferences.getString('dialogId') ?? '';
      MessagesResponse messagesResponse;
      if (isNotification) {
        userId = preferences.getString('userIdMetrika') ?? '';
        messagesResponse = await repository.getLastMessage(
          ChatRequestBody.getLastMessageBodyNotification(userId),
        );
      } else {
        messagesResponse = await repository.getLastMessage(
          ChatRequestBody.getLastMessageBody(userId, dialogId),
        );
      }
      /*  MessagesResponse messagesResponse = MessagesResponse(
          checkDate: null,
          messages: [
            ResponseMessageModel(
                buttons: [
                  ButtonModel(
                      text: 'text',
                      link:
                          'https://poluchitzaem.mfoshop.ru/?aff_sub5=miczaimpush',
                      type: 'type')
                ],
                isUserMessage: false,
                message: '',
                messageId: '',
                time: DateTime.now().millisecondsSinceEpoch)
          ],
          error: null,
          status: 'done'); */
      if (isNotification) {
        if (!(preferences.getBool('isNotificationsEnabled') ?? true)) return;
        if (messagesResponse.messages.isNotEmpty) {
          var android = AndroidNotificationDetails(
            'chat_id',
            'chat_channel',
            importance: Importance.defaultImportance,
            priority: Priority.defaultPriority,
            showWhen: false,
            styleInformation: BigTextStyleInformation(
              messagesResponse.messages.last.message,
              htmlFormatBigText: true,
              htmlFormatTitle: true,
              htmlFormatContent: true,
              htmlFormatContentTitle: true,
              htmlFormatSummaryText: true,
            ),
          );
          // const iOS = IOSNotificationDetails();
          var details = NotificationDetails(android: android);
          // notifications.show(rnd.nextInt(999999), 'У вас новое сообщение',
          //     messagesResponse.messages.last.message, details);
          var localNotificationBloc = LocalNotificationBloc(
            ApiClient(Dio()),
            preferences,
          );
          localNotificationBloc.add(SaveNotificationToCache(messagesResponse));
          notifications.show(
            Random().nextInt(99999),
            messagesResponse.messages.first.title,
            messagesResponse.messages.first.message,
            details,
            payload: jsonEncode(messagesResponse.toJson()),
          );
        }
      } else {
        if (messagesResponse.status == 'inprogress') {
          await Future.delayed(const Duration(seconds: 5));
          getLastMessage();
        } else if (messagesResponse.error == null) {
          emit(ChatGetLastMessageReadyState(messagesResponse));
          await preferences.remove('dialogId');
        } else {
          emit(ChatErrorState(messagesResponse.error));
        }
      }
    } catch (error) {
      String? message;
      if (error is DioException) {
        message = error.message;
      }
      emit(ChatErrorState(message));
    } finally {
      // BackgroundFetch.scheduleTask(TaskConfig(
      //   taskId: 'chat',
      //   periodic: true,
      //   delay: 15,
      //   requiredNetworkType: NetworkType.ANY,
      // ));
    }
  }
}

sealed class ChatState {}

final class ChatInitialState extends ChatState {}

final class ChatLoadingState extends ChatState {}

final class ChatReadyState extends ChatState {
  final UserDialog userDialog;

  ChatReadyState(this.userDialog);
}

final class ChatGetLastMessageReadyState extends ChatState {
  final MessagesResponse messagesResponse;

  ChatGetLastMessageReadyState(this.messagesResponse);
}

final class ChatErrorState extends ChatState {
  final String? text;

  ChatErrorState([this.text]);
}
