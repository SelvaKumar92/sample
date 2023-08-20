import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:plateron/features/dashboard/data/model/menu.dart';
import 'package:plateron/features/dashboard/domain/repositories/menu_repository.dart';

part 'menu_list_bloc.freezed.dart';

@freezed
class MenuListEvent with _$MenuListEvent {
  const factory MenuListEvent.fetchMenuItems() = _FetchMenuItems;
}

@freezed
class MenuListState with _$MenuListState {
  const factory MenuListState() = _Initial;

  const factory MenuListState.loading() = _Loading;

  const factory MenuListState.loaded(List<Menu> menuItems) = _Loaded;

  const factory MenuListState.error() = _Error;
}

@injectable
class MenuListBloc extends Bloc<MenuListEvent, MenuListState> {
  final MenuRepository menusRepository;

  MenuListBloc(this.menusRepository) : super(const MenuListState()) {
    on<MenuListEvent>(
      (event, emit) async {
        await event.when<FutureOr<void>>(
          fetchMenuItems: () async {
            emit(const MenuListState.loading());
            final response = await menusRepository.fetchMenus();
            if (response.isSuccessful) {
              emit(MenuListState.loaded(response.content ?? []));
            } else {
              emit(const MenuListState.error());
            }
          },
        );
      },
    );
  }
}
