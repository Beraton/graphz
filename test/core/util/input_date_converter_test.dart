import 'package:clock/clock.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphz/core/util/customizable_date_time.dart';
import 'package:graphz/core/util/input_date_converter.dart';

void main() {
  late InputDateConverter inputDateConverter;

  setUp(() {
    inputDateConverter = InputDateConverter();
  });

  group("parseDateToYearMonthDay", () {
    test("should return a Failure when the date is older than one year", () {
      // declaring some old date that should trigger a failure
      final DateTime oldTestDate = DateTime(2000, 1, 1);
      final result = inputDateConverter.parseDateToYearMonthDay(oldTestDate);
      expect(result, Left(InvalidDateFailure()));
    });
    test("should return a date string in a format yyyy-MM-dd", () {
      // setting up current DateTime to 2000-10-10 for testing purposes
      CustomizableDateTime.customTime = DateTime(2000, 10, 10);
      final DateTime testDate = DateTime(2000, 1, 1);
      final result = inputDateConverter.parseDateToYearMonthDay(testDate);
      expect(result, const Right("2000-01-01"));
    });
  });
}
