import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/alphabet_separated_list.dart';

@singleton
class RegionSearchBloc
    extends Bloc<RegionSearchBlocEvent, RegionSearchBlocState> {
  RegionSearchBloc() : super(RegionSearchBlocInitialState()) {
    // Регистрация обработчиков событий
    on<RegionSearchBlocEvent>(_onSearchEvent);
  }

  Future<void> _onSearchEvent(
      RegionSearchBlocEvent event, Emitter<RegionSearchBlocState> emit) async {
    List<AlphabetSeparatedRegions> searchResult = [];
    event.separatedRegions.forEach((element) {
      List<String> searchInSeparatedRegionsResult = [];
      for (var element in element.regions) {
        if (element.toLowerCase().contains(event.request.toLowerCase())) {
          searchInSeparatedRegionsResult.add(element);
        }
      }
      if (searchInSeparatedRegionsResult.isNotEmpty) {
        searchResult.add(AlphabetSeparatedRegions(
            letter: element.letter, regions: searchInSeparatedRegionsResult));
      }
    });
    emit(RegionSearchBlocReadyState(searchResult));
  }
}

class RegionSearchBlocEvent {
  final String request;
  final List<AlphabetSeparatedRegions> separatedRegions;

  RegionSearchBlocEvent({
    required this.request,
    required this.separatedRegions,
  });
}

abstract class RegionSearchBlocState {}

class RegionSearchBlocInitialState extends RegionSearchBlocState {}

class RegionSearchBlocReadyState extends RegionSearchBlocState {
  final List<AlphabetSeparatedRegions> searchResult;

  RegionSearchBlocReadyState(this.searchResult);
}
