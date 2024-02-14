import 'dart:async';
import 'dart:math';

import 'package:kjbn_labs/app/app.locator.dart';
import 'package:kjbn_labs/services/app_data_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  /// The app data service, injected into the viewmodel using getIt.
  final IAppDataService _appData = locator<AppDataService>();

  Status _appStatus = Status.end;
  int? randomNumber;
  int? secondsNumber;
  bool? isResultSuccessful;
  Timer? _timer;
  int _currentTime = 5;

  int get currentTime => _currentTime;

  get totalCount =>
      _appData.fetchSuccessfulCount() + _appData.fetchUnSuccessfulCount();

  get successfulCount => _appData.fetchSuccessfulCount();

  get unsuccessfulCount => _appData.fetchUnSuccessfulCount() + 1;

  set currentTime(int value) {
    _currentTime = value;
    rebuildUi(); //This will cause the UI to be rebuild, helpful for timer value
  }

  Status get appStatus => _appStatus;

  set appStatus(Status value) {
    _appStatus = value;
    if (value == Status.end) {
      generateRandomNumber();
      generateSecondsNumber();
      isResultSuccessful = randomNumber == secondsNumber;
      if (isResultSuccessful!) {
        _appData.saveSuccessfulCount(
            value: _appData.fetchSuccessfulCount() + 1);
      } else {
        _appData.saveUnSuccessfulCount(
            value: _appData.fetchUnSuccessfulCount() + 1);
      }
      cancelTimer();
    } else {
      currentTime = 5;
      startTimer();
      isResultSuccessful = null;
      randomNumber = null;
      secondsNumber = null;
    }
    rebuildUi(); //This will cause the UI to be rebuild.
  }

  /// As the UI is loaded this method will fetch necessary variable values from in app Database.
  void prefetchData() {
    randomNumber = _appData.fetchRandomNumber();
    secondsNumber = _appData.fetchCurrentSecond();
    isResultSuccessful = (randomNumber == null || secondsNumber == null)
        ? null
        : randomNumber == secondsNumber;
    _currentTime = _appData.fetchTimerSecondsRemaining();
  }

  void generateRandomNumber() {
    randomNumber = Random().nextInt(51);
    _appData.saveRandomNumber(value: randomNumber!);
  }

  void generateSecondsNumber() {
    secondsNumber = DateTime.now().second;
    _appData.saveCurrentSecond(value: secondsNumber!);
  }

  void startTimer() {
    cancelTimer();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (currentTime == 0) {
          currentTime =
              -1; //If the timer get timed up, the value in {currentTime} is negative.
          _timer?.cancel();
          appStatus = Status.end;
        } else {
          currentTime--;
        }
        _appData.saveTimerSecondsRemaining(value: currentTime);
      },
    );
  }

  void cancelTimer() {
    _timer?.cancel();
  }
}

enum Status {
  start,
  end,
}
