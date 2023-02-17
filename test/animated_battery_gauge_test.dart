import 'package:animated_battery_gauge/battery_gauge.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/cupertino.dart';

void main() {
  const batteryGauge = BatteryGauge(
      size: Size(100, 60),
      value: 50,
      borderColor: CupertinoColors.systemGrey,
      valueColor: CupertinoColors.activeBlue,
      hasGauge: true,
      hasText: true);
  final testWidget =
      CupertinoApp(home: Container(child: Center(child: batteryGauge)));
  testWidgets('AnimatedBatteryGauge test ', (widgetTester) async {
    await widgetTester.pumpWidget(testWidget);
    final valueFinder = find.text('50%');
    expect(valueFinder, findsOneWidget);
  });
}
