import 'package:dependencies/equatable/equatable.dart';

class DuaEntity extends Equatable {
  final String name;
  final String content;

  const DuaEntity({required this.name, required this.content});

  @override
  List<Object?> get props => [name, content];

  static List<DuaEntity> dummyDuas = [
    DuaEntity(name: 'Dua 1', content: 'No data found!'),
    DuaEntity(name: 'Dua 2', content: 'No data found!'),
    DuaEntity(name: 'Dua 3', content: 'No data found!'),
    DuaEntity(name: 'Dua 4', content: 'No data found!'),
    DuaEntity(name: 'Dua 5', content: 'No data found!'),
    DuaEntity(name: 'Dua 6', content: 'No data found!'),
    DuaEntity(name: 'Dua 7', content: 'No data found!'),
    DuaEntity(name: 'Dua 8', content: 'No data found!'),
    DuaEntity(name: 'Dua 9', content: 'No data found!'),
    DuaEntity(name: 'Dua 10', content: 'No data found!'),
  ];
}
