import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:path2job/hive/question_answer.dart';
import 'package:path2job/hive_helper/category_hive_helper.dart';
import 'package:path2job/hive_helper/interview_hive_helper.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/network/gemini_helper.dart';
import '../../../../core/routes/routes.dart';
import '../../../../hive/category.dart';
import '../../../../hive/recent_acitivty.dart';
import '../../../../hive_helper/recent_activity_helper.dart';

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
      RecentActivityHelper.addRecentActivity(RecentAcitivty(
          name: 'Delete All Questions at $wantedJob',
          route: Routes.interview,
          time: DateTime.now(),
          icon: Icons.delete.codePoint));
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
      RecentActivityHelper.addRecentActivity(RecentAcitivty(
          name: 'Add Question',
          route: Routes.interview,
          time: DateTime.now(),
          icon: Icons.add_card.codePoint));
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
      RecentActivityHelper.addRecentActivity(RecentAcitivty(
          name: 'Delete Question',
          route: Routes.interview,
          time: DateTime.now(),
          icon: Icons.delete.codePoint));
      await InterviewHiveHelper.deleteInterview(questionKey);
      await CategoryHiveHelper.updateCategory(wantedJob,
          numberOfQuestions:
              (CategoryHiveHelper.getCategory(wantedJob)?.numberOfQuestions ??
                      1) -
                  1);
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
      RecentActivityHelper.addRecentActivity(RecentAcitivty(
          name: 'Add Category',
          route: Routes.interview,
          time: DateTime.now(),
          icon: Icons.save.codePoint));
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
      RecentActivityHelper.addRecentActivity(RecentAcitivty(
          name: 'Generate Question with AI',
          route: Routes.interview,
          time: DateTime.now(),
          icon: Icons.auto_awesome.codePoint));
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
