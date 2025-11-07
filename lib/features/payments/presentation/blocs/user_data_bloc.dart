import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/user_data.dart';
import 'package:baza_gibdd_gai/features/payments/data/repositories/sp_repository.dart';

@singleton
class UserDataBloc extends Bloc<UserDataBlocEvent, UserDataBlocState> {
  UserDataBloc({required this.spRepository})
      : super(UserDataBlocInitialState()) {
    // Регистрируем обработчики событий
    on<UserDataBlocLoadEvent>(_onLoadEvent);
    on<UserDataBlocSaveEvent>(_onSaveEvent);

    // Инициируем начальную загрузку
    add(UserDataBlocLoadEvent());
  }

  final SpRepository spRepository;

  UserData userData = UserData();

  Future<void> _onLoadEvent(
    UserDataBlocLoadEvent event,
    Emitter<UserDataBlocState> emit,
  ) async {
    userData = await spRepository.loadUserData();
    emit(UserDataBlocReadyState(userData));
  }

  Future<void> _onSaveEvent(
    UserDataBlocSaveEvent event,
    Emitter<UserDataBlocState> emit,
  ) async {
    if (event.userData != userData) {
      userData = event.userData;
      await spRepository.saveUserData(userData);
      emit(UserDataBlocReadyState(userData));
    }
  }
}

abstract class UserDataBlocEvent {}

class UserDataBlocSaveEvent extends UserDataBlocEvent {
  final UserData userData;

  UserDataBlocSaveEvent(this.userData);
}

class UserDataBlocLoadEvent extends UserDataBlocEvent {}

abstract class UserDataBlocState {}

class UserDataBlocInitialState extends UserDataBlocState {}

class UserDataBlocReadyState extends UserDataBlocState {
  final UserData userData;

  UserDataBlocReadyState(this.userData);
}
