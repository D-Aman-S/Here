part of 'home_bloc_bloc.dart';

abstract class HomeBlocState extends Equatable {
  const HomeBlocState();

  @override
  List<Object> get props => [];
}

class HomeBlocInitial extends HomeBlocState {}

class HomeBlockLoadingState extends HomeBlocState {}

class HomeBlockLoadedState extends HomeBlocState {}

class HomeBlockLoadedByCityState extends HomeBlocState {}
