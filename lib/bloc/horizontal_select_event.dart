part of 'horizontal_select_bloc.dart';

abstract class HorizontalSelectEvent extends Equatable {
  const HorizontalSelectEvent();
}

class SelectItem extends HorizontalSelectEvent {
  final int index;

  SelectItem(this.index);
  @override
  List<Object> get props => [
        this.index,
      ];
}

class UnSelectItem extends HorizontalSelectEvent {
  final int index;

  UnSelectItem(this.index);
  @override
  List<Object> get props => [
        this.index,
      ];
}

