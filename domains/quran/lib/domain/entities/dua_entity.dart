import 'package:dependencies/equatable/equatable.dart';

class DuaEntity extends Equatable {
  final String name;
  final String content;

  const DuaEntity({required this.name, required this.content});

  @override
  List<Object?> get props => [name, content];

  static List<DuaEntity> dummyDuas = [
    DuaEntity(name: 'Dua 1', content: 'Content 1' * 100),
    DuaEntity(name: 'Dua 2', content: 'Content 2'),
    DuaEntity(name: 'Dua 3', content: 'Content 3'),
    DuaEntity(name: 'Dua 4', content: 'Content 4'),
    DuaEntity(name: 'Dua 5', content: 'Content 5'),
    DuaEntity(name: 'Dua 6', content: 'Content 6'),
    DuaEntity(name: 'Dua 7', content: 'Content 7'),
    DuaEntity(name: 'Dua 8', content: 'Content 8'),
    DuaEntity(name: 'Dua 9', content: 'Content 9'),
    DuaEntity(name: 'Dua 10', content: 'Content 10'),
  ];
}
