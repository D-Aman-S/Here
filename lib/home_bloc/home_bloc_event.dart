// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc_bloc.dart';

abstract class HomeBlocEvent extends Equatable {
  const HomeBlocEvent();

  @override
  List<Object> get props => [];
}

class HomeBlocLoadEvent extends HomeBlocEvent {}

class HomeBlocLoadEventByCity extends HomeBlocEvent {
  final String city;
  const HomeBlocLoadEventByCity({
    required this.city,
  });
}
