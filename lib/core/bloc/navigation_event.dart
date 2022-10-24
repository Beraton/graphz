part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigationPushPage extends NavigationEvent {
  final ParamType paramType;

  NavigationPushPage(this.paramType);
}

class NavigationPreviousPage extends NavigationEvent {
  final BuildContext context;

  NavigationPreviousPage(this.context);
}
