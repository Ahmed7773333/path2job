import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/network/gemini_helper.dart';
import '../../data/models/qa_model.dart';

part 'interview_state.dart';

class InterviewCubit extends Cubit<InterviewState> {
   final GeminiHelper _gemini;

  InterviewCubit(this._gemini) : super(InterviewInitial());

  Future<void> generateQuestions(String jobTitle) async {
    emit(InterviewLoading());
    try {
      // final qaMap = await _gemini.getInterviewQA(jobTitle);
      // final questions = qaMap.entries.map((e) => QA(e.key, e.value)).toList();
      // emit(InterviewLoaded(questions));
    } catch (e) {
      emit(InterviewError("Failed to generate questions"));
    }
  }
}
