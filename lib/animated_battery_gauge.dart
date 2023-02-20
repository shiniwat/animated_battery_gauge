library animated_battery_gauge;

import 'package:flutter/cupertino.dart';
import 'package:animated_battery_gauge/battery_gauge.dart';

class AnimatedBatteryGauge extends ImplicitlyAnimatedWidget {
  final double value;
  final Size size;
  final Color borderColor;
  final Color valueColor;
  final bool hasGauge;
  final bool hasText;
  final TextStyle? textStyle;

  const AnimatedBatteryGauge(
      {Key? key,
      required super.duration,
      required this.value,
      required this.size,
      required this.borderColor,
      required this.valueColor,
      this.hasGauge = true,
      this.hasText = false,
      this.textStyle})
      : super(key: key);

  @override
  createState() => _AnimatedBatteryGaugeState();
}

class _AnimatedBatteryGaugeState
    extends AnimatedWidgetBaseState<AnimatedBatteryGauge> {
  Tween<double>? _valueTween;

  @override
  void initState() {
    super.initState();
    controller
      ..value = 0.0
      ..forward().whenCompleteOrCancel(() {
        // do nothing so far.
      });
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Builder(builder: (context) {
        final drawValue = _valueTween!.evaluate(animation).clamp(
              0,
              100,
            );
        return BatteryGauge(
          size: widget.size,
          value: drawValue.toInt(),
          borderColor: widget.borderColor,
          valueColor: widget.valueColor,
          hasGauge: widget.hasGauge,
          hasText: widget.hasText,
          textStyle: widget.textStyle,
        );
      }),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _valueTween = visitor(
      _valueTween,
      widget.value,
      (dynamic value) => Tween<double>(
        begin: 0.0,
        end: widget.value,
      ),
    ) as Tween<double>;
  }
}
