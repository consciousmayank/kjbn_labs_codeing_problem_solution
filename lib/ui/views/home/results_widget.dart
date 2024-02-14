import 'package:flutter/material.dart';
import 'package:kjbn_labs/extensions/encapsulating_widgets.dart';
import 'package:kjbn_labs/ui/common/ui_helpers.dart';
import 'package:kjbn_labs/ui/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SuccessfulResultsWidget extends ViewModelWidget<HomeViewModel> {
  const SuccessfulResultsWidget({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) => SizedBox(
        width: screenWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Success :)',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            verticalSpaceSmall,
            Text(
              '${viewModel.successfulCount}/${viewModel.successfulCount + viewModel.unsuccessfulCount}',
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        )
            .toPadding(
              padding: const EdgeInsets.symmetric(
                vertical: 40,
              ),
            )
            .toCard(cardColor: Colors.green),
      );
}

class UnSuccessfulResultsWidget extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel viewModel) => SizedBox(
        width: screenWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              viewModel.currentTime >= 0
                  ? 'Sorry try Again!'
                  : 'Sorry! timeout and one attempt is considered for failure as penalty',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ).toPadding(padding: const EdgeInsets.only(left: 8, right: 8,),),
            verticalSpaceSmall,
            Text(
              '${viewModel.unsuccessfulCount}/${viewModel.unsuccessfulCount + viewModel.successfulCount}',
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        )
            .toPadding(
              padding: const EdgeInsets.symmetric(
                vertical: 40,
              ),
            )
            .toCard(cardColor: Colors.yellow),
      );
}
