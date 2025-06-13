import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:path2job/features/home%20layout%20hr/data/models/candidate_model.dart';
import 'package:path2job/hive/favs.dart';
import 'package:path2job/hive_helper/favs_helper.dart';

import '../../../../core/routes/routes.dart';
import '../../../../hive/recent_acitivty.dart';
import '../../../../hive_helper/recent_activity_helper.dart';

part 'home_layout_hr_event.dart';
part 'home_layout_hr_state.dart';

class HomeLayoutHrBloc extends Bloc<HomeLayoutHrEvent, HomeLayoutHrState> {
  List<CandidateModel> cndiadates = fakeCandidates;
  List<FavoritModel> favorites = [];
  HomeLayoutHrBloc() : super(HomeLayoutHrInitial()) {
    on<HomeLayoutHrEvent>((event, emit) async {
      if (event is SearchEvent) {
        emit(HomeLayoutHrloading());
        RecentActivityHelper.addRecentActivity(RecentAcitivty(
            name: 'Search for Candidates',
            time: DateTime.now(),
            icon: Icons.search.codePoint));
        if (event.keyWord.isNotEmpty) {
          cndiadates = fakeCandidates
              .where((test) =>
                  test.skills!.contains(event.keyWord) ||
                  test.job!.toLowerCase().contains(event.keyWord.toLowerCase()))
              .toList();
        } else
          cndiadates = fakeCandidates;
        emit(HomeLayoutHrloaded());
      }
      if (event is AddFavoriteEvent) {
        emit(HomeLayoutHrloading());
        final candidate = fakeCandidates.firstWhere((e) => e.id == event.id);
        RecentActivityHelper.addRecentActivity(RecentAcitivty(
            name: 'Add ${candidate.name} To Golden Choices',
            time: DateTime.now(),
            route: Routes.favorite,
            icon: Icons.star.codePoint));
        FavsHiveHelper.addFavs(candidate.id);
        emit(HomeLayoutHrloaded());
      }
      if (event is GetAllFavoriteEvent) {
        emit(HomeLayoutHrloading());
        favorites = await FavsHiveHelper.getAllFavss();
        emit(HomeLayoutHrloaded());
      }
      if (event is DeleteFavoriteEvent) {
        emit(HomeLayoutHrloading());
        final candidate = fakeCandidates.firstWhere((e) => e.id == event.id);
        RecentActivityHelper.addRecentActivity(RecentAcitivty(
            name: 'Remove ${candidate.name} from Golden Choices',
            time: DateTime.now(),
            route: Routes.favorite,
            icon: Icons.delete.codePoint));
        FavsHiveHelper.deleteFavs(candidate.id);
        emit(HomeLayoutHrloaded());
      }
    });
  }
}
