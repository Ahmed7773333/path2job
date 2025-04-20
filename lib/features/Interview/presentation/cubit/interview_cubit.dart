import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path2job/hive_helper/category_hive_helper.dart';

import '../../../../core/network/gemini_helper.dart';
import '../../../../hive/category.dart';
import '../../data/models/qa_model.dart';

part 'interview_state.dart';

class InterviewCubit extends Cubit<InterviewState> {
  final GeminiHelper _gemini;

  InterviewCubit(this._gemini) : super(InterviewInitial());
  List<QA> questions = [];
  List<Categories> categories = [];

  Future<void> sync() async {
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
      emit(CategoriesSyncSuccess());
    } catch (e) {
      emit(CategoriesSyncError(e.toString()));
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
      // final qaMap = await _gemini.getInterviewQA(jobTitle);
      // final questions = qaMap.entries.map((e) => QA(e.key, e.value)).toList();
      // emit(InterviewLoaded(questions));
    } catch (e) {
      emit(InterviewError("Failed to generate questions"));
    }
  }
}
