import 'package:flutter/material.dart';

extension EncapsulatingWidgets on Widget{
  Widget toCard({
    Color? cardColor,
  }) {
    return Card(
      color: cardColor,
      child: this,
    );
  }

  Padding toPadding({
    EdgeInsets? padding,
  }) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 15,),
      child: this,
    );
  }
}
