import 'package:notes_app/Cubit/cubit.dart';

abstract class noteState {}

class noteStateIntial extends noteState {}

class noteStateSuccesss extends noteState {}

class noteStateErroe extends noteState {}

class noteStateLoading extends noteState {}

class AppCreateDatabaseState extends noteState {}

class AppDeleteDatabaseState extends noteState {}

class AppGetDatabaseState extends noteState {}

class AppGetDatabaseLoadingState extends noteState {}

class AppInsertDatabaseState extends noteState {}
