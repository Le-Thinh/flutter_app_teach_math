part of 'title_bloc.dart';

sealed class TitleEvent extends Equatable {
  const TitleEvent();

  @override
  List<Object> get props => [];
}

class CreateTitle extends TitleEvent {
  final title Title;
  const CreateTitle(this.Title);

  @override
  List<Object> get props => [Title];
}
