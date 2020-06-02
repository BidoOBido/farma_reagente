import 'package:farma_reagente/components/custom_title.dart';
import 'package:farma_reagente/components/future_builder_handler.dart';
import 'package:farma_reagente/constants/styles.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final int value;
  final Future<List<DropdownMenuItem<int>>> items;
  final void Function(int) onChanged;

  const CustomDropdown({
    Key key,
    @required this.label,
    @required this.value,
    @required this.items,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Styles.paddingVerticalSymmetric,
      child: FutureBuilderHandler(
        future: items,
        done: (data) => _done(data),
      ),
    );
  }

  Widget _done(List data) {
    return Column(
      children: <Widget>[
        CustomTitle(text: label),
        DropdownButton(
          value: value,
          items: data,
          onChanged: onChanged,
          isExpanded: true,
          underline: Container(
            height: 0.5,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
