import 'package:flutter/material.dart';

class SimpleBarChart extends StatelessWidget {
  final double width;
  final double height;

  const SimpleBarChart({super.key, this.width = 200, this.height = 150});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .onInverseSurface, // Light yellow background
        borderRadius: BorderRadius.circular(10),
      ),
      child: CustomPaint(
        painter: _BarChartPainter(context),
      ),
    );
  }
}

class _BarChartPainter extends CustomPainter {
  final BuildContext context;

  _BarChartPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    Paint barPaint = Paint()..color = Theme.of(context).colorScheme.secondary;
    double barWidth = 80; // Fixed bar width
    double spacing = (size.width - 3 * barWidth) / 4; // Spacing between bars

    // Bar heights
    double height3rd = size.height * 0.4;
    double height1st = size.height * 0.78;
    double height2nd = size.height * 0.58;

    // Draw bars with rounded top edges
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(spacing, size.height - height3rd, barWidth, height3rd),
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      barPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(2 * spacing + barWidth, size.height - height1st, barWidth,
            height1st),
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      barPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(3 * spacing + 2 * barWidth, size.height - height2nd,
            barWidth, height2nd),
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      barPaint,
    );

    // Draw labels
    _drawText(canvas, "3rd", spacing + barWidth / 2,
        size.height - height3rd - 15, Colors.brown);
    _drawText(canvas, "1st", 2 * spacing + 1.5 * barWidth,
        size.height - height1st - 15, Colors.yellow[700]!);
    _drawText(canvas, "2nd", 3 * spacing + 2.5 * barWidth,
        size.height - height2nd - 15, Colors.blueGrey);
  }

  void _drawText(Canvas canvas, String text, double x, double y, Color color) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset(x - textPainter.width / 2, y));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
