part of 'title_bloc.dart';

sealed class TitleState extends Equatable {
  const TitleState();

  @override
  List<Object> get props => [];
}

final class TitleInitial extends TitleState {}

final class CreateTitleProcess extends TitleState {}

final class CreateTitleSuccess extends TitleState {}

final class CreateTitleFailure extends TitleState {}
