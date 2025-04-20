part of 'interview_cubit.dart';

abstract class InterviewState extends Equatable {
  const InterviewState();

  @override
  List<Object> get props => [];
}

class InterviewInitial extends InterviewState {}

class InterviewLoading extends InterviewState {}

class InterviewLoaded extends InterviewState {
  final List<QA> questions;
  InterviewLoaded(this.questions);
}

class InterviewError extends InterviewState {
  final String message;
  InterviewError(this.message);
}

class CategoriesSyncError extends InterviewState {
  final String message;
  CategoriesSyncError(this.message);
}

class CategoriesSyncLoading extends InterviewState {}

class CategoriesSyncSuccess extends InterviewState {}

class CategoriesSyncEmpty extends InterviewState {}

class DeletingCategorySuccess extends InterviewState {}

class DeletingCategoryError extends InterviewState {
  final String message;
  DeletingCategoryError(this.message);
}
class CategoriesUpdateLoading extends InterviewState {}
class CategoriesUpdateSuccess extends InterviewState {}
class CategoriesUpdateError extends InterviewState {
  final String message;
  CategoriesUpdateError(this.message);
}