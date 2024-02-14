import 'package:flutter/material.dart';
import 'package:kjbn_labs/extensions/encapsulating_widgets.dart';
import 'package:kjbn_labs/ui/common/ui_helpers.dart';

class NumbersWidget extends StatelessWidget {
  final Color bgColor;
  final String label;
  final int? number;

  const NumbersWidget({
    required this.bgColor,
    required this.label,
    required this.number,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge,),
        verticalSpaceSmall,
        Text(number!=null ? number.toString() : '--')
      ],
    ).toPadding().toCard(cardColor: bgColor);
  }
}
