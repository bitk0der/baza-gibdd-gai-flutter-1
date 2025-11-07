import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/payments/fine.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/payments/tax.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/payments/trial.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/subscription.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/user_data.dart';
import 'package:baza_gibdd_gai/features/payments/data/repositories/search_repository.dart';

@singleton
class PaymentsSearchBloc
    extends Bloc<PaymentsSearchBlocEvent, PaymentsSearchBlocState> {
  PaymentsSearchBloc(this.repository)
      : super(PaymentsSearchBlocInitialState()) {
    // Регистрация обработчиков событий
    on<PaymentsSearchBlocSearchEvent>(_onSearchEvent);
  }

  final SearchRepository repository;

  List<Tax> taxes = [];
  List<Trial> trials = [];
  List<Fine> fines = [];

  Future<void> _onSearchEvent(PaymentsSearchBlocSearchEvent event,
      Emitter<PaymentsSearchBlocState> emit) async {
    emit(PaymentsSearchBlocLoadingState());
    try {
      final Map<String, dynamic> result =
          await repository.search(event.userData, event.type);
      taxes = result["taxes"];
      trials = result["trials"];
      fines = result["fines"];
      emit(PaymentsSearchBlocReadyState(
        taxes: taxes,
        trials: trials,
        fines: fines,
      ));
    } catch (e) {
      Logger().e(e);
      emit(PaymentsSearchBlocErrorState());
    }
  }
}

abstract class PaymentsSearchBlocEvent {}

class PaymentsSearchBlocSearchEvent extends PaymentsSearchBlocEvent {
  final UserData userData;
  final SubscriptionType type;
  PaymentsSearchBlocSearchEvent(this.userData, this.type);
}

abstract class PaymentsSearchBlocState {}

class PaymentsSearchBlocInitialState extends PaymentsSearchBlocState {}

class PaymentsSearchBlocLoadingState extends PaymentsSearchBlocState {}

class PaymentsSearchBlocErrorState extends PaymentsSearchBlocState {}

class PaymentsSearchBlocReadyState extends PaymentsSearchBlocState {
  final List<Tax> taxes;
  final List<Trial> trials;
  final List<Fine> fines;

  PaymentsSearchBlocReadyState({
    required this.taxes,
    required this.trials,
    required this.fines,
  });
}
