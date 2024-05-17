import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'play_pack_event.dart';
part 'play_pack_state.dart';

class PlayPackBloc extends Bloc<PlayPackEvent, PlayPackState> {
  PlayPackBloc() : super(PlayPackInitial()) {
    on<PlayPackEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
