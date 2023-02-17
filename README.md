# animated_battery_gauge widget

Very simple to use animated battery gauge widget.

## Screenshots:
![](https://github.com/shiniwat/animated_batery_gauge/demo/animated_battery_horizontal.gif)
![](https://github.com/shiniwat/animated_batery_gauge/demo/animated_battery_vertical.gif)

## Features

Both horizontal and vertical animated widgets are supported.

## Getting started

Please see example app under example folder.

## Usage

It is as simple as using BatteryGauge or AnimatedBatteryGauge as your child widget.

```dart
Widget build(BuildContext context) {
  return CupertinoPageScaffold(
    navigationBar: CupertinoNavigationBar(
      middle: Text('Animated Battery Demo'),
    ),
    child: Center(
      child: AnimatedBatteryGauge(
        duration: Duration(seconds: 2),
        value: 60,
        size: Size(150, 70),
        borderColor: CupertinoColors.systemGrey,
        valueColor: CupertinoColors.activeGreen,
        hasText: true,
      ),
    ),
  );
}
```
