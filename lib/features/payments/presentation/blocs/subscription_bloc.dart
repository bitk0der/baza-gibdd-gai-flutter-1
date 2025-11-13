import 'dart:convert';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:baza_gibdd_gai/features/local_notifications/main_notification_logic.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/payments/fssp_trial.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/payments/payment.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/subscription.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/user_data.dart';
import 'package:baza_gibdd_gai/features/payments/data/repositories/search_repository.dart';
import 'package:baza_gibdd_gai/features/payments/data/repositories/storage_repository.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class SubscriptionBloc
    extends Bloc<SubscriptionBlocEvent, SubscriptionBlocState> {
  SubscriptionBloc({
    required this.searchRepository,
    required this.storageRepository,
  }) : super(SubscriptionBlocInitialState()) {
    // Регистрация обработчиков событий
    on<SubscriptionBlocInitialEvent>(_onInitialEvent);
    on<SubscriptionBlocSubscribeEvent>(_onSubscribeEvent);
    on<SubscriptionBlocUnsubscribeEvent>(_onUnsubscribeEvent);
    on<SubscriptionBlocUnsubscribeAllEvent>(_onUnsubscribeAllEvent);
    on<SubscriptionBlocSearchEvent>(_onSearchEvent);
    on<SubscriptionBlocNotShowDialogEvent>(_onNotShowDialogEvent);
    add(SubscriptionBlocInitialEvent());
  }

  final SearchRepository searchRepository;
  final StorageRepository storageRepository;

  bool showSubscriptionDialog = true;

  Future<void> _onInitialEvent(SubscriptionBlocInitialEvent event,
      Emitter<SubscriptionBlocState> emit) async {
    List<Subscription> subscriptions = [];
    try {
      subscriptions = await storageRepository.loadSubscriptions();
    } catch (e) {
      Logger().e(e);
    }
    emit(SubscriptionBlocReadyState(subscriptions));
  }

  Future<void> _onSubscribeEvent(SubscriptionBlocSubscribeEvent event,
      Emitter<SubscriptionBlocState> emit) async {
    List<Subscription> subscriptions = [];
    try {
      subscriptions = await storageRepository.loadSubscriptions();
    } catch (e) {
      Logger().e(e);
    }
    bool isNew = true;
    for (int i = 0; i < subscriptions.length; i++) {
      if (event.request == subscriptions[i].userData &&
          event.type == subscriptions[i].type) {
        isNew = false;
        break;
      }
    }
    if (isNew) {
      List payments = [];
      try {
        Map<String, dynamic> result = {};
        if (event.type != SubscriptionType.fsspTrials) {
          result = await searchRepository.search(event.request, event.type);
        } else {
          payments = await searchRepository.searchFssp(event.request);
        }
        switch (event.type) {
          case SubscriptionType.taxes:
            payments = result["taxes"];
            break;
          case SubscriptionType.trials:
            payments = result["trials"];
            break;
          case SubscriptionType.fines:
            payments = result["fines"];
            break;
          case SubscriptionType.fsspTrials:
            break;
        }
      } catch (e) {
        Logger().e(e);
      } finally {
        /* if (subscriptions.isEmpty) {
          BackgroundFetch.scheduleTask(TaskConfig(
            taskId: 'subscription',
            periodic: true,
            delay: 15,
            requiredNetworkType: NetworkType.ANY,
          ));
        } */
        final subscription = Subscription(
          paymentsNumbers: List.generate(
            payments.length,
            (i) {
              final payment = payments[i];
              if (payment is Payment) {
                return payment.number!;
              } else if (payment is FsspTrial) {
                return payment.ip;
              } else {
                return '';
              }
            },
          ),
          userData: event.request,
          type: event.type,
        );
        subscriptions.add(subscription);
        storageRepository.saveSubscriptions(subscriptions: subscriptions);
        emit(SubscriptionBlocReadyState(subscriptions));
      }
    }
  }

  Future<void> _onUnsubscribeEvent(SubscriptionBlocUnsubscribeEvent event,
      Emitter<SubscriptionBlocState> emit) async {
    List<Subscription> subscriptions = [];
    try {
      subscriptions = await storageRepository.loadSubscriptions();
    } catch (e) {
      Logger().e(e);
    }
    bool isSaved = false;
    for (int i = 0; i < subscriptions.length; i++) {
      if (event.subscription.userData == subscriptions[i].userData &&
          event.subscription.type == subscriptions[i].type) {
        isSaved = true;
        break;
      }
    }
    if (isSaved) {
      subscriptions.removeWhere(
          (element) => element.userData == event.subscription.userData);
      await storageRepository.saveSubscriptions(subscriptions: subscriptions);
      /*  if (subscriptions.isEmpty) {
        BackgroundFetch.stop('subscription');
      } */
      emit(SubscriptionBlocReadyState(subscriptions));
    }
  }

  Future<void> _onUnsubscribeAllEvent(SubscriptionBlocUnsubscribeAllEvent event,
      Emitter<SubscriptionBlocState> emit) async {
    await storageRepository.saveSubscriptions(subscriptions: []);
    /*  BackgroundFetch.stop('subscription'); */
    emit(SubscriptionBlocReadyState([]));
  }

  Future<void> _onSearchEvent(SubscriptionBlocSearchEvent event,
      Emitter<SubscriptionBlocState> emit) async {
    List<Subscription> subscriptions = [];
    try {
      subscriptions = await storageRepository.loadSubscriptions();
    } catch (e) {
      Logger().e(e);
    }
    bool isSubscribed = false;
    for (int i = 0; i < subscriptions.length; i++) {
      if (subscriptions[i].userData.toString() == event.request.toString() &&
          subscriptions[i].type == event.type) {
        isSubscribed = true;
        if (subscriptions[i].haveNewPayments) {
          subscriptions[i] = subscriptions[i].copyWith(haveNewPayments: false);
          await storageRepository.saveSubscriptions(
              subscriptions: subscriptions);
          emit(SubscriptionBlocReadyState(subscriptions));
        }
        break;
      }
    }
    if (!isSubscribed) {
      final showDialog = await storageRepository.isShowSubscriptionDialog();
      emit(SubscriptionBlocReadyState(subscriptions));
      emit(SubscriptionBlocShowButtonState(subscriptions, showDialog));
    }
  }

  Future<void> _onNotShowDialogEvent(SubscriptionBlocNotShowDialogEvent event,
      Emitter<SubscriptionBlocState> emit) async {
    storageRepository.setShowSubscriptionDialog(false);
  }

  Future<void> checkUpdates(SharedPreferences preferences) async {
    List<Subscription> subscriptions = [];
    if (!(preferences.getBool('isNotificationsEnabled') ?? true)) return;
    try {
      subscriptions = await storageRepository.loadSubscriptions();
    } catch (e) {
      Logger().e(e);
    }
    List<Subscription> updatedSubscriptions = [];
    for (var subscription in subscriptions) {
      List payments = [];
      try {
        Map<String, dynamic> result = {};
        if (subscription.type != SubscriptionType.fsspTrials) {
          result = await searchRepository.search(
              subscription.userData, subscription.type);
        } else {
          payments = await searchRepository.searchFssp(subscription.userData);
        }
        switch (subscription.type) {
          case SubscriptionType.taxes:
            payments = result["taxes"];
            break;
          case SubscriptionType.trials:
            payments = result["trials"];
            break;
          case SubscriptionType.fines:
            payments = result["fines"];
            break;
          default:
            break;
        }
      } catch (e) {
        Logger().e(e);
      }
      bool haveNewPayments = false;
      if (subscription.hash != null) {
        haveNewPayments = _compareWithHash(subscription, payments);
      } else {
        haveNewPayments = _compareWithPaymentsNumbers(subscription, payments);
      }
      List<String> paymentsNumbers = List.generate(
        payments.length,
        (i) {
          final payment = payments[i];
          if (payment is Payment) {
            return payment.number!;
          } else if (payment is FsspTrial) {
            return payment.ip;
          } else {
            return '';
          }
        },
      );
      updatedSubscriptions.add(subscription.copyWith(
        paymentsNumbers: paymentsNumbers,
        haveNewPayments: haveNewPayments,
      ));
    }
    storageRepository.saveSubscriptions(subscriptions: updatedSubscriptions);
  }

  bool _compareWithHash(Subscription subscription, List payments) {
    String hash;
    if (subscription.type != SubscriptionType.fsspTrials) {
      hash = _generateHash(List.from(payments));
    } else {
      hash = _generateFsspHash(List.from(payments));
    }
    if (subscription.hash != hash) {
      const android = AndroidNotificationDetails(
        'subscriptions',
        'subscriptions_channel',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
      );
      const details = NotificationDetails(android: android);
      notifications.show(
        Random().nextInt(999999),
        'У вас новая задолженность',
        _generateMessageBody(subscription.userData, subscription.type),
        details,
        payload: "${subscription.typeToString()}@${subscription.userData}",
      );
      return true;
    } else {
      return false;
    }
  }

  bool _compareWithPaymentsNumbers(Subscription subscription, List payments) {
    List<String> newPaymentsNumbers = [];
    newPaymentsNumbers = List.generate(
      payments.length,
      (i) {
        final payment = payments[i];
        if (payment is Payment) {
          return payment.number!;
        } else if (payment is FsspTrial) {
          return payment.ip;
        } else {
          return '';
        }
      },
    );
    for (var oldPaymentNumber in subscription.paymentsNumbers) {
      newPaymentsNumbers.remove(oldPaymentNumber);
    }
    if (newPaymentsNumbers.isNotEmpty) {
      const android = AndroidNotificationDetails(
        'subscriptions_id',
        'subscriptions_channel2',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
      );

      const details = NotificationDetails(android: android);
      notifications.show(
        Random().nextInt(999999),
        'У вас новая задолженность',
        _generateMessageBody(subscription.userData, subscription.type),
        details,
        payload: "${subscription.typeToString()}@${subscription.userData}",
      );
      return true;
    } else {
      return false;
    }
  }

  String _generateHash(List<Payment> responses) {
    String hash = '';
    for (var element in responses) {
      hash += element.number!;
    }
    return md5.convert(utf8.encode(hash)).toString();
  }

  String _generateFsspHash(List<FsspTrial> responses) {
    String hash = '';
    for (var element in responses) {
      hash += element.ip;
    }
    return md5.convert(utf8.encode(hash)).toString();
  }

  String _generateMessageBody(UserData request, SubscriptionType type) {
    String body = '';
    switch (type) {
      case SubscriptionType.taxes:
        body += 'Налоговая задолженность\n';
        break;
      case SubscriptionType.trials:
        body += 'Судебная задолженность\n';
        break;
      case SubscriptionType.fines:
        body += 'Штрафы ГИБДД\n';
        break;
      case SubscriptionType.fsspTrials:
        body += 'Судебная задолженность\n';
        break;
    }
    if (request.passport != null && request.passport!.isNotEmpty) {
      body += 'Номер паспорта: ${request.passport!}\n';
    } else if (request.snils != null && request.snils!.isNotEmpty) {
      body += 'СНИЛС: ${request.snils!}\n';
    } else if (request.inn != null && request.inn!.isNotEmpty) {
      body += 'ИНН: ${request.inn!}\n';
    } else if (request.vy != null && request.vy!.isNotEmpty) {
      body += 'Водительское удостоверение: ${request.vy!}\n';
    } else if (request.sts != null && request.sts!.isNotEmpty) {
      body += 'СТС: ${request.sts!}\n';
    } else if (request.birthCertificate != null &&
        request.birthCertificate!.isNotEmpty) {
      body += 'Свидетельство о рождении: ${request.birthCertificate!}\n';
    } else if (request.lastName != null && request.lastName!.isNotEmpty) {
      body += 'Фамилия: ${request.lastName!}\n';
    } else if (request.firstName != null && request.firstName!.isNotEmpty) {
      body += 'Имя: ${request.firstName!}\n';
    } else if (request.secondName != null && request.secondName!.isNotEmpty) {
      body += 'Отчетсво: ${request.secondName!}\n';
    } else if (request.region != null && request.region!.isNotEmpty) {
      body += 'Регион: ${request.region!}\n';
    }
    return body;
  }
}

