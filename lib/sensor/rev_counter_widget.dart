import 'package:bluetooth/adjust/adjust_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RevCounterWidget extends StatelessWidget {
  final double maxValue;
  final double currentValue;

  const RevCounterWidget({
    Key? key,
    required this.maxValue,
    required this.currentValue,
  }) : super(key: key);

  Color get _color {
    if (currentValue > maxValue * 0.6) {
      return Colors.red;
    }
    if (currentValue > maxValue * 0.3) {
      return Colors.orange;
    }
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AdjustProvider>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'TACÔMETRO',
          style: TextStyle(
            fontSize: 20,
            color: _color,
            fontWeight: FontWeight.bold,
          ),
        ),
        SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: maxValue + 1,
              ranges: <GaugeRange>[
                GaugeRange(
                    startValue: 0,
                    endValue: 0.3 * maxValue,
                    color: Colors.green,
                    startWidth: 10,
                    endWidth: 10),
                GaugeRange(
                    startValue: 0.3 * maxValue,
                    endValue: 0.6 * maxValue,
                    color: Colors.orange,
                    startWidth: 10,
                    endWidth: 10),
                GaugeRange(
                    startValue: 0.6 * maxValue,
                    endValue: maxValue,
                    color: Colors.red,
                    startWidth: 10,
                    endWidth: 10)
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: currentValue,
                  needleColor: _color,
                ),
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                  widget: Text(currentValue.toStringAsFixed(0),
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold)),
                  angle: 90,
                  positionFactor: 0.5,
                )
              ],
            ),
          ],
        ),
        Slider(
          value: currentValue,
          onChanged: provider.setCurrentRevCounterValue,
          min: 0,
          max: maxValue,
        ),
      ],
    );
  }
}
