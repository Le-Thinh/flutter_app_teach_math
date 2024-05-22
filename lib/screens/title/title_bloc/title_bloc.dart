import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_teach2/models/thumbnail/model.dart';
import 'package:flutter_app_teach2/models/thumbnail/title.dart';
import 'package:flutter_app_teach2/repositories/tile_repository.dart';

part 'title_event.dart';
part 'title_state.dart';

class TitleBloc extends Bloc<TitleEvent, TitleState> {
  TitleRepository _titleRepository;

  TitleBloc(this._titleRepository) : super(TitleInitial()) {
    on<TitleEvent>(createTitle);
  }

  void createTitle(TitleEvent event, Emitter<TitleState> emit) async {
    emit(CreateTitleProcess());
    try {
      await _titleRepository.setDataTitle(event._title);
    } catch (e) {
      print("Error creating title: " + e.toString());
      emit(CreateTitleFailure());
    }
  }
}
