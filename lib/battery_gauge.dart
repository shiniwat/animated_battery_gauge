library animated_battery_gauge;

import 'package:flutter/cupertino.dart';

enum BatteryGaugePaintMode {
  gauge,
  grid,
  none,
}

class BatteryGauge extends StatefulWidget {
  final Size size;
  final int value;
  final Color borderColor;
  final Color valueColor;
  final BatteryGaugePaintMode mode;
  final bool hasText;
  final TextStyle? textStyle;
  final bool drawBarForExtraValue;
  const BatteryGauge(
      {Key? key,
      required this.size,
      required this.value,
      required this.borderColor,
      required this.valueColor,
      this.mode = BatteryGaugePaintMode.gauge,
      this.hasText = false,
      this.textStyle,
      this.drawBarForExtraValue = false})
      : super(key: key);

  @override
  createState() => _BatteryGaugeState();
}

class _BatteryGaugeState extends State<BatteryGauge> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final margin = widget.size.width * 0.04 * 2;
    final isHorizontal = widget.size.width >= widget.size.height;
    return SizedBox(
      width: (isHorizontal) ? widget.size.width + margin : widget.size.width,
      height: (isHorizontal) ? widget.size.height : widget.size.height + margin,
      child: Stack(
        children: [
          CustomPaint(
            size: widget.size,
            painter: _BatteryGaugePainter(
                value: widget.value,
                borderColor: widget.borderColor,
                valueColor: widget.valueColor,
                mode: widget.mode,
                drawBarForExtraValue: widget.drawBarForExtraValue),
          ),
          if (widget.hasText)
            Positioned(
              child: Center(
                child: Text('${widget.value.toString()}%',
                    style: widget.textStyle ??
                        CupertinoTheme.of(context).textTheme.textStyle),
              ),
            ),
        ],
      ),
    );
  }
}

class _BatteryGaugePainter extends CustomPainter {
  final int value;
  final Color borderColor;
  final Color valueColor;
  final BatteryGaugePaintMode mode;
  final bool drawBarForExtraValue;

  const _BatteryGaugePainter(
      {required this.value,
      required this.borderColor,
      required this.valueColor,
      required this.mode,
      required this.drawBarForExtraValue})
      : super();

  @override
  void paint(Canvas canvas, Size size) {
    double stroke = size.width * 0.04;
    final isHorizontal = size.width >= size.height;

    var paintBorder = Paint()
      ..color = borderColor
      ..shader
      ..strokeWidth = stroke
      ..style = PaintingStyle.stroke;
    var paintValue = Paint()
      ..color = valueColor
      ..shader
      ..style = PaintingStyle.fill;

    final margin = stroke * 2;
    // render battery rect and connector
    if (isHorizontal) {
      // render battery rect
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height),
            Radius.circular(size.width * 0.05)),
        paintBorder,
      );

      /// plus connector
      canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(size.width, size.height * 0.333, stroke * 2,
                size.height * 0.333),
            Radius.circular(size.width * 0.02)),
        paintBorder,
      );
    } else {
      // vertical
      // render battery rect
      canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(0, margin, size.width, size.height),
            Radius.circular(size.width * 0.05)),
        paintBorder,
      );

      /// plus connector
      canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(
                size.width * 0.333, 0, size.width * 0.333, stroke * 2),
            Radius.circular(size.width * 0.02)),
        paintBorder,
      );
    }

    // render value
    switch (mode) {
      case BatteryGaugePaintMode.none:
      case BatteryGaugePaintMode.gauge:
        if (isHorizontal) {
          // render value
          canvas.drawRRect(
            RRect.fromRectAndRadius(
                Rect.fromLTWH(0, 0, size.width * value / 100, size.height),
                Radius.circular(size.width * 0.05)),
            paintValue,
          );
        } else {
          // render value
          final margin = stroke * 2;
          canvas.drawRRect(
            RRect.fromRectAndRadius(
                Rect.fromLTWH(
                    0,
                    margin + size.height - size.height * value / 100,
                    size.width,
                    size.height * value / 100),
                Radius.circular(size.width * 0.05)),
            paintValue,
          );
        }
        break;

      case BatteryGaugePaintMode.grid:
        var paintInactive = Paint()
          ..color = CupertinoColors.systemGrey5
          ..shader
          ..style = PaintingStyle.fill;
        var numBar = value ~/ 10;
        if (drawBarForExtraValue && value.toInt() % 10 > 0) {
          numBar++;
        }
        final list = _getRectList(size, value, stroke);
        for (int i = 0; i < list.length; i++) {
          canvas.drawRect(list[i], (i < numBar) ? paintValue : paintInactive);
        }
        break;
    }

    if (mode == BatteryGaugePaintMode.gauge) {
      // draw gauge
      var paintGauge = Paint()
        ..color = CupertinoColors.systemGrey2
        ..shader
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke;
      if (isHorizontal) {
        for (var i = 1; i < 5; i++) {
          var offset1 = Offset(size.width / 5 * i, size.height / 10);
          var offset2 = Offset(size.width / 5 * i, size.height / 10 * 9);
          canvas.drawLine(offset1, offset2, paintGauge);
        }
      } else {
        final margin = stroke * 2;
        for (var i = 1; i < 5; i++) {
          var offset1 = Offset(size.width / 10, margin + size.height / 5 * i);
          var offset2 =
              Offset(size.width / 10 * 9, margin + size.height / 5 * i);
          canvas.drawLine(offset1, offset2, paintGauge);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  List<Rect> _getRectList(Size size, int value, double stroke) {
    var list = <Rect>[];
    const margin = 2.0;
    if (size.width >= size.height) {
      final barWidth = (size.width - margin * 11 - stroke * 2) / 10;
      for (int i = 0; i < 10; i++) {
        final offset = stroke + (i + 1) * margin + i * barWidth;
        final rect = Rect.fromLTRB(offset, stroke + margin, offset + barWidth,
            size.height - stroke - margin);
        list.add(rect);
      }
    } else {
      final connectorHeight = stroke * 2;
      final barHeight = (size.height - margin * 11 - stroke * 2) / 10;
      for (int i = 0; i < 10; i++) {
        final bottomOffset = size.height -
            connectorHeight -
            stroke -
            (i + 1) * margin -
            (i - 1) * barHeight;
        final rect = Rect.fromLTRB(stroke + margin, bottomOffset - barHeight,
            size.width - stroke - margin, bottomOffset);
        list.add(rect);
      }
    }
    return list;
  }
}
