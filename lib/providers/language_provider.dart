import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppLanguage { en, vn }

final languageProvider = StateProvider<AppLanguage>((ref) => AppLanguage.en);
