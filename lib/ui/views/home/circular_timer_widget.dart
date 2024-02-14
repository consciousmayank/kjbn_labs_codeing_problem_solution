import 'package:flutter/material.dart';
import 'package:kjbn_labs/extensions/encapsulating_widgets.dart';
import 'package:kjbn_labs/ui/common/ui_helpers.dart';
import 'package:kjbn_labs/ui/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class CircularTimerWidget extends ViewModelWidget<HomeViewModel> {
  const CircularTimerWidget({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: screenWidth(context) / 4,
            width: screenWidth(context) / 4,
            child: CircularProgressIndicator(
              color: Theme
                  .of(context)
                  .primaryColor,
              backgroundColor: Colors.grey,
              value: (viewModel.currentTime??0) / 5,
            ),
          ).toPadding(
            padding: const EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 2,
            ),
          ),
          Text(
            viewModel.currentTime > 0 ? viewModel.currentTime.toString() : '0',
            style: Theme
                .of(context)
                .textTheme
                .headlineMedium,
          )
        ],
      ),
    );
  }
}