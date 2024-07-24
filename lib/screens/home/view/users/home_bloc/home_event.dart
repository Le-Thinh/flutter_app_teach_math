part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class ViewVideoEvent extends HomeEvent {
  Views view;
  String packId;
  ViewVideoEvent(this.view, this.packId);
  @override
  List<Object> get props => [view, packId];
}

class WatchedVideoEvent extends HomeEvent {
  Watch watch;
  WatchedVideoEvent(this.watch);
  @override
  List<Object> get props => [watch];
}
