import 'package:flutter/material.dart';

import 'bmi_calculator.dart';
import 'constants.dart';
import 'results_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isMale = true;
  double height = 170;
  int weight = 60;
  int age = 20;

  void _changeWeight(int delta) {
    setState(() {
      weight = (weight + delta).clamp(AppLimits.minWeight, AppLimits.maxWeight);
    });
  }

  void _changeAge(int delta) {
    setState(() {
      age = (age + delta).clamp(AppLimits.minAge, AppLimits.maxAge);
    });
  }

  void _openResults() {
    final calc = BmiCalculator(heightCm: height, weightKg: weight.toDouble());
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsPage(
          bmiResult: calc.bmiValue,
          resultText: calc.result,
          interpretation: calc.interpretation,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'BMI CALCULATOR',
          style: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: _GenderCard(
                            label: 'MALE',
                            icon: Icons.male,
                            selected: isMale,
                            onTap: () => setState(() => isMale = true),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _GenderCard(
                            label: 'FEMALE',
                            icon: Icons.female,
                            selected: !isMale,
                            onTap: () => setState(() => isMale = false),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      color: AppColors.card,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'HEIGHT',
                            style: TextStyle(
                              color: AppColors.label,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                height.round().toString(),
                                style: const TextStyle(
                                  color: AppColors.text,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                ),
                              ),
                              const Text(
                                ' cm',
                                style: TextStyle(
                                  color: AppColors.label,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Slider(
                            activeColor: AppColors.accent,
                            inactiveColor: AppColors.label,
                            value: height,
                            min: AppLimits.minHeight,
                            max: AppLimits.maxHeight,
                            onChanged: (value) {
                              setState(() => height = value);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: _ValueCard(
                            label: 'WEIGHT',
                            value: weight.toString(),
                            onDecrease: () => _changeWeight(-1),
                            onIncrease: () => _changeWeight(1),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _ValueCard(
                            label: 'AGE',
                            value: age.toString(),
                            onDecrease: () => _changeAge(-1),
                            onIncrease: () => _changeAge(1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: 80,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: AppColors.text,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              onPressed: _openResults,
              child: const Text(
                'CALCULATE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GenderCard extends StatelessWidget {
  const _GenderCard({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: selected ? AppColors.cardSelected : AppColors.card,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.text, size: 70),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.label,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ValueCard extends StatelessWidget {
  const _ValueCard({
    required this.label,
    required this.value,
    required this.onDecrease,
    required this.onIncrease,
  });

  final String label;
  final String value;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.card,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.label,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.text,
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _RoundIconButton(icon: Icons.remove, onPressed: onDecrease),
              const SizedBox(width: 12),
              _RoundIconButton(icon: Icons.add, onPressed: onIncrease),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.label,
        borderRadius: BorderRadius.circular(25),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: AppColors.text),
      ),
    );
  }
}
