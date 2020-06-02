import 'package:farma_reagente/components/future_builder_handler.dart';
import 'package:farma_reagente/constants/styles.dart';
import 'package:flutter/material.dart';

import 'custom_title.dart';

class CustomCheckboxType<T> {
  String label;
  T element;

  CustomCheckboxType(
    this.label,
    this.element,
  );
}

class CustomCheckBoxList<T> extends StatefulWidget {
  final String label;
  final Future<List<CustomCheckboxType<T>>> values;
  final Map<int, bool> checkedValues;

  const CustomCheckBoxList({
    Key key,
    @required this.label,
    @required this.values,
    @required this.checkedValues,
  }) : super(key: key);

  @override
  _CustomCheckBoxListState createState() => _CustomCheckBoxListState();
}

class _CustomCheckBoxListState<T> extends State<CustomCheckBoxList<T>> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Styles.paddingVerticalSymmetric,
      child: FutureBuilderHandler(
        future: widget.values,
        done: (data) => _done(context, data, widget.checkedValues),
      ),
    );
  }

  Widget _done(BuildContext context, List<CustomCheckboxType> values, Map<int, bool> checkedValues) {
    return Column(
      children: <Widget>[
        CustomTitle(text: widget.label),
        Scrollbar(
          child: Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[700])),
            ),
            height: _getHeight(values),
            child: ListView.builder(
              itemCount: values.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    CheckboxListTile(
                      title: Text(values[index].label),
                      value: checkedValues[values[index].element.id] ?? false,
                      onChanged: (bool value) {
                        setState(() => checkedValues[values[index].element.id] = value);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  double _getHeight(List<CustomCheckboxType> values) {
    if (values.isEmpty) {
      return 8.0;
    } else if (values.length <= 3) {
      return values.length * 56.0;
    } else {
      return 196.0;
    }
  }
}
