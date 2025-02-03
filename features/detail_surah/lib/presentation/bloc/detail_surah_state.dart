import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/equatable/equatable.dart';
import 'package:quran/domain/entities/detail_surah_entity.dart';

class DetailSurahState extends Equatable {
  final ViewData<DetailSurahEntity> statusDetailSurah;
  final Map<int, String> kashmiriTranslations;

  const DetailSurahState({
    required this.statusDetailSurah,
    required this.kashmiriTranslations,
  });

  DetailSurahState copyWith({
    ViewData<DetailSurahEntity>? statusDetailSurah,
    Map<int, String>? kashmiriTranslations,
  }) {
    return DetailSurahState(
      statusDetailSurah: statusDetailSurah ?? this.statusDetailSurah,
      kashmiriTranslations: kashmiriTranslations ?? this.kashmiriTranslations,
    );
  }

  @override
  List<Object?> get props => [statusDetailSurah, kashmiriTranslations];
}
