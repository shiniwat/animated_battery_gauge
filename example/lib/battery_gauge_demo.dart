import 'package:animated_battery_gauge/battery_gauge.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_battery_gauge/animated_battery_gauge.dart';

class BatteryGaugeDemo extends StatelessWidget {
  final bool isHorizontal;
  final bool isGrid;
  const BatteryGaugeDemo(
      {Key? key, required this.isHorizontal, required this.isGrid})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (isGrid) {
      return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Grid style Battery Gauge'),
          ),
          child: Center(
            child: AnimatedBatteryGauge(
              duration: Duration(seconds: 2),
              value: (isHorizontal) ? 60 : 42,
              size: (isHorizontal) ? Size(150, 70) : Size(70, 150),
              borderColor: CupertinoColors.systemGrey,
              valueColor: (isHorizontal)
                  ? CupertinoColors.activeGreen
                  : CupertinoColors.activeBlue,
              hasText: true,
              mode: BatteryGaugePaintMode.grid,
            ),
          ));
    } else {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Animated Battery Demo'),
        ),
        child: Center(
          child: AnimatedBatteryGauge(
            duration: Duration(seconds: 2),
            value: (isHorizontal) ? 60 : 42,
            size: (isHorizontal) ? Size(150, 70) : Size(70, 150),
            borderColor: CupertinoColors.systemGrey,
            valueColor: (isHorizontal)
                ? CupertinoColors.activeGreen
                : CupertinoColors.activeBlue,
            hasText: true,
          ),
        ),
      );
    }
  }
}
