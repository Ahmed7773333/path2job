// ignore_for_file: must_be_immutable

part of 'home_layout_hr_bloc.dart';

abstract class HomeLayoutHrEvent extends Equatable {
  const HomeLayoutHrEvent();

  @override
  List<Object> get props => [];
}

class SearchEvent extends HomeLayoutHrEvent {
  SearchEvent(this.keyWord);
  String keyWord;
}

class AddFavoriteEvent extends HomeLayoutHrEvent {
  int id;
  AddFavoriteEvent(this.id);
}

class DeleteFavoriteEvent extends HomeLayoutHrEvent {
  int id;
  DeleteFavoriteEvent(this.id);
}

class GetAllFavoriteEvent extends HomeLayoutHrEvent {}
