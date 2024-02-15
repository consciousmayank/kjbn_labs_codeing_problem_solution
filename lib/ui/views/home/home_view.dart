import 'package:flutter/material.dart';
import 'package:kjbn_labs/ui/common/ui_helpers.dart';
import 'package:kjbn_labs/ui/views/home/circular_timer_widget.dart';
import 'package:kjbn_labs/ui/views/home/numbers_widget.dart';
import 'package:kjbn_labs/ui/views/home/results_widget.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.prefetchData();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KJBN Labs'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: NumbersWidget(
                      bgColor: Colors.lightBlue.shade200,
                      label: 'Current Second',
                      number: viewModel.secondsNumber,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: NumbersWidget(
                      bgColor: Colors.purple.shade200,
                      label: 'Random Number',
                      number: viewModel.randomNumber,
                    ),
                  ),
                ],
              ),
              verticalSpaceLarge,
              SizedBox(
                height: screenHeight(context)/3,
                child: viewModel.isResultSuccessful != null ?
                viewModel.isResultSuccessful!
                    ? const SuccessfulResultsWidget()
                    : const UnSuccessfulResultsWidget() : const HintWidget(),
              ),
              const Spacer(),
              // if(viewModel.appStatus == Status.start)
              const CircularTimerWidget(),
              const Spacer(),
              if (viewModel.appStatus == Status.end)
                ElevatedButton(
                  onPressed: () {
                    viewModel.appStatus = Status.start;
                  },
                  child: const Text('Start'),
                ),
              if (viewModel.appStatus == Status.start)
                ElevatedButton(
                  onPressed: () {
                    viewModel.appStatus = Status.end;
                  },
                  child: const Text('Submit'),
                ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
