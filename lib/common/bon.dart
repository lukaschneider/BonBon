import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class BonWidget extends StatelessWidget {
  const BonWidget({
    Key? key,
    required this.value,
    required this.description,
    required this.color,
    this.onPressed,
    this.onLongPress,
  }) : super(key: key);

  final double value;
  final String description;
  final Color color;
  final Function()? onPressed;
  final Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: MaterialButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                '${value.toStringAsFixed(2)} EUR',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: useWhiteForeground(color)
                          ? Colors.white.withOpacity(0.5)
                          : Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: useWhiteForeground(color)
                          ? Colors.white
                          : Colors.black,
                    ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
