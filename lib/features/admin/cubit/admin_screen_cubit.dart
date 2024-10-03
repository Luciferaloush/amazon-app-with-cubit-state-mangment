import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'admin_screen_state.dart';

class AdminScreenCubit extends Cubit<AdminScreenState> {
  AdminScreenCubit() : super(AdminScreenInitial());

  static AdminScreenCubit get(context) => BlocProvider.of(context);

  int page = 0;

  void updatePage(int newPage) {
    page = newPage;
    emit(BottomNav());
  }


}
