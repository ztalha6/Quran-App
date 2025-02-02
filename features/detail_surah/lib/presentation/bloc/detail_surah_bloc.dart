import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:quran/domain/usecases/get_detail_surah_usecase.dart';
import 'bloc.dart';

import 'dart:convert';
import 'package:flutter/services.dart';

class DetailSurahBloc extends Bloc<DetailSurahEvent, DetailSurahState> {
  final GetDetailSurahUsecase getDetailSurahUsecase;

  DetailSurahBloc({required this.getDetailSurahUsecase})
      : super(DetailSurahState(
            statusDetailSurah: ViewData.initial(),
            kashmiriTranslations: const {})) {
    on<FetchDetailSurah>(_detailSurahEvent);
    on<FetchKashmiriTranslation>(_fetchKashmiriTranslation);
  }

  void _detailSurahEvent(FetchDetailSurah event, Emitter emit) async {
    emit(state.copyWith(
        statusDetailSurah: ViewData.loading(message: 'Loading')));

    final response = await getDetailSurahUsecase.call(event.id);

    try {
      if (response.length() == 0) {
        emit(state.copyWith(
            statusDetailSurah: ViewData.noData(message: 'No Data')));
      } else {
        response.fold(
            (failure) => emit(state.copyWith(
                statusDetailSurah: ViewData.error(message: failure.message))),
            (data) {
          emit(state.copyWith(statusDetailSurah: ViewData.loaded(data: data)));

          // Trigger fetching Kashmiri translation
          add(FetchKashmiriTranslation(
              filePath: event.kashmiriTranslationFilePath));
        });
      }
    } catch (e) {
      emit(state.copyWith(
          statusDetailSurah: ViewData.error(message: e.toString())));
    }
  }

  void _fetchKashmiriTranslation(
      FetchKashmiriTranslation event, Emitter emit) async {
    try {
      final String jsonString = await rootBundle.loadString(event.filePath);
      final List<dynamic> jsonList = json.decode(jsonString);
      final Map<int, String> translations = {};

      for (var verse in jsonList) {
        final int verseNumber = int.tryParse(verse["verse"] ?? "0") ?? 0;
        final String translation = verse["translation"] ?? "";

        if (verseNumber > 0) {
          translations[verseNumber] = translation;
        }
      }

      emit(state.copyWith(kashmiriTranslations: translations));
    } catch (e) {
      emit(state.copyWith(kashmiriTranslations: {}));
    }
  }
}
