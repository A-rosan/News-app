import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_news_app/modules/web_view/web_view.dart';

Widget defualtButton({
  double width = double.infinity,
  double? height,
  Color color = Colors.blue,
  Color fontColor = Colors.white,
  double fontSize = 20,
  bool isUpperCase = true,
  required String text,
  required VoidCallback onPressed,
  double raduis = 0.0,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(raduis),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: fontColor,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
      ),
    );

Widget defualtTxtForm({
  //carefull
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required String? Function(String?)? validator,
  void Function(String)? onSubmitted,
  void Function()? onTap,
  void Function(String)? onChanged,

  //icons
  required IconData prefixIcon,
  IconData? suffixIcon,
  VoidCallback? suffixFunction,
  bool isClicAble = true,
  bool isRead = false,
  bool isPassword = false,
  Color iconColor = Colors.grey,
  Color textFormColor = Colors.white,

  //style
  double radius = 0,
  double labelFontSize = 16,
  FontWeight fontWeight = FontWeight.normal,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      onTap: onTap,
      enabled: isClicAble,
      validator: validator,
      obscureText: isPassword,
      readOnly: isRead,
      decoration: InputDecoration(
          fillColor: textFormColor,
          label: Text(
            label,
            style: TextStyle(
              fontSize: labelFontSize,
              fontWeight: fontWeight,
            ),
          ),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
          prefixIcon: Icon(
            prefixIcon,
            color: iconColor,
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: suffixFunction,
                  icon: Icon(
                    suffixIcon,
                    color: iconColor,
                  ),
                )
              : null),
    );
Widget articleItemsBuilder(article, context) => InkWell(
      onTap: () {
        moveTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage("assets/images/loading.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  // mainAxisSize: MainAxisSize.min,

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Expanded(
                      child: Text(
                        "${article['title']}",
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "${article['publishedAt']}",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget articleBuilder(list, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) =>
            articleItemsBuilder(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: list.length,
      ),
      fallback: (context) =>
          isSearch ? Container() : Center(child: CircularProgressIndicator()),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );

void moveTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
