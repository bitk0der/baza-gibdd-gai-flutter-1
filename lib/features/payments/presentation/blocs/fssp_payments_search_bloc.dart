import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/payments/fssp_trial.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/user_data.dart';
import 'package:baza_gibdd_gai/features/payments/data/repositories/search_repository.dart';

@singleton
class FsspPaymentsSearchBloc
    extends Bloc<FsspPaymentsSearchBlocEvent, FsspPaymentsSearchBlocState> {
  final SearchRepository repository;

  FsspPaymentsSearchBloc(this.repository)
      : super(FsspPaymentsSearchBlocInitialState()) {
    // Регистрация обработчиков событий
    on<FsspPaymentsSearchBlocSearchEvent>(_onSearchEvent);
  }

  Future<void> _onSearchEvent(FsspPaymentsSearchBlocSearchEvent event,
      Emitter<FsspPaymentsSearchBlocState> emit) async {
    emit(FsspPaymentsSearchBlocLoadingState());
    try {
      final result = await repository.searchFssp(event.userData);
      emit(FsspPaymentsSearchBlocReadyState(trials: result));
    } catch (e) {
      Logger().e(e);
      emit(FsspPaymentsSearchBlocErrorState());
    }
  }
}

abstract class FsspPaymentsSearchBlocEvent {}

class FsspPaymentsSearchBlocSearchEvent extends FsspPaymentsSearchBlocEvent {
  final UserData userData;

  FsspPaymentsSearchBlocSearchEvent(this.userData);
}

abstract class FsspPaymentsSearchBlocState {}

class FsspPaymentsSearchBlocInitialState extends FsspPaymentsSearchBlocState {}

class FsspPaymentsSearchBlocLoadingState extends FsspPaymentsSearchBlocState {}

class FsspPaymentsSearchBlocErrorState extends FsspPaymentsSearchBlocState {}

class FsspPaymentsSearchBlocReadyState extends FsspPaymentsSearchBlocState {
  final List<FsspTrial> trials;

  FsspPaymentsSearchBlocReadyState({
    required this.trials,
  });
}
