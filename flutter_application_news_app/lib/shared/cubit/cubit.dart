import 'package:flutter/material.dart';
import 'package:flutter_application_news_app/modules/business_screen/business_screen.dart';
import 'package:flutter_application_news_app/modules/science_screen/science_screen.dart';
import 'package:flutter_application_news_app/modules/sports_screen/sports_screen.dart';
import 'package:flutter_application_news_app/shared/cubit/states.dart';
import 'package:flutter_application_news_app/shared/network/remote/dioHelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsAppStates> {
  NewsCubit() : super(InitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<String> titles = [
    "business",
    "sports",
    "science",
    "settings",
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<dynamic> businessList = [];
  List<dynamic> sportsList = [];
  List<dynamic> scienceList = [];
  List<dynamic> searchList = [];

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business_rounded),
      label: "business",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports_rounded),
      label: "sports",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science_rounded),
      label: "science",
    ),
  ];
  void changeBottomNavBar(int index) {
    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getScience();
    }
    currentIndex = index;
    emit(ChangeBottomNavBar());
  }

  void getBusiness() {
    emit(GetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '74205e539b644468bebe19d8879c4a41'
      },
    ).then((value) {
      businessList = value.data['articles'];
      print(businessList[0]['title']);//"${article['urlToImage']}"
      emit(GetBusinessSuccessState());
    }).catchError((error) {
      emit(GetBusinessErrorState(error));
      print(error);
    });
  }

  void getSports() {
    if (sportsList.length == 0) {
      emit(GetSportsLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '74205e539b644468bebe19d8879c4a41'
        },
      ).then((value) {
        sportsList = value.data['articles'];
        print(sportsList[0]['title']);
        emit(GetSportsSuccessState());
      }).catchError((error) {
        emit(GetSportsErrorState(error));
        print(error);
      });
    } else {
      GetSportsSuccessState();
    }
  }

  void getScience() {
    if(scienceList.length==0){
      emit(GetScienceLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '74205e539b644468bebe19d8879c4a41'
      },
    ).then((value) {
      scienceList = value.data['articles'];
      print(scienceList[0]['title']);
      emit(GetScienceSuccessState());
    }).catchError((error) {
      emit(GetScienceErrorState(error));
      print(error);
    });
    }
    else{
      GetScienceSuccessState();
    }
    
  }
  void getSearch(value) {
     emit(GetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca'
      },
    ).then((value) {

      searchList = value.data['articles'];
      emit(GetSearchSuccessState());
      

    }).catchError((error) {

      emit(GetSearchErrorState(error));
      print(error);
    });
    
    
  }
}
