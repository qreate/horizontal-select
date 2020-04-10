library horizontal_select;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizontal_select/bloc/horizontal_select_bloc.dart';
import 'package:horizontal_select/model/horizontal_select_item.dart';
import 'package:horizontal_select/model/horizontal_select_style.dart';

class HorizontalSelect extends StatelessWidget {
  final List<HorizontalSelectItem> items;
  final HorizontalSelectStyle style;
  final Function(
    List<int> index,
    List<HorizontalSelectItem> item,
  ) onItemSelect;
  final ShapeBorder shapeBorder;
  final EdgeInsets itemPadding;
  final TextStyle itemTextStyle;
  final bool multiSelect;

  const HorizontalSelect({
    Key key,
    @required this.items,
    @required this.style,
    @required this.onItemSelect,
    @required this.shapeBorder,
    @required this.itemPadding,
    @required this.itemTextStyle,
    @required this.multiSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HorizontalSelectBloc(multiSelect),
      child: _HorizontalSelectWidget(
        items: items,
        style: style,
        onItemSelect: onItemSelect,
        shapeBorder: shapeBorder,
        itemPadding: itemPadding,
        itemTextStyle: itemTextStyle,
        multiSelect: multiSelect,
      ),
    );
  }
}

class _HorizontalSelectWidget extends StatelessWidget {
  final List<HorizontalSelectItem> items;
  final HorizontalSelectStyle style;
  final Function(
    List<int> index,
    List<HorizontalSelectItem> item,
  ) onItemSelect;
  final ShapeBorder shapeBorder;
  final EdgeInsets itemPadding;
  final TextStyle itemTextStyle;
  final bool multiSelect;

  _HorizontalSelectWidget({
    Key key,
    @required this.items,
    @required this.style,
    @required this.onItemSelect,
    @required this.shapeBorder,
    @required this.itemPadding,
    @required this.itemTextStyle,
    @required this.multiSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HorizontalSelectBloc horizontalSelectBloc =
        BlocProvider.of<HorizontalSelectBloc>(context);

    return BlocConsumer<HorizontalSelectBloc, HorizontalSelectState>(
      listener: (BuildContext context, HorizontalSelectState state) {
        if (state is HorizontalSelectItemSelected) {
          List<HorizontalSelectItem> selectedItems = [];
          state.index.forEach((itemIndex) {
            selectedItems.add(items[itemIndex]);
          });
          onItemSelect(
            state.index,
            selectedItems,
          );
        }
      },
      builder: (context, state) {
        return Container(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (
                BuildContext context,
                int index,
              ) {
                if (state is HorizontalSelectItemSelected) {
                  return Padding(
                    padding: itemPadding,
                    child: ActionChip(
                      shape: shapeBorder,
                      onPressed: () {
                        if (state.index.contains(index) && multiSelect) {
                          horizontalSelectBloc.add(UnSelectItem(
                            index,
                          ));
                        } else if (!state.index.contains(index)) {
                          horizontalSelectBloc.add(
                            SelectItem(
                              index,
                            ),
                          );
                        }
                      },
                      backgroundColor: state.index.contains(index)
                          ? style.selectedItemColor
                          : style.itemColor,
                      label: items[index].content != null
                          ? items[index].content
                          : Text(
                              items[index].text,
                              style: itemTextStyle,
                            ),
                    ),
                  );
                } else if (state is HorizontalSelectInitial) {
                  return Padding(
                    padding: itemPadding,
                    child: ActionChip(
                      shape: shapeBorder,
                      onPressed: () {
                        horizontalSelectBloc.add(SelectItem(
                          index,
                        ));
                      },
                      backgroundColor: style.itemColor,
                      label: items[index].content != null
                          ? items[index].content
                          : Text(
                              items[index].text,
                              style: itemTextStyle,
                            ),
                    ),
                  );
                }
                return Container();
              },
            ));
      },
    );
  }
}
