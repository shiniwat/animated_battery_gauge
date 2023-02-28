# animated_battery_gauge widget

Very simple to use animated battery gauge widget.

## Screenshots
- Horizontal gauge mode
![](https://github.com/shiniwat/animated_battery_gauge/blob/main/demo/animated_battery_horizontal.gif)
- Vertical gauge mode
![](https://github.com/shiniwat/animated_battery_gauge/blob/main/demo/animated_battery_vertical.gif)
- Horizontal grid mode
![](https://github.com/shiniwat/animated_battery_gauge/blob/main/demo/animated_grid_mode_horizontal.gif)

## Features

- Both animated and static widgets exist. AnimatedBatteryGauge is animated version, and BatteryGauge is non-animated version.
- Both horizontal and vertical widgets are supported. See screenshot above.
- Starting from version 0.2.0, the widget takes mode parameter, which takes BatteryGaugePaintMode. You can take either gauge, grid, or none as the mode parameter.

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
        mode: BatteryGaugePaintMode.gauge,
        hasText: true,
      ),
    ),
  );
}
```
