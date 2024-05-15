part of 'createpack_bloc.dart';

sealed class CreatepackEvent extends Equatable {
  const CreatepackEvent();
}

class CreatePackFinishEvent extends CreatepackEvent {
  final Pack pack;

  const CreatePackFinishEvent(this.pack);
  @override
  List<Object> get props => [pack];
}

class UploadVideoEvent extends CreatepackEvent {
  final Function(String) onUploadComplete;

  const UploadVideoEvent(this.onUploadComplete);

  @override
  List<Object> get props => [];
}

class UploadImageEvent extends CreatepackEvent {
  final Function(String) onUploadComplete;

  const UploadImageEvent(this.onUploadComplete);

  @override
  List<Object> get props => [];
}
