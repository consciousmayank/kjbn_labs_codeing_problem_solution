import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:kjbn_labs/app/app.locator.dart';
import 'package:kjbn_labs/ui/common/app_strings.dart';
import 'package:kjbn_labs/ui/views/home/home_viewmodel.dart';

import '../helpers/test_helpers.dart';

void main() {
  HomeViewModel getModel() => HomeViewModel();

  group('HomeViewmodelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    group('incrementCounter -', () {

    });


  });
}
