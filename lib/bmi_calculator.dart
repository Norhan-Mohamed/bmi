import 'dart:math';

class BmiCalculator {
  BmiCalculator({required this.heightCm, required this.weightKg})
      : _bmi = weightKg / pow(heightCm / 100, 2);

  final double heightCm;
  final double weightKg;
  final double _bmi;

  String get bmiValue => _bmi.toStringAsFixed(1);

  String get result {
    if (_bmi >= 25) {
      return 'Overweight';
    }
    if (_bmi >= 18.5) {
      return 'Normal';
    }
    return 'Underweight';
  }

  String get interpretation {
    if (_bmi >= 25) {
      return 'You have a higher than normal body weight. Try to exercise more.';
    }
    if (_bmi >= 18.5) {
      return 'You have a normal body weight. Good job!';
    }
    return 'You have a lower than normal body weight. You can eat a bit more.';
  }
}
