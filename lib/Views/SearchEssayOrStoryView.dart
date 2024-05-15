import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Controllers/ReadingController.dart';
import 'package:ielts_app/Widgets/EssayCard.dart';
import 'package:ielts_app/Widgets/SlangCard.dart';

import '../Models/EssayModel.dart';
import '../Widgets/InputFiled.dart';
import '../Widgets/ProverbIdiomCard.dart';

class SearchEssayOrStoryView extends StatefulWidget {
  final String title;
  const SearchEssayOrStoryView({Key? key, required this.title}) : super(key: key);

  @override
  State<SearchEssayOrStoryView> createState() => _SearchEssayOrStoryViewState();
}

class _SearchEssayOrStoryViewState extends State<SearchEssayOrStoryView> {

  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),

      ),
      body: GetBuilder<ReadingController>(
        builder: (controller)
        {
          int length = 0;
          List<Essay> data = [];
          if(widget.title == "Essay")
            {
              length = controller.searchEssays.length;
              data = controller.searchEssays;
            }
          else if(widget.title == "Story")
            {
              length = controller.searchStories.length;
              data = controller.searchStories;
            }
          else if(widget.title == "Article")
            {
              length = controller.searchArticles.length;
              data = controller.searchArticles;
            }
          return Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              children: [
                InputField(
                  controller: controller.searchController,
                  hintText: "Enter Text To Search ${widget.title} title",
                  labelText: "Search",
                  preIcon: const Icon(Icons.search),
                  focusNode: _focusNode,
                  onChanged: (val)
                  {
                    if(widget.title == "Essay")
                      {
                        controller.getSearchEssays();
                      }
                    else if(widget.title == "Story")
                      {
                        controller.getSearchVerbs();
                      }
                    else if(widget.title == "Article")
                      {
                        controller.getSearchArticles();
                      }
                  },
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: length,
                      itemBuilder: (context, index)
                      {
                        return EssayCard(
                          essay: data[index],
                          isSearch: true,
                          isEssay: widget.title == "Essay" ? true : false,
                          isStory: widget.title == "Essay" ? false : true,
                          isArticle: widget.title == "Article" ? true : false,
                        );
                      }
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
