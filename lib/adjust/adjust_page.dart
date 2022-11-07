import 'package:bluetooth/adjust/adjust_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdjustsPage extends StatelessWidget {
  const AdjustsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdjustProvider>(
      child: const Text('Nenhuma configuração disponível'),
      builder: (context, provider, _) {
        final String rpmText = '${provider.revCounterMaxValue} RPM';

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Valor máximo do tacômetro',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Slider(
              value: provider.revCounterMaxValue,
              min: 3000,
              max: 10000,
              divisions: 7,
              label: rpmText,
              onChanged: provider.setRevCounterMaxValue,
            ),
            Text(
              rpmText,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
}
