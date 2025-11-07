import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:baza_gibdd_gai/features/local_notifications/data/models/response_message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatWorker {
  static final prefs = GetIt.I<SharedPreferences>();

  static List<ResponseMessageModel> getChatHistory() {
    List<String> jsons = prefs.getStringList('historyMessage') ?? [];
    List<ResponseMessageModel> messages = [];
    for (var json in jsons) {
      messages.add(ResponseMessageModel.fromJson(jsonDecode(json)));
    }

    return messages;
  }

  static List<ResponseMessageModel> getFavouritesMessages() {
    List<String> jsons = prefs.getStringList('favourites_messages') ?? [];
    List<ResponseMessageModel> messages = [];
    for (var json in jsons) {
      messages.add(ResponseMessageModel.fromJson(jsonDecode(json)));
    }
    return messages;
  }

  static Future saveMessageToFavourites(ResponseMessageModel message) async {
    List<String> jsons = prefs.getStringList('favourites_messages') ?? [];
    List<ResponseMessageModel> messages = [];
    for (var json in jsons) {
      messages.add(ResponseMessageModel.fromJson(jsonDecode(json)));
    }

    if (messages
        .where((messageLocal) => messageLocal.messageId == message.messageId)
        .isEmpty) {
      messages.add(message);
    }

    await prefs.setStringList(
      'favourites_messages',
      messages.map((message) => jsonEncode(message.toJson())).toList(),
    );
  }

  static bool isInFavourites(ResponseMessageModel message) {
    List<String> jsons = prefs.getStringList('favourites_messages') ?? [];

    return jsons.contains(jsonEncode(message.toJson()));
  }

  static Future removeMessageFromFavourites(
    ResponseMessageModel message,
  ) async {
    List<String> jsons = prefs.getStringList('favourites_messages') ?? [];
    List<ResponseMessageModel> messages = [];
    for (var json in jsons) {
      messages.add(ResponseMessageModel.fromJson(jsonDecode(json)));
    }

    messages.removeWhere(
      (messageLocal) => messageLocal.messageId == message.messageId,
    );

    await prefs.setStringList(
      'favourites_messages',
      messages.map((message) => jsonEncode(message.toJson())).toList(),
    );
  }

  static Future<void> eraseFavourites() async {
    await prefs.remove('favouriteMessages');
  }

  static Future<void> saveChatHistory(
    List<ResponseMessageModel> messages,
  ) async {
    try {
      List<String> messageJson = List.generate(messages.length, (index) {
        return jsonEncode(messages[index].toJson());
      });
      prefs.getStringList('historyMessage');
      await prefs.setStringList('historyMessage', messageJson);
    } catch (e) {
      print(e);
    }
  }

  static Map<String, List<ResponseMessageModel>> groupMessagesByDay(
    List<ResponseMessageModel> messages,
  ) {
    messages.sort((a, b) => a.time.compareTo(b.time));
    return groupBy(messages, (msg) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(msg.time);
      return DateFormat(
        'dd.MM.yyyy',
      ).format(date); // Форматируем в строку "YYYY-MM-DD"
    });
  }

  static List<ResponseMessageModel> filterAndSortMessages(
    List<ResponseMessageModel> messages,
    String query,
  ) {
    query = query
        .toLowerCase(); // Приводим к нижнему регистру для нечувствительности к регистру

    return messages
        .where((msg) => msg.message.toLowerCase().contains(query)) // Фильтруем
        .toList()
      ..sort(
        (a, b) => a.message.toLowerCase().compareTo(b.message.toLowerCase()),
      ); // Сортируем
  }

  static Widget dateTitle(String data) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      width: double.infinity,
      color: Colors.white,
      child: Text(
        data,
        style: TextStyles.h2.copyWith(
          color: Colors.black.withValues(alpha: 0.5),
          fontWeight: FontWeight.w700,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
