import 'package:flutter/material.dart';
import 'package:flutter_application_news_app/shared/component/component.dart';
import 'package:flutter_application_news_app/shared/cubit/cubit.dart';
import 'package:flutter_application_news_app/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list=NewsCubit.get(context).searchList;
          return Scaffold(
            appBar: AppBar(
              title: Text("Search"),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  //search bar 
                  child: defualtTxtForm(
                    controller: searchController,
                    type: TextInputType.text,
                    label: "Search",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Must not be empty";
                      }
                      return null;
                    },
                    onChanged: (value){
                      NewsCubit.get(context).getSearch(value);
                    },
                    prefixIcon: Icons.search,
                    radius: 20,
                  ),
                ),
                Expanded(child: articleBuilder(list,isSearch: true)),
              ],
            ),
          );
        });
  }
}
