import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pack_repository/pack_repository.dart';

part 'createpack_event.dart';
part 'createpack_state.dart';

class CreatepackBloc extends Bloc<CreatepackEvent, CreatepackState> {
  final FirebasePackRepo firebasePackRepo;

  CreatepackBloc(this.firebasePackRepo) : super(CreatepackInitial()) {
    on<CreatePackFinishEvent>((event, emit) => createPack(event, emit));
    on<UploadImageEvent>((event, emit) => uploadImage(event, emit));
    on<UploadVideoEvent>((event, emit) => uploadVideo(event, emit));
  }

  void createPack(
      CreatePackFinishEvent event, Emitter<CreatepackState> emit) async {
    emit(CreatepackProcess());
    try {
      await firebasePackRepo.createPack(event.pack);
      emit(CreatepackSuccess());
    } catch (e) {
      print("Error: " + e.toString());
      emit(CreatepackFailure());
    }
  }

  void uploadImage(
      UploadImageEvent event, Emitter<CreatepackState> emit) async {
    try {
      String? imageUrl = await firebasePackRepo.uploadImage();
      if (imageUrl != null) {
        emit(CreatePackImageUploaded(imageUrl));
        event.onUploadComplete(imageUrl);
      }
    } catch (e) {
      print("Error upload Image: " + e.toString());
      emit(CreatepackFailure());
    }
  }

  void uploadVideo(
      UploadVideoEvent event, Emitter<CreatepackState> emitter) async {
    try {
      String? videoUrl = await firebasePackRepo.uploadVideo();
      if (videoUrl != null) {
        emit(CreatePackVideoUploaded(videoUrl));
        event.onUploadComplete(videoUrl);
      }
    } catch (e) {
      print("Error upload Video: " + e.toString());
      emit(CreatepackFailure());
    }
  }
}
