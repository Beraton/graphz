// Mocks generated by Mockito 5.3.0 from annotations
// in graphz/test/weather/domain/usecases/get_weekly_weather_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:graphz/core/errors/failure.dart' as _i5;
import 'package:graphz/features/weather/domain/entities/weather_list.dart'
    as _i6;
import 'package:graphz/features/weather/domain/repositories/weather_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [WeatherRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeatherRepository extends _i1.Mock implements _i3.WeatherRepository {
  MockWeatherRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.WeatherList>> getWeeklyWeather() =>
      (super.noSuchMethod(Invocation.method(#getWeeklyWeather, []),
              returnValue:
                  _i4.Future<_i2.Either<_i5.Failure, _i6.WeatherList>>.value(
                      _FakeEither_0<_i5.Failure, _i6.WeatherList>(
                          this, Invocation.method(#getWeeklyWeather, []))))
          as _i4.Future<_i2.Either<_i5.Failure, _i6.WeatherList>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.WeatherList>> getFullYearWeather() =>
      (super.noSuchMethod(Invocation.method(#getFullYearWeather, []),
              returnValue:
                  _i4.Future<_i2.Either<_i5.Failure, _i6.WeatherList>>.value(
                      _FakeEither_0<_i5.Failure, _i6.WeatherList>(
                          this, Invocation.method(#getFullYearWeather, []))))
          as _i4.Future<_i2.Either<_i5.Failure, _i6.WeatherList>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.WeatherList>> getSelectedDayWeather(
          String? selectedDay) =>
      (super.noSuchMethod(Invocation.method(#getSelectedDayWeather, [selectedDay]),
              returnValue:
                  _i4.Future<_i2.Either<_i5.Failure, _i6.WeatherList>>.value(
                      _FakeEither_0<_i5.Failure, _i6.WeatherList>(
                          this,
                          Invocation.method(
                              #getSelectedDayWeather, [selectedDay]))))
          as _i4.Future<_i2.Either<_i5.Failure, _i6.WeatherList>>);
}
