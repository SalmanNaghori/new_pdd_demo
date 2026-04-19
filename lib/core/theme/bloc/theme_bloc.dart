import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pdd_demo/core/storage/local_storage_service.dart';

// EVENTS
abstract class ThemeEvent {}
class LoadThemeEvent extends ThemeEvent {}
class ToggleThemeEvent extends ThemeEvent {
  final bool isDark;
  ToggleThemeEvent({required this.isDark});
}

// STATES
class ThemeState {
  final ThemeMode themeMode;
  ThemeState({required this.themeMode});
}

// BLOC
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final LocalStorageService localStorageService;

  ThemeBloc({required this.localStorageService}) : super(ThemeState(themeMode: ThemeMode.system)) {
    on<LoadThemeEvent>((event, emit) {
      final isDark = localStorageService.getThemeIsDark();
      if (isDark != null) {
        emit(ThemeState(themeMode: isDark ? ThemeMode.dark : ThemeMode.light));
      } else {
        emit(ThemeState(themeMode: ThemeMode.light)); // default
      }
    });

    on<ToggleThemeEvent>((event, emit) async {
      await localStorageService.setThemeDark(event.isDark);
      emit(ThemeState(themeMode: event.isDark ? ThemeMode.dark : ThemeMode.light));
    });
  }
}

