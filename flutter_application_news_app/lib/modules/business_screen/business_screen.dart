import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_news_app/shared/component/component.dart';
import 'package:flutter_application_news_app/shared/cubit/cubit.dart';
import 'package:flutter_application_news_app/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusinessScreen extends StatelessWidget {
   BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsAppStates>(
      listener: (context,state){},
      builder: (context,state){
        var list=NewsCubit.get(context).businessList;
        return ConditionalBuilder(
        condition:state is! GetBusinessLoadingState,
        builder: (context){
          return ListView.separated(
        itemBuilder: (context,index){
          return articleItemsBuilder(list[index],context);
        },
        separatorBuilder:(context,index)=>myDivider(),
        itemCount: list.length
        
        );
        },
        fallback: (context)=>Center(child: CircularProgressIndicator(
          color: Colors.deepOrange,
        )),
        );
      },
    );
  }
}