// import 'package:firebase_database/firebase_database.dart';

// class FirebaseService {
//   final DatabaseReference _database = FirebaseDatabase.instance.ref();

//   Future<void> testWriteData() async {
//     try {
//       print('Starting to write data to Firebase...');
//       // Kiểm tra kết nối
//       print('Database reference: ${_database.path}');

//       final testData = {
//         'message': 'Test connection',
//         'timestamp': DateTime.now().toString(),
//       };
//       print('Preparing to write data: $testData');

//       await _database.child('test').set(testData);
//       print('✅ Data written successfully to Firebase');
//     } catch (e) {
//       print('❌ Error writing to Firebase: $e');
//       print('Stack trace: ${StackTrace.current}');
//       rethrow; // Ném lại lỗi để có thể xử lý ở UI
//     }
//   }
// }
