import 'package:get_it/get_it.dart';

import '../router/app_router.dart';

/// Service locator global aplikasi PorsiPas.
final GetIt sl = GetIt.instance;

bool _isInitialized = false;

/// Menginisialisasi seluruh dependensi core dan fitur secara idempoten.
Future<void> initDependencies() async {
  if (_isInitialized) {
    return;
  }

  if (!sl.isRegistered<AppRouter>()) {
    sl.registerLazySingleton<AppRouter>(
      AppRouter.new,
      dispose: (router) => router.dispose(),
    );
  }

  // Extension points untuk fase berikutnya:
  // - Phase 2: Drift AppDatabase, MasterDataAssetSeeder, FoodCatalogRepository
  // - Phase 3: FirebaseAuth, FirebaseFirestore, AuthRepository, AuthBloc
  // - Phase 4: ProfileRepository, MifflinStJeorCalculator, ProfileBloc
  // - Phase 5: NutritionCalculatorEngine, CalculatorBloc
  // - Phase 6: FoodDiaryRepository, FoodDiaryBloc
  // - Phase 7: DashboardBloc, WaterTrackerRepository, IsiPiringkuAnalyzer

  _isInitialized = true;
}

/// Mengatur ulang service locator (terutama untuk isolasi unit/widget test).
Future<void> resetDependencies() async {
  await sl.reset();
  _isInitialized = false;
}
