import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'horizontal_select_event.dart';
part 'horizontal_select_state.dart';

class HorizontalSelectBloc
    extends Bloc<HorizontalSelectEvent, HorizontalSelectState> {
  HorizontalSelectBloc(this.multiSelect);

  @override
  HorizontalSelectState get initialState => HorizontalSelectInitial();
  final bool multiSelect;

  List<int> selectedItems = [];

  @override
  Stream<HorizontalSelectState> mapEventToState(
    HorizontalSelectEvent event,
  ) async* {
    if (event is SelectItem) {
      if (multiSelect) {
        selectedItems.add(event.index);
        print(selectedItems);
        yield HorizontalSelectItemSelected(selectedItems);
      } else {
        yield HorizontalSelectItemSelected([event.index]);
      }
    } else if (event is UnSelectItem) {
      selectedItems.remove(selectedItems.indexOf(event.index));
      yield HorizontalSelectItemSelected(selectedItems);
    }
  }
}
