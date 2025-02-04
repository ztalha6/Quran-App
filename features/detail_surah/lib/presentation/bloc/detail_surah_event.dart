import 'package:dependencies/equatable/equatable.dart';

class DetailSurahEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchDetailSurah extends DetailSurahEvent {
  final int id;
  final String kashmiriTranslationFilePath;
  final String urduTranslationFilePath;

  FetchDetailSurah(
      {required this.id,
      required this.kashmiriTranslationFilePath,
      required this.urduTranslationFilePath});

  @override
  List<Object?> get props =>
      [id, kashmiriTranslationFilePath, urduTranslationFilePath];
}

class FetchKashmiriTranslation extends DetailSurahEvent {
  final String filePath;

  FetchKashmiriTranslation({required this.filePath});

  @override
  List<Object?> get props => [filePath];
}

class FetchUrduTranslation extends DetailSurahEvent {
  final String filePath;

  FetchUrduTranslation({required this.filePath});

  @override
  List<Object?> get props => [filePath];
}
