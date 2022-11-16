import 'package:dartz/dartz.dart';
import 'package:graphz/core/util/customizable_date_time.dart';
import 'package:intl/intl.dart';

import '../errors/failure.dart';

class InputDateConverter {
  Either<Failure, String> parseDateToString(DateTime inputDate) {
    final DateTime yearAgo =
        CustomizableDateTime.current.subtract(Duration(days: 365));
    try {
      if (inputDate.difference(yearAgo).inDays >= 0) {
        String yearMonthDay = DateFormat("yyyy-MM-dd").format(inputDate);
        return Right(yearMonthDay);
      } else {
        throw Exception();
      }
    } on Exception {
      return Left(InvalidDateFailure());
    }
  }
}

class InvalidDateFailure extends Failure {}
