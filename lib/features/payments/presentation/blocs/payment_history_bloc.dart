import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:baza_gibdd_gai/features/payments/data/repositories/storage_repository.dart';

@singleton
class PaymentHistoryBloc
    extends Bloc<PaymentHistoryBlocEvent, PaymentHistoryBlocState> {
  final StorageRepository storageRepository;

  PaymentHistoryBloc(this.storageRepository)
      : super(PaymentHistoryBlocInitialState()) {
    // Регистрация обработчиков событий
    on<PaymentHistoryBlocSaveEvent>(_onSaveEvent);
    on<PaymentHistoryBlocLoadEvent>(_onLoadEvent);
    on<PaymentHistoryBlocDeleteEvent>(_onDeleteEvent);
    on<PaymentHistoryBlocDeleteAllEvent>(_onDeleteAllEvent);
    add(PaymentHistoryBlocLoadEvent());
  }

  List<String> invoicesIdList = [];

  Future<void> _onSaveEvent(PaymentHistoryBlocSaveEvent event,
      Emitter<PaymentHistoryBlocState> emit) async {
    bool isNew = true;
    for (int i = 0; i < invoicesIdList.length; i++) {
      if (event.invoiceId == invoicesIdList[i]) {
        isNew = false;
        break;
      }
    }
    if (isNew) {
      invoicesIdList.add(event.invoiceId);
      await storageRepository.savePaymentHistory(history: invoicesIdList);
      emit(PaymentHistoryBlocSavedState(invoicesIdList));
      emit(PaymentHistoryBlocReadyState(invoicesIdList));
    }
  }

  Future<void> _onLoadEvent(PaymentHistoryBlocLoadEvent event,
      Emitter<PaymentHistoryBlocState> emit) async {
    final result = await storageRepository.loadPaymentHistory();
    invoicesIdList = result;
    emit(PaymentHistoryBlocReadyState(result));
  }

  Future<void> _onDeleteEvent(PaymentHistoryBlocDeleteEvent event,
      Emitter<PaymentHistoryBlocState> emit) async {
    invoicesIdList.removeWhere((element) => element == event.invoiceId);
    await storageRepository.savePaymentHistory(history: invoicesIdList);
    emit(PaymentHistoryBlocDeletedState(event.invoiceId));
    emit(PaymentHistoryBlocReadyState(invoicesIdList));
  }

  Future<void> _onDeleteAllEvent(PaymentHistoryBlocDeleteAllEvent event,
      Emitter<PaymentHistoryBlocState> emit) async {
    invoicesIdList = [];
    await storageRepository.savePaymentHistory(history: invoicesIdList);
    emit(PaymentHistoryBlocReadyState(invoicesIdList));
  }
}

abstract class PaymentHistoryBlocEvent {}

class PaymentHistoryBlocSaveEvent extends PaymentHistoryBlocEvent {
  final String invoiceId;

  PaymentHistoryBlocSaveEvent(this.invoiceId);
}

class PaymentHistoryBlocDeleteEvent extends PaymentHistoryBlocEvent {
  final String invoiceId;

  PaymentHistoryBlocDeleteEvent(this.invoiceId);
}

class PaymentHistoryBlocDeleteAllEvent extends PaymentHistoryBlocEvent {}

class PaymentHistoryBlocLoadEvent extends PaymentHistoryBlocEvent {}

abstract class PaymentHistoryBlocState {}

class PaymentHistoryBlocInitialState extends PaymentHistoryBlocState {}

class PaymentHistoryBlocSavedState extends PaymentHistoryBlocState {
  final List<String> invoicesIdList;

  PaymentHistoryBlocSavedState(this.invoicesIdList);
}

class PaymentHistoryBlocDeletedState extends PaymentHistoryBlocState {
  final String invoiceId;

  PaymentHistoryBlocDeletedState(this.invoiceId);
}

class PaymentHistoryBlocReadyState extends PaymentHistoryBlocState {
  final List<String> invoicesIdList;

  PaymentHistoryBlocReadyState(this.invoicesIdList);
}
