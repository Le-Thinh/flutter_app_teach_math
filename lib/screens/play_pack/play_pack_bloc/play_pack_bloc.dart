import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app_teach2/repositories/view_repository.dart';

import '../../../models/view/view.dart';

part 'play_pack_event.dart';
part 'play_pack_state.dart';

class PlayPackBloc extends Bloc<PlayPackEvent, PlayPackState> {
  ViewRepository _viewRepository;

  PlayPackBloc(this._viewRepository) : super(PlayPackInitial()) {
    on<PlayPackEvent>((event, emit) {});
  }
}
