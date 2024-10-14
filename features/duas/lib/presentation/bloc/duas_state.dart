part of 'duas_bloc.dart';

class DuasState extends Equatable {
  final ViewData<List<DuaEntity>> statusDua;

  const DuasState({required this.statusDua});

  DuasState copyWith({ViewData<List<DuaEntity>>? statusDua}) {
    return DuasState(statusDua: statusDua ?? this.statusDua);
  }

  @override
  List<Object?> get props => [statusDua];
}
