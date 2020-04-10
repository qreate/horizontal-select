part of 'horizontal_select_bloc.dart';

abstract class HorizontalSelectState extends Equatable {
  const HorizontalSelectState();
}

class HorizontalSelectInitial extends HorizontalSelectState {
  @override
  List<Object> get props => [];
}

class HorizontalSelectItemSelected extends HorizontalSelectState {
  final List<int> index;

  HorizontalSelectItemSelected(this.index);

  @override
  List<Object> get props => [
        index,
      ];
}
