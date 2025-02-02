import 'package:dependencies/equatable/equatable.dart';

class DetailSurahEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchDetailSurah extends DetailSurahEvent {
  final int id;
  final String kashmiriTranslationFilePath;

  FetchDetailSurah(
      {required this.id, required this.kashmiriTranslationFilePath});

  @override
  List<Object?> get props => [id, kashmiriTranslationFilePath];
}

class FetchKashmiriTranslation extends DetailSurahEvent {
  final String filePath;

  FetchKashmiriTranslation({required this.filePath});

  @override
  List<Object?> get props => [filePath];
}
