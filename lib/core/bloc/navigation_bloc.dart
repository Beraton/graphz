import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:graphz/features/weather/presentation/widgets/util/weather_sorting_utils.dart';

import '../../features/weather/domain/entities/weather_list.dart';
import '../../features/weather/presentation/routes/router.gr.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final AppRouter appRouter;

  NavigationBloc({required this.appRouter}) : super(Initial()) {
    on<NavigationPushPage>((event, emit) {
      emit(Initial());
      appRouter.push(DetailsRoute(
          pageId: event.paramType.index, paramType: event.paramType));
      print("Triggered push route from NavigationBloc");
      emit(Updated());
    });
    on<NavigationPreviousPage>((event, emit) {
      emit(Initial());
      AutoRouter.of(event.context).pop();
      print("Triggered pop route from NavigationBloc");
      emit(Updated());
    });
  }
}
