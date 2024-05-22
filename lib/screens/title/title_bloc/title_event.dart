part of 'title_bloc.dart';

sealed class TitleEvent extends Equatable {
  title _title;
  TitleEvent(this._title);

  @override
  List<Object> get props => [_title];
}
