import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../errors/failure.dart';

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

abstract class UseCase<List, Params> {
  Future<Either<Failure, List>> call(Params params);
}
