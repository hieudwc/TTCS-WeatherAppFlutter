import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/constants/app_colors.dart';
import 'package:weather_app_tutorial/providers/background_color_provider.dart';

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

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.notifications,
              color: isNightMode ? Colors.white : Colors.black,
              size: 22,
            ),
            const SizedBox(width: 8),
            Text(
              'Weather Notifications',
              style: TextStyle(
                color: isNightMode ? Colors.white : Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        leading: Container(
          margin: const EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
            color: isNightMode
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: isNightMode ? Colors.white : Colors.black,
              size: 18,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: currentGradient,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 90, 16, 24),
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isNightMode ? Colors.blueGrey[900] : Colors.white,
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
                  color:
                      isNightMode ? Colors.blueGrey[800]! : Colors.grey[200]!,
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
                              'Notification ${index + 1}',
                              style: TextStyle(
                                color:
                                    isNightMode ? Colors.white : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Today',
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
                        color: isNightMode ? Colors.white70 : Colors.black87,
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
                        backgroundColor: AppColors.lightBlue.withOpacity(0.1),
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
