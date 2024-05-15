part of 'createpack_bloc.dart';

sealed class CreatepackState extends Equatable {
  final String imageFileName;
  final String videoFileName;

  const CreatepackState({this.imageFileName = "", this.videoFileName = ""});

  @override
  List<Object> get props => [imageFileName, videoFileName];
}

final class CreatepackInitial extends CreatepackState {}

final class CreatepackSuccess extends CreatepackState {}

final class CreatepackProcess extends CreatepackState {}

final class CreatepackFailure extends CreatepackState {}

final class CreatePackImageUploaded extends CreatepackState {
  final String imageUrl;

  const CreatePackImageUploaded(this.imageUrl);

  @override
  List<Object> get props => [imageUrl];
}

final class CreatePackVideoUploaded extends CreatepackState {
  final String videoUrl;

  const CreatePackVideoUploaded(this.videoUrl);

  @override
  List<Object> get props => [videoUrl];
}
