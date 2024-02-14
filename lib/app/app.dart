import 'package:kjbn_labs/ui/views/home/home_view.dart';
import 'package:kjbn_labs/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:kjbn_labs/services/app_data_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    // @stacked-route
  ],
  dependencies: [
    InitializableSingleton(classType: AppDataService),
    LazySingleton(classType: NavigationService),
// @stacked-service
  ],
)
class App {}
