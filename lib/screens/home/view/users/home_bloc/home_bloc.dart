import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app_teach2/models/view/view.dart';
import 'package:flutter_app_teach2/models/watched/watch.dart';
import 'package:flutter_app_teach2/repositories/view_repository.dart';
import 'package:pack_repository/pack_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  ViewRepository _viewRepository;

  HomeBloc(this._viewRepository) : super(HomeInitial()) {
    on<ViewVideoEvent>((event, emit) => setDataView(event, emit));
    on<WatchedVideoEvent>((event, emit) => setDataWatched(event, emit));
  }

  void setDataView(ViewVideoEvent event, Emitter<HomeState> emit) async {
    emit(VideoLoading());
    try {
      await _viewRepository.setDataView(event.view, event.packId);
    } catch (e) {
      print("Error Play: " + e.toString());
      emit(VideoFailure());
    }
  }

  void setDataWatched(WatchedVideoEvent event, Emitter<HomeState> emit) async {
    emit(VideoLoading());
    try {
      await _viewRepository.setDataWatched(event.watch);
    } catch (e) {
      print("Error Play: " + e.toString());
      emit(VideoFailure());
    }
  }
}
