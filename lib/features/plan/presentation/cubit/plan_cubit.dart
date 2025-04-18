import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path2job/core/network/gemini_helper.dart';
import 'package:path2job/hive/course.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../hive_helper/course_hive_helper.dart';

part 'plan_state.dart';

class PlanCubit extends Cubit<PlanState> {
  PlanCubit() : super(PlanInitial());
  static PlanCubit get(context) => BlocProvider.of(context);
  List<String> generatedCourses = [];
  List<Course> planCourses = [];
  List<Course> customCourses = [];
  Future<void> sync() async {
    try {
      emit(CourseSyncLoading());
      // Simulate a network call or data fetching
      if ((await CourseHiveHelper.getAllCourses()).isEmpty) {
        await CourseHiveHelper.syncCourses();
      }
      if ((await CourseHiveHelper.getAllCourses()).isEmpty) {
        emit(CourseSyncEmpty());
        return;
      }
      planCourses = await CourseHiveHelper.getAllCourses();
      emit(CourseSyncSuccess());
    } catch (e) {
      emit(CourseSyncError(e.toString()));
    }
  }

  Future<void> deleteCourse(String courseKey) async {
    try {
      emit(DeletingPlanLoading());
      // Simulate a network call or data fetching
      await CourseHiveHelper.deleteCourse(courseKey);
      planCourses = await CourseHiveHelper.getAllCourses();
      emit(DeletingPlanSuccess());
      if (planCourses.isEmpty) {
        emit(CourseSyncEmpty());
        return;
      }
      emit(CourseSyncSuccess());
    } catch (e) {
      emit(DeletingPlanError(e.toString()));
    }
  }

  Future<void> deleteAllCourses() async {
    try {
      emit(DeletingPlanLoading());
      // Simulate a network call or data fetching
      await CourseHiveHelper.clearAllCourses();
      planCourses = await CourseHiveHelper.getAllCourses();
      emit(DeletingPlanSuccess());
      emit(CourseSyncEmpty());
    } catch (e) {
      emit(DeletingPlanError(e.toString()));
    }
  }

  Future<void> updateCourse(Course course) async {
    try {
      emit(UpdatingPlanLoading());
      // Simulate a network call or data fetching
      await CourseHiveHelper.updateCourse(
        course.courseName!,
        link: course.link,
        name: course.courseName,
        description: course.courseDescription,
        numberOfVideos: course.numberOfvideos,
        numberOfvideosDone: course.numberOfvideosDone,
      );
      planCourses = await CourseHiveHelper.getAllCourses();
      emit(UpdatingPlanSuccess());
      emit(CourseSyncSuccess());
    } catch (e) {
      emit(UpdatingPlanError(e.toString()));
    }
  }

  Future<void> generatePlan(String wantedJob) async {
    try {
      emit(PlanGeneratingLoading());
      // Simulate a network call or data fetching
      final Stream<String> stream = GeminiHelper().streamAPlan(wantedJob);
      generatedCourses = await GeminiHelper().collectStreamToList(stream);
      if (generatedCourses.isEmpty) {
        emit(PlanGeneratingError("No courses found"));
        return;
      }

      debugPrint("Generated courses: $generatedCourses");
      emit(PlanGeneratingSuccess());
    } catch (e) {
      emit(PlanGeneratingError(e.toString()));
    }
  }

  Future<void> addCourse(Course course) async {
    try {
      emit(SavingPlanLoading());
      // Simulate a network call or data fetching
      await CourseHiveHelper.addCourse(course);
      emit(SavingPlanSuccess());
      planCourses = await CourseHiveHelper.getAllCourses();
      emit(CourseSyncSuccess());
    } catch (e) {
      emit(SavingPlanError(e.toString()));
    }
  }

  Future<void> launchUrll(String url) async {
    try {
      // if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
      // }
    } catch (e) {
      emit(PlanGeneratingError('Could not launch URL'));
    }
  }

  Future<void> savePlan() async {
    try {
      emit(SavingPlanLoading());
      // Simulate a network call or data fetching
      for (var course in generatedCourses) {
        await CourseHiveHelper.addCourse(Course(
          courseName: course.split('|')[0].trim(),
          courseDescription: '',
          link: course.split('|')[1].trim(),
          numberOfvideos: 0,
          numberOfvideosDone: 0,
        ));
      }
      emit(SavingPlanSuccess());
    } catch (e) {
      emit(SavingPlanError(e.toString()));
    }
  }

  void addCustomCourse(Course course) {
    try {
      emit(SavingPlanLoading());
      customCourses.add(course);
      emit(CustomCoursesUpdated(customCourses)); // New state
    } catch (e) {
      emit(SavingPlanError(e.toString()));
    }
  }

  deleteCustomPlan() {
    try {
      emit(DeletingPlanLoading());
      customCourses.clear();
      emit(DeletingPlanSuccess());
    } catch (e) {
      emit(DeletingPlanError(e.toString()));
    }
  }

  deleteCustomCourse(Course course) {
    try {
      emit(DeletingPlanLoading());
      customCourses.remove(course);
      emit(DeletingPlanSuccess());
    } catch (e) {
      emit(DeletingPlanError(e.toString()));
    }
  }

  saveCustomPlan() {
    try {
      emit(SavingPlanLoading());
      for (var course in customCourses) {
        CourseHiveHelper.addCourse(course);
      }
      emit(SavingCustomPlanSuccess());
    } catch (e) {
      emit(SavingPlanError(e.toString()));
    }
  }
}
