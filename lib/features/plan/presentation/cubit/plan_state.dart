part of 'plan_cubit.dart';

abstract class PlanState extends Equatable {
  const PlanState();

  @override
  List<Object> get props => [];
}

class PlanInitial extends PlanState {}

class CourseSyncLoading extends PlanState {}

class CourseSyncSuccess extends PlanState {}

class CourseSyncError extends PlanState {
  final String error;

  const CourseSyncError(this.error);

  @override
  List<Object> get props => [error];
}

class CourseSyncEmpty extends PlanState {}

class PlanGeneratingLoading extends PlanState {}

class PlanGeneratingSuccess extends PlanState {}

class PlanGeneratingError extends PlanState {
  final String error;

  const PlanGeneratingError(this.error);

  @override
  List<Object> get props => [error];
}

class SavingPlanLoading extends PlanState {}

class SavingPlanSuccess extends PlanState {}

class SavingPlanError extends PlanState {
  final String error;

  const SavingPlanError(this.error);

  @override
  List<Object> get props => [error];
}

class DeletingPlanLoading extends PlanState {}

class DeletingPlanSuccess extends PlanState {}

class DeletingPlanError extends PlanState {
  final String error;

  const DeletingPlanError(this.error);

  @override
  List<Object> get props => [error];
}

class UpdatingPlanLoading extends PlanState {}

class UpdatingPlanSuccess extends PlanState {}

class UpdatingPlanError extends PlanState {
  final String error;

  const UpdatingPlanError(this.error);

  @override
  List<Object> get props => [error];
}

class SavingCustomPlanSuccess extends PlanState {}

class CustomCoursesUpdated extends PlanState {
  final List<Course> courses;
  const CustomCoursesUpdated(this.courses);

  @override
  List<Object> get props => [courses];
}
