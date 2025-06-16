import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path2job/hive/recent_acitivty.dart';
import 'package:path2job/hive_helper/course_hive_helper.dart';

import '../../../../hive_helper/recent_activity_helper.dart';
import '../../../../hive_helper/user_hive_helper.dart';

part 'home_layout_state.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeLayoutInitial());
  List<RecentAcitivty> recentActivities = [];
  bool isSub = (UserHiveHelper.getUser()?.isSub ?? false);
  Future<void> sync() async {
    try {
      emit(HomeLayoutLoading());
      // Simulate a network call or data fetching
      if ((await CourseHiveHelper.getAllCourses()).isEmpty) {
        await CourseHiveHelper.syncCourses();
      }
      emit(HomeLayoutSuccess());
    } catch (e) {
      emit(HomeLayoutError(message: e.toString()));
    }
  }

  Future<void> upgrade() async {
    try {
      emit(HomeLayoutLoading());
      // Simulate a network call or data fetching
      UserHiveHelper.updateUser(
          UserHiveHelper.getUser()!.CopyWith(isSub: true));
      isSub = true;
      emit(HomeLayoutSuccess());
    } catch (e) {
      emit(HomeLayoutError(message: e.toString()));
    }
  }

  Future<void> getAllActivties() async {
    try {
      emit(RecentAcitivtyLoading());
      // Simulate a network call or data fetching
      recentActivities = await RecentActivityHelper.getAllActivities();
      if (recentActivities.isEmpty) {
        emit(RecentAcitivtyEmpty());
        return;
      }

      emit(RecentAcitivtySuccess());
    } catch (e) {
      emit(HomeLayoutError(message: e.toString()));
    }
  }
}
