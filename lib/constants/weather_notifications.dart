List<String> generateWeatherNotifications({
  required double temperature,
  required double windSpeed,
  required double humidity,
  required String weatherCondition,
}) {
  List<String> notifications = [];

  // Thông báo dựa trên nhiệt độ
  if (temperature < 30) {
    notifications.add(
        'Dễ bị cảm lạnh trong thời tiết này. Nhớ áp dụng các biện pháp phòng ngừa.');
  } else if (temperature > 35) {
    notifications
        .add('Thời tiết nóng, hãy uống đủ nước và tránh ra ngoài trời nắng.');
  } else {
    notifications.add('Thời tiết dễ chịu, hãy tận hưởng ngày hôm nay!');
  }

  // Thông báo dựa trên tốc độ gió
  if (windSpeed > 3) {
    notifications.add('Hãy cẩn trọng khi lái xe trong thời tiết này.');
  } else {
    notifications.add('Gió nhẹ, thời tiết dễ chịu.');
  }

  // Thông báo dựa trên độ ẩm
  if (humidity > 80) {
    notifications.add('Thời tiết ẩm ướt, hãy chuẩn bị áo mưa khi ra ngoài.');
  } else {
    notifications.add('Độ ẩm hợp lý');
  }

  // Thông báo dựa trên điều kiện thời tiết
  if (weatherCondition.contains('rain')) {
    notifications.add('Thời tiết xấu không nên đi câu cá. Chú ý an toàn!');
  } else if (weatherCondition.contains('clear')) {
    notifications.add('Thời tiết trung bình cho chuyến bay.');
  }

  return notifications;
}
