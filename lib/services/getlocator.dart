import 'package:geolocator/geolocator.dart';

Future<Position> getLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Kiểm tra dịch vụ vị trí đã bật chưa
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Dịch vụ vị trí không được bật');
  }

  // Kiểm tra quyền truy cập vị trí
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Quyền truy cập vị trí bị từ chối');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception('Quyền truy cập vị trí bị từ chối vĩnh viễn');
  }

  // Lấy vị trí hiện tại
  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}
