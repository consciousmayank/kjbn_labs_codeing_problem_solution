import 'package:flutter/material.dart';
import 'package:kjbn_labs/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    final widgetHeight = (screenHeight(context) -
            kToolbarHeight -
            MediaQuery.of(context).viewPadding.top) /
        4;

    return Scaffold(
      appBar: AppBar(
        title: const Text('KJBN Labs'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              SizedBox(
                height: widgetHeight,
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        color: Colors.deepOrangeAccent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Current Seconds', style: Theme.of(context).textTheme.labelLarge,),
                            verticalSpaceSmall,
                            Text('38')
                          ],
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Card(
                        color: Colors.teal,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Random Number', style: Theme.of(context).textTheme.labelLarge,),
                            verticalSpaceSmall,
                            Text('38')
                          ],
                        ),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: widgetHeight,
                child: Container(
                  color: Colors.red.shade50,
                ),
              ),
              SizedBox(
                height: widgetHeight,
                child: Container(
                  color: Colors.purple.shade50,
                ),
              ),
              SizedBox(
                height: widgetHeight,
                child: Container(
                  color: Colors.yellow.shade50,
                ),
              ),
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