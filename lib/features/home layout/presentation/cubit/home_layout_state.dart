part of 'home_layout_cubit.dart';

abstract class HomeLayoutState extends Equatable {
  const HomeLayoutState();

  @override
  List<Object> get props => [];
}

class HomeLayoutInitial extends HomeLayoutState {}

class HomeLayoutLoading extends HomeLayoutState {}

class HomeLayoutSuccess extends HomeLayoutState {}

class HomeLayoutError extends HomeLayoutState {}

class RecentAcitivtyEmpty extends HomeLayoutState {}
class RecentAcitivtySuccess extends HomeLayoutState {}
class RecentAcitivtyLoading extends HomeLayoutState {}
class RecentAcitivtyError extends HomeLayoutState {}

