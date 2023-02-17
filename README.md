
Very simple to use animated battery gauge widget

## Features

Both horizontal and vertical animated widgets are supported.

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

## Output

Some images will be put later.