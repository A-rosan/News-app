import 'package:flutter_application_news_app/shared/appCubit/app_states.dart';
import 'package:flutter_application_news_app/shared/network/local/cash_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppInitState());
  static AppCubit get(context)=>BlocProvider.of(context);
  bool isDark=false;
  void changeToDark({bool? fromShared}){
    if(fromShared != null){
      isDark=fromShared;
    }
    else
    isDark= !isDark;
    CashHelper.setData(key:'isDark' ,value:isDark).then((value) => emit(ChangeAppMode()));
    

  }

}