// Mocks generated by Mockito 5.3.0 from annotations
// in graphz/test/weather/presentation/bloc/weather_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:graphz/core/errors/failure.dart' as _i6;
import 'package:graphz/core/usecases/usecase.dart' as _i8;
import 'package:graphz/features/weather/domain/entities/weather_list.dart'
    as _i7;
import 'package:graphz/features/weather/domain/repositories/weather_repository.dart'
    as _i2;
import 'package:graphz/features/weather/domain/usecases/get_full_year_weather.dart'
    as _i4;
import 'package:graphz/features/weather/domain/usecases/get_weekly_weather.dart'
    as _i9;
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

class _FakeWeatherRepository_0 extends _i1.SmartFake
    implements _i2.WeatherRepository {
  _FakeWeatherRepository_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [GetFullYearWeather].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetFullYearWeather extends _i1.Mock
    implements _i4.GetFullYearWeather {
  MockGetFullYearWeather() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.WeatherRepository get repository => (super.noSuchMethod(
          Invocation.getter(#repository),
          returnValue:
              _FakeWeatherRepository_0(this, Invocation.getter(#repository)))
      as _i2.WeatherRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.WeatherList>> call(
          _i8.NoParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue:
                  _i5.Future<_i3.Either<_i6.Failure, _i7.WeatherList>>.value(
                      _FakeEither_1<_i6.Failure, _i7.WeatherList>(
                          this, Invocation.method(#call, [params]))))
          as _i5.Future<_i3.Either<_i6.Failure, _i7.WeatherList>>);
}

/// A class which mocks [GetWeeklyWeather].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWeeklyWeather extends _i1.Mock implements _i9.GetWeeklyWeather {
  MockGetWeeklyWeather() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.WeatherRepository get repository => (super.noSuchMethod(
          Invocation.getter(#repository),
          returnValue:
              _FakeWeatherRepository_0(this, Invocation.getter(#repository)))
      as _i2.WeatherRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.WeatherList>> call(
          _i8.NoParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue:
                  _i5.Future<_i3.Either<_i6.Failure, _i7.WeatherList>>.value(
                      _FakeEither_1<_i6.Failure, _i7.WeatherList>(
                          this, Invocation.method(#call, [params]))))
          as _i5.Future<_i3.Either<_i6.Failure, _i7.WeatherList>>);
}
