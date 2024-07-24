part of 'play_pack_bloc.dart';

sealed class PlayPackState extends Equatable {
  const PlayPackState();

  @override
  List<Object> get props => [];
}

final class PlayPackInitial extends PlayPackState {}

final class PlayPackProcess extends PlayPackState {}

final class PlayPackSuccess extends PlayPackState {}

final class PlayPackFailure extends PlayPackState {}
