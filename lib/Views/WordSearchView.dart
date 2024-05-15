import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Controllers/WordsController.dart';
import 'package:ielts_app/Widgets/InputFiled.dart';
import 'package:ielts_app/Widgets/WordCard.dart';

class WordSearchView extends StatefulWidget {
  const WordSearchView({Key? key}) : super(key: key);

  @override
  State<WordSearchView> createState() => _WordSearchViewState();
}

class _WordSearchViewState extends State<WordSearchView> {

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
        title: const Text("Search Words"),
      ),
      body: GetBuilder<WordsController>(
        builder: (controller)
        {
          return Padding(
            padding:  EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputField(
                    controller: controller.searchController,
                    hintText: "Enter Text To Search",
                    labelText: "Search",
                    preIcon: const Icon(Icons.search),
                  focusNode: _focusNode,
                  onChanged: (val)
                  {
                      controller.getSearchWords();
                  },
                ),
                Expanded(
                    child: controller.loading ? const Center(child: CircularProgressIndicator(),):
                    ListView.builder(
                        itemCount: controller.searchWords.length,
                        itemBuilder: (context, index)
                        {
                          return WordCard(
                              word: controller.searchWords[index],
                              isImportant: false,
                              isSearch: true,
                          );
                        }
                    ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