abstract class SubscriptionBlocEvent {}

class SubscriptionBlocInitialEvent extends SubscriptionBlocEvent {}

class SubscriptionBlocSubscribeEvent extends SubscriptionBlocEvent {
  final UserData request;
  final SubscriptionType type;

  SubscriptionBlocSubscribeEvent({
    required this.request,
    required this.type,
  });
}

class SubscriptionBlocUnsubscribeEvent extends SubscriptionBlocEvent {
  final Subscription subscription;

  SubscriptionBlocUnsubscribeEvent({required this.subscription});
}

class SubscriptionBlocUnsubscribeAllEvent extends SubscriptionBlocEvent {}

class SubscriptionBlocSearchEvent extends SubscriptionBlocEvent {
  final UserData request;
  final SubscriptionType type;

  SubscriptionBlocSearchEvent({
    required this.request,
    required this.type,
  });
}

class SubscriptionBlocNotShowDialogEvent extends SubscriptionBlocEvent {}

abstract class SubscriptionBlocState {}

class SubscriptionBlocInitialState extends SubscriptionBlocState {}

class SubscriptionBlocReadyState extends SubscriptionBlocState {
  final List<Subscription> subscriptions;

  SubscriptionBlocReadyState(this.subscriptions);
}

class SubscriptionBlocShowButtonState extends SubscriptionBlocState {
  final List<Subscription> subscriptions;
  final bool showDialog;

  SubscriptionBlocShowButtonState(this.subscriptions, this.showDialog);
}
