import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path2job/hive/question_answer.dart';
import 'package:path2job/hive_helper/category_hive_helper.dart';
import 'package:path2job/hive_helper/interview_hive_helper.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

import '../../../../core/network/gemini_helper.dart';
import '../../../../hive/category.dart';

part 'interview_state.dart';

class InterviewCubit extends Cubit<InterviewState> {
  final GeminiHelper _gemini;

  InterviewCubit(this._gemini) : super(InterviewInitial());
  List<Interviews> questions = [];
  List<Categories> categories = [];

  Future<void> syncCategories() async {
    try {
      emit(CategoriesSyncLoading());
      // Simulate a network call or data fetching
      if ((await CategoryHiveHelper.getAllCategories()).isEmpty) {
        await CategoryHiveHelper.syncCategoriss();
      }
      if ((await CategoryHiveHelper.getAllCategories()).isEmpty) {
        emit(CategoriesSyncEmpty());
        return;
      }
      categories = await CategoryHiveHelper.getAllCategories();
      questions.clear();
      emit(CategoriesSyncSuccess());
    } catch (e) {
      emit(CategoriesSyncError(e.toString()));
    }
  }

  Future<void> updateCategoryNumber(String category, int number) async {
    await CategoryHiveHelper.updateCategory(
      category,
      name: category,
      numberOfQuestions: number,
    );
  }

  Future<void> syncQuestions(String category) async {
    try {
      emit(InterviewLoading());
      if ((await InterviewHiveHelper.getAllInterviews()).isEmpty) {
        await InterviewHiveHelper.sync();
      }
      if ((await InterviewHiveHelper.getAllInterviews())
          .where((element) => element.category == category)
          .toList()
          .isEmpty) {
        emit(QuestionSyncEmpty());
        return;
      }
      questions = (await InterviewHiveHelper.getAllInterviews())
          .where((element) => element.category == category)
          .toList();
      updateCategoryNumber(category, questions.length);
      emit(InterviewLoaded());
    } catch (e) {
      emit(InterviewError("Failed to sync questions"));
    }
  }

  Future<void> deleteCategory(String categoryKey) async {
    try {
      await CategoryHiveHelper.deleteCategory(categoryKey);

      categories = await CategoryHiveHelper.getAllCategories();
      emit(DeletingCategorySuccess());
      if (categories.isEmpty) {
        emit(CategoriesSyncEmpty());
        return;
      }
      emit(CategoriesSyncSuccess());
    } catch (e) {
      emit(DeletingCategoryError(e.toString()));
    }
  }

  Future<void> updateCategory(
    String categoryKey, {
    String? name,
    int? numberOfQuestions,
  }) async {
    try {
      emit(CategoriesUpdateLoading());
      await CategoryHiveHelper.updateCategory(
        categoryKey,
        name: name,
        numberOfQuestions: numberOfQuestions,
      );
      categories = await CategoryHiveHelper.getAllCategories();
      emit(CategoriesUpdateSuccess());
      emit(CategoriesSyncSuccess());
    } catch (e) {
      emit(CategoriesUpdateError(e.toString()));
    }
  }

  Future<void> deleteAllCategories() async {
    try {
      emit(DeletingCategorySuccess());
      await CategoryHiveHelper.clearAllCategories();
      categories = await CategoryHiveHelper.getAllCategories();
      emit(CategoriesSyncEmpty());
    } catch (e) {
      emit(DeletingCategoryError(e.toString()));
    }
  }

  Future<void> deleteAllQuestions(String wantedJob) async {
    try {
      emit(DeletingCategorySuccess());
      await InterviewHiveHelper.deleteAllInterviews(wantedJob);
      questions.clear();
      updateCategoryNumber(wantedJob, questions.length);

      emit(QuestionSyncEmpty());
    } catch (e) {
      emit(DeletingCategoryError(e.toString()));
    }
  }

  Future<void> addQuestions(Interviews question) async {
    try {
      emit(InterviewLoading());
      await InterviewHiveHelper.addInterview(question);
      questions = (await InterviewHiveHelper.getAllInterviews())
          .where((element) => element.category == question.category)
          .toList();
      updateCategoryNumber(question.category, questions.length);

      emit(InterviewLoaded());
    } catch (e) {
      emit(InterviewError(e.toString()));
    }
  }

  Future<void> deleteQuestion(String questionKey, String wantedJob) async {
    try {
      emit(InterviewLoading());
      await InterviewHiveHelper.deleteInterview(questionKey);
      questions = (await InterviewHiveHelper.getAllInterviews())
          .where((element) => element.category == wantedJob)
          .toList();
      if (questions.isEmpty) {
        emit(QuestionSyncEmpty());
        return;
      }
      updateCategoryNumber(wantedJob, questions.length);

      emit(InterviewLoaded());
    } catch (e) {
      emit(DeletingCategoryError(e.toString()));
    }
  }

  Future<void> addCategory(Categories category) async {
    try {
      emit(CategoriesSyncLoading());
      await CategoryHiveHelper.addCategory(category);
      categories = await CategoryHiveHelper.getAllCategories();
      emit(CategoriesSyncSuccess());
    } catch (e) {
      emit(CategoriesSyncError(e.toString()));
    }
  }

  Future<void> generateQuestions(String jobTitle) async {
    emit(InterviewLoading());
    try {
      final Stream<String> stream = _gemini.streamAListOfQA(jobTitle);
      final Map<String, String> generatedQuestions =
          await _gemini.collectStreamToMap(stream);
      print(generatedQuestions);
      for (var entry in generatedQuestions.entries) {
        final interview = Interviews(
          keyId: Uuid().v4(),
          question: entry.key,
          answer: entry.value,
          category: jobTitle,
        );
        InterviewHiveHelper.addInterview(interview);
        questions.add(interview);
      }
      if (questions.isEmpty) {
        emit(QuestionSyncEmpty());
        return;
      }
      updateCategoryNumber(jobTitle, questions.length);

      // final qaMap = await _gemini.getInterviewQA(jobTitle);
      // final questions = qaMap.entries.map((e) => QA(e.key, e.value)).toList();
      emit(InterviewLoaded());
    } catch (e) {
      emit(InterviewError("Failed to generate questions"));
    }
  }
}
