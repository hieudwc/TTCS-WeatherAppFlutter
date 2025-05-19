List<int> getDtTimeVN(DateTime VNDate) {
  final startofDayVN = DateTime(VNDate.year, VNDate.month, VNDate.day, 0, 0, 0);
  final endofDayVN =
      DateTime(VNDate.year, VNDate.month, VNDate.day, 23, 59, 59);
  final startofDayUTC = startofDayVN.toUtc();
  final endofDayUTC = endofDayVN.toUtc();

  final startDT = startofDayUTC.millisecondsSinceEpoch ~/ 1000;
  final endDT = endofDayUTC.millisecondsSinceEpoch ~/ 1000;

  return [startDT, endDT];
}
