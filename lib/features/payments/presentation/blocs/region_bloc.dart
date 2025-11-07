import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/fsin_model.dart';
import 'package:baza_gibdd_gai/features/payments/data/repositories/fsin_repository.dart';

@injectable
class RegionBloc extends Bloc<RegionBlocEvent, RegionBlocState> {
  final FsinRepository repository;
  RegionBloc({required this.repository}) : super(RegionBlocInitialState()) {
    on<RegionBlocInitialEvent>(_initialEventHandler);
    on<RegionBlocSearchEvent>(_searchEventHandler);
    on<RegionBlocUpdateEvent>(_updateEventHandler);
    add(RegionBlocInitialEvent());
  }
  List<Fsin> fsinList = [];
  List<String> suggestions = [];

  FutureOr<void> _updateEventHandler(event, emit) async {
    emit(RegionBlocLoadingState());
    try {
      await Future.delayed(const Duration(milliseconds: 250));
      emit(RegionBlocUpdateReadyState());
    } catch (e) {
      emit(RegionBlocErrorState());
    }
  }

  FutureOr<void> _initialEventHandler(event, emit) async {
    emit(RegionBlocLoadingState());
    try {
      fsinList = await repository.loadFsin();
      suggestions = fsinList.map<String>((e) => e.region).toSet().toList();
      suggestions.sort((a, b) => a.compareTo(b));

      emit(RegionBlocReadyState(suggestions));
    } catch (e) {
      emit(RegionBlocErrorState());
    }
  }

  FutureOr<void> _searchEventHandler(RegionBlocSearchEvent event, emit) {
    suggestions = fsinList.map<String>((e) => e.region).toSet().toList();
    suggestions = suggestions
        .where((element) =>
            element.toLowerCase().contains(event.text.toLowerCase()))
        .toList();
    suggestions.sort((a, b) => a.compareTo(b));
    emit(RegionBlocReadyState(suggestions));
  }
}

abstract class RegionBlocEvent {}

class RegionBlocInitialEvent extends RegionBlocEvent {}

class RegionBlocUpdateEvent extends RegionBlocEvent {}

class RegionBlocSearchEvent extends RegionBlocEvent {
  final String text;
  RegionBlocSearchEvent(this.text);
}

abstract class RegionBlocState {}

class RegionBlocInitialState extends RegionBlocState {}

class RegionBlocLoadingState extends RegionBlocState {}

class RegionBlocUpdateReadyState extends RegionBlocState {}

class RegionBlocReadyState extends RegionBlocState {
  final List<String> regions;
  RegionBlocReadyState(this.regions);
}

class RegionBlocErrorState extends RegionBlocState {}
