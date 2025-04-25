import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/constants/app_colors.dart';
import 'package:weather_app_tutorial/constants/localization.dart';
import 'package:weather_app_tutorial/providers/background_color_provider.dart';
import 'package:weather_app_tutorial/providers/language_provider.dart';

class NotificationDetailsScreen extends ConsumerWidget {
  final List<String> notifications;

  const NotificationDetailsScreen({
    super.key,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNightMode = ref.watch(isNightModeProvider);
    final currentGradient = ref.watch(backgroundGradientProvider);
    final currentLanguage = ref.watch(languageProvider);
    return Scaffold(
      // Match the AirQualityDetailsScreen settings
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: currentGradient,
            ),
          ),
          child: Column(
            children: [
              // Custom AppBar in SafeArea (similar to AirQualityDetailsScreen)
              Container(
                height: 60,
                color: currentGradient.first.withOpacity(0.9),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color:
                            isNightMode ? Colors.white : AppColors.accentBlue,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Expanded(
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.notifications,
                              color: isNightMode
                                  ? Colors.white
                                  : AppColors.accentBlue,
                              size: 22,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              Localization(language: currentLanguage).translate(
                                  'Weather Notification', currentLanguage),
                              style: TextStyle(
                                color: isNightMode
                                    ? Colors.white
                                    : AppColors.accentBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Placeholder to balance with back button
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              // Divider line (matching AirQualityDetailsScreen)
              Container(
                height: 2,
                color: Colors.red.withOpacity(0.7),
              ),

              // Notifications list (main content)
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color:
                            isNightMode ? Colors.blueGrey[900] : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: isNightMode
                                ? Colors.black.withOpacity(0.2)
                                : Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            spreadRadius: 1,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: isNightMode
                              ? Colors.blueGrey[800]!
                              : Colors.grey[200]!,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              _buildIconContainer(isNightMode),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${Localization(language: currentLanguage).translate('Notification', currentLanguage)} ${index + 1}',
                                      style: TextStyle(
                                        color: isNightMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      Localization(language: currentLanguage)
                                          .translate('Today', currentLanguage),
                                      style: TextStyle(
                                        color: isNightMode
                                            ? Colors.white60
                                            : Colors.black54,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.circle,
                                size: 10,
                                color: AppColors.lightBlue,
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isNightMode
                                  ? Colors.blueGrey[800]!.withOpacity(0.3)
                                  : Colors.grey[100]!,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isNightMode
                                    ? Colors.blueGrey[700]!
                                    : Colors.grey[300]!,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              notifications[index],
                              style: TextStyle(
                                color: isNightMode
                                    ? Colors.white70
                                    : Colors.black87,
                                fontSize: 15,
                                height: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                backgroundColor:
                                    AppColors.lightBlue.withOpacity(0.1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Details',
                                style: TextStyle(
                                  color: AppColors.lightBlue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconContainer(bool isNightMode) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.lightBlue.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.notifications_active_outlined,
        color: AppColors.lightBlue,
        size: 22,
      ),
    );
  }
}
