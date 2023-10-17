import 'package:flutter/material.dart';
import 'package:flutter_application_news_app/modules/search_screen/search_screen.dart';
import 'package:flutter_application_news_app/shared/appCubit/app_cubit.dart';
import 'package:flutter_application_news_app/shared/component/component.dart';
import 'package:flutter_application_news_app/shared/cubit/cubit.dart';
import 'package:flutter_application_news_app/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsLayout extends StatelessWidget {
  NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          //AppBar
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex].toUpperCase()),
            actions: [
              //search icon
              IconButton(
                  onPressed: () {
                    moveTo(context, SearchScreen());
                  },
                  icon: Icon(
                    Icons.search_rounded,
                    size: 30.0,
                  )
                  ),
                  //dark mood icon
                  IconButton(
                    onPressed: (){
                      AppCubit.get(context).changeToDark();
                    },
                    icon: Icon(Icons.brightness_4_outlined
                    ),
                    ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          //Bottom Nav Bar
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItems,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}
