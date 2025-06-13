part of 'home_layout_hr_bloc.dart';

abstract class HomeLayoutHrState extends Equatable {
  const HomeLayoutHrState();

  @override
  List<Object> get props => [];
}

class HomeLayoutHrInitial extends HomeLayoutHrState {}

class HomeLayoutHrloading extends HomeLayoutHrState {}

class HomeLayoutHrloaded extends HomeLayoutHrState {}
