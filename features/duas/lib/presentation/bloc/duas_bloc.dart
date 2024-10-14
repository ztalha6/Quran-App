import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/equatable/equatable.dart';
import 'package:quran/domain/entities/dua_entity.dart';

part 'duas_event.dart';
part 'duas_state.dart';

class DuasBloc extends Bloc<DuasEvent, DuasState> {
  DuasBloc()
      : super(
            DuasState(statusDua: ViewData.loaded(data: DuaEntity.dummyDuas))) {
    on<DuasEvent>((event, emit) {});
  }
}
