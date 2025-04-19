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