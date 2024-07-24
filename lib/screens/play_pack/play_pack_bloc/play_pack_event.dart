part of 'play_pack_bloc.dart';

sealed class PlayPackEvent extends Equatable {
  const PlayPackEvent();

  @override
  List<Object> get props => [];
}

class ViewEvent extends PlayPackEvent {
  Views view;
  ViewEvent(this.view);
  @override
  List<Object> get props => [view];
}
