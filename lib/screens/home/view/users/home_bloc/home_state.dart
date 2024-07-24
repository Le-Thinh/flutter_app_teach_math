part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class VideoLoading extends HomeState {}

final class VideoSuccess extends HomeState {}

final class VideoFailure extends HomeState {}
