import 'dart:async';

import 'package:hereAssignment/home_bloc/home_bloc_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBlocBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeBlocBloc(this.homeBlockRepository) : super(HomeBlocInitial()) {
    on<HomeBlocLoadEvent>(_loadData);
    on<HomeBlocLoadEventByCity>(_loadDataCity);
  }
  final HomeBlockRepository homeBlockRepository;
  FutureOr<void> _loadData(
      HomeBlocLoadEvent event, Emitter<HomeBlocState> emit) async {
    emit(HomeBlockLoadingState());
    await homeBlockRepository.loadData();
    emit(HomeBlockLoadedState());
  }

  FutureOr<void> _loadDataCity(
      HomeBlocLoadEventByCity event, Emitter<HomeBlocState> emit) async {
    emit(HomeBlockLoadingState());
    await homeBlockRepository.loadDataByCity(city: event.city);
    emit(HomeBlockLoadedByCityState());
  }
}
