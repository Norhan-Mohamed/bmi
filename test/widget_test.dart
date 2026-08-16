import 'package:bmi/bmi_calculator.dart';
import 'package:bmi/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BmiCalculator', () {
    test('classifies underweight correctly', () {
      final calc = BmiCalculator(heightCm: 170, weightKg: 45);
      expect(calc.result, 'Underweight');
      expect(double.parse(calc.bmiValue), lessThan(18.5));
    });

    test('classifies normal weight correctly', () {
      final calc = BmiCalculator(heightCm: 170, weightKg: 65);
      expect(calc.result, 'Normal');
    });

    test('classifies overweight correctly', () {
      final calc = BmiCalculator(heightCm: 170, weightKg: 90);
      expect(calc.result, 'Overweight');
      expect(double.parse(calc.bmiValue), greaterThanOrEqualTo(25));
    });

    test('uses consistent boundary at 18.5', () {
      final calc = BmiCalculator(heightCm: 100, weightKg: 18.5);
      expect(calc.result, 'Normal');
      expect(calc.interpretation.contains('normal body weight'), isTrue);
    });
  });

  testWidgets('home screen loads and opens results', (tester) async {
    await tester.pumpWidget(const BmiApp());

    expect(find.text('BMI CALCULATOR'), findsOneWidget);
    expect(find.text('HEIGHT'), findsOneWidget);
    expect(find.text('CALCULATE'), findsOneWidget);

    await tester.tap(find.text('CALCULATE'));
    await tester.pumpAndSettle();

    expect(find.text('Your Result'), findsOneWidget);
    expect(find.text('RE-CALCULATE'), findsOneWidget);

    await tester.tap(find.text('RE-CALCULATE'));
    await tester.pumpAndSettle();

    expect(find.text('CALCULATE'), findsOneWidget);
  });

  testWidgets('gender selection updates selected card', (tester) async {
    await tester.pumpWidget(const BmiApp());

    await tester.tap(find.text('FEMALE'));
    await tester.pump();
    await tester.tap(find.text('MALE'));
    await tester.pump();

    expect(find.text('MALE'), findsOneWidget);
    expect(find.text('FEMALE'), findsOneWidget);
  });

  testWidgets('weight buttons change displayed value', (tester) async {
    await tester.pumpWidget(const BmiApp());

    expect(find.text('60'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add).first);
    await tester.pump();
    expect(find.text('61'), findsOneWidget);
  });
}
