import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/invoice.dart';
import 'package:baza_gibdd_gai/features/payments/data/repositories/search_repository.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/blocs/payment_history_bloc.dart';

@singleton
class InvoiceSearchBloc
    extends Bloc<InvoiceSearchBlocEvent, InvoiceSearchBlocState> {
  final SearchRepository repository;
  final PaymentHistoryBloc historyBloc;

  InvoiceSearchBloc(this.repository, this.historyBloc)
      : super(InvoiceSearchBlocInitialState()) {
    // Регистрация обработчиков событий
    on<InvoiceSearchBlocSearchEvent>(_onSearchEvent);
    on<InvoiceSearchBlocLocalSearchEvent>(_onLocalSearchEvent);
    on<_InvoiceSearchBlocDeleteEvent>(_onDeleteEvent);

    // Подписка на события истории платежей
    historyBloc.stream.listen((state) {
      if (state is PaymentHistoryBlocSavedState) {
        add(InvoiceSearchBlocSearchEvent(state.invoicesIdList));
      } else if (state is PaymentHistoryBlocDeletedState) {
        add(_InvoiceSearchBlocDeleteEvent(state.invoiceId));
      }
    });
  }

  List<Invoice> invoices = [];

  // Обработчик события поиска
  Future<void> _onSearchEvent(InvoiceSearchBlocSearchEvent event,
      Emitter<InvoiceSearchBlocState> emit) async {
    invoices = [];
    try {
      invoices =
          await repository.getInvoiceInfo(invoiceId: event.invoicesIdList);
    } catch (e) {
      Logger().e(e);
      emit(InvoiceSearchBlocErrorState());
    } finally {
      // Обработка удаления из истории
      for (var invoice in invoices) {
        if (invoice.deleteFromHistory) {
          historyBloc.add(PaymentHistoryBlocDeleteEvent(invoice.id));
        }
      }
      invoices.removeWhere((element) => element.deleteFromHistory);
      emit(InvoiceSearchBlocReadyState(invoices));
    }
  }

  // Обработчик события локального поиска
  Future<void> _onLocalSearchEvent(InvoiceSearchBlocLocalSearchEvent event,
      Emitter<InvoiceSearchBlocState> emit) async {
    List<Invoice> result = [];
    invoices.forEach((invoice) {
      for (var element in invoice.toPayElements) {
        if (element.purpose
                .toLowerCase()
                .contains(event.request.toLowerCase()) ||
            element.commission
                .toString()
                .contains(event.request.toLowerCase())) {
          result.add(invoice);
          break;
        }
      }
    });
    if (result.isNotEmpty) {
      emit(InvoiceSearchBlocReadyState(result));
    } else {
      emit(InvoiceSearchBlocReadyState(invoices));
    }
  }

  // Обработчик события удаления
  Future<void> _onDeleteEvent(_InvoiceSearchBlocDeleteEvent event,
      Emitter<InvoiceSearchBlocState> emit) async {
    invoices.removeWhere((element) => element.id == event.invoiceId);
    emit(InvoiceSearchBlocReadyState(invoices));
  }
}

abstract class InvoiceSearchBlocEvent {}

class InvoiceSearchBlocSearchEvent extends InvoiceSearchBlocEvent {
  final List<String> invoicesIdList;

  InvoiceSearchBlocSearchEvent(this.invoicesIdList);
}

class _InvoiceSearchBlocDeleteEvent extends InvoiceSearchBlocEvent {
  final String invoiceId;

  _InvoiceSearchBlocDeleteEvent(this.invoiceId);
}

class InvoiceSearchBlocLocalSearchEvent extends InvoiceSearchBlocEvent {
  final String request;

  InvoiceSearchBlocLocalSearchEvent(this.request);
}

abstract class InvoiceSearchBlocState {}

class InvoiceSearchBlocInitialState extends InvoiceSearchBlocState {}

class InvoiceSearchBlocLoadingState extends InvoiceSearchBlocState {}

class InvoiceSearchBlocErrorState extends InvoiceSearchBlocState {}

class InvoiceSearchBlocReadyState extends InvoiceSearchBlocState {
  final List<Invoice> invoices;

  InvoiceSearchBlocReadyState(this.invoices);
}
