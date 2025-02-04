import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/equatable/equatable.dart';
import 'package:quran/domain/entities/detail_surah_entity.dart';

class DetailSurahState extends Equatable {
  final ViewData<DetailSurahEntity> statusDetailSurah;
  final Map<int, String> kashmiriTranslations;
  final Map<int, String> urduTranslations;

  const DetailSurahState({
    required this.statusDetailSurah,
    required this.kashmiriTranslations,
    required this.urduTranslations,
  });

  DetailSurahState copyWith({
    ViewData<DetailSurahEntity>? statusDetailSurah,
    Map<int, String>? kashmiriTranslations,
    Map<int, String>? urduTranslations,
  }) {
    return DetailSurahState(
      statusDetailSurah: statusDetailSurah ?? this.statusDetailSurah,
      kashmiriTranslations: kashmiriTranslations ?? this.kashmiriTranslations,
      urduTranslations: urduTranslations ?? this.urduTranslations,
    );
  }

  @override
  List<Object?> get props =>
      [statusDetailSurah, kashmiriTranslations, urduTranslations];
}
