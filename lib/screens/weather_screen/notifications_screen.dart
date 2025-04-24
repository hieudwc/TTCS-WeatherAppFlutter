import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/constants/app_colors.dart';
import 'package:weather_app_tutorial/constants/localization.dart';
import 'package:weather_app_tutorial/constants/text_styles.dart';
import 'package:weather_app_tutorial/providers/background_color_provider.dart';
import 'package:weather_app_tutorial/providers/language_provider.dart';
import 'package:weather_app_tutorial/screens/weather_screen/notification_details_screen.dart';

class WeatherNotifications extends ConsumerWidget {
  final List<String> notifications;

  const WeatherNotifications({super.key, required this.notifications});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    IconData getNotificationIcon(int index) {
      switch (index) {
        case 0:
          return Icons.thermostat_outlined; // Nhiệt độ
        case 1:
          return Icons.air_outlined; // Gió
        case 2:
          return Icons.water_drop_outlined; // Độ ẩm
        case 3:
          return Icons.wb_sunny_outlined; // Thời tiết
        default:
          return Icons.notifications_active_outlined;
      }
    }

    final currentLanguage = ref.watch(languageProvider);
    final isNightMode = ref.watch(isNightModeProvider);
    print('Notifications: $notifications');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        // Tiêu đề phần chất lượng không khí
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Localization(language: currentLanguage)
                  .translate('Weather Notification', currentLanguage),
              style:
                  isNightMode ? TextStyles.h2NightMode : TextStyles.h2DayMode,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationDetailsScreen(
                      notifications: notifications,
                    ),
                  ),
                );
              },
              child: Text(
                Localization(language: currentLanguage)
                    .translate('See Details', currentLanguage),
                style: const TextStyle(
                  color: AppColors.lightBlue,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // ...existing code...
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: isNightMode ? Colors.blueGrey[900] : Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: isNightMode
                    ? Colors.black.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: isNightMode ? Colors.blueGrey[800]! : Colors.grey[300]!,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              notifications.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isNightMode
                            ? AppColors.lightBlue.withOpacity(0.2)
                            : AppColors.lightBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        getNotificationIcon(index),
                        color: AppColors.lightBlue,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        notifications[index],
                        style: TextStyle(
                          color: isNightMode ? Colors.white : Colors.black87,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
// ...existing code...
      ],
    );
  }
}
